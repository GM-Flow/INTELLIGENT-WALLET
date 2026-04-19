import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InflationService {
  // Use the same base URL as api_service.dart
  static const String baseUrl = 'http://192.168.10.13:8000/api/v1';

  // Get auth token
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Get authorization headers
  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // 🆕 PREDICT INFLATION - NOW USES BACKEND API
  Future<Map<String, dynamic>> predictInflationImpact({
    required Map<String, double> categorySpending,
    required double totalSpending,
  }) async {
    try {
      // Call backend overall inflation endpoint
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/inflation/overall'),
        headers: headers,
      );

      print('📊 Inflation Overall API Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final overallData = json.decode(response.body);

        // Get category trends
        final trendsResponse = await http.get(
          Uri.parse('$baseUrl/inflation/category-trends?months=6'),
          headers: headers,
        );

        Map<String, dynamic> categoryImpact = {};

        if (trendsResponse.statusCode == 200) {
          final trendsData = json.decode(trendsResponse.body);
          final categories = trendsData['categories'] as List;

          // Build category impact data
          for (var cat in categories) {
            String category = cat['category'];
            double currentSpending = categorySpending[category] ?? 0;
            double inflationRate = (cat['inflation_rate'] ?? 5.0).toDouble();
            double impact = currentSpending * (inflationRate / 100);

            categoryImpact[category] = {
              'current_spending': currentSpending,
              'inflation_rate': inflationRate,
              'predicted_increase': impact,
              'future_spending': currentSpending + impact,
            };
          }
        }

        // Calculate totals
        double totalImpact = 0.0;
        categoryImpact.forEach((key, value) {
          totalImpact += (value['predicted_increase'] as double);
        });

        return {
          'category_impact': categoryImpact,
          'total_current': totalSpending,
          'total_impact': totalImpact,
          'total_predicted': totalSpending + totalImpact,
          'average_inflation': (overallData['inflation_rate'] ?? 0.0).toDouble(),
          'usd_to_pkr': (overallData['usd_to_pkr'] ?? 280.0).toDouble(),
          'status': overallData['status'] ?? 'unknown',
          'recommendation': overallData['recommendation'] ?? '',
        };
      } else if (response.statusCode == 400) {
        // Insufficient data - return mock prediction
        print('⚠️ Insufficient data, using fallback');
        return _getMockInflationPrediction(categorySpending, totalSpending);
      } else {
        throw Exception('Failed to load inflation data: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error predicting inflation: $e');
      // Fallback to mock data if API fails
      return _getMockInflationPrediction(categorySpending, totalSpending);
    }
  }

  // 🆕 GET CATEGORY INFLATION TRENDS
  Future<Map<String, dynamic>?> getCategoryTrends({int months = 6}) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse('$baseUrl/inflation/category-trends')
          .replace(queryParameters: {'months': months.toString()});

      final response = await http.get(uri, headers: headers);

      print('📈 Category Trends API Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        print('⚠️ Insufficient data for category trends');
        return null;
      } else {
        throw Exception('Failed to get category trends: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error getting category trends: $e');
      return null;
    }
  }

  // 🆕 GET OVERALL INFLATION
  Future<Map<String, dynamic>?> getOverallInflation() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/inflation/overall'),
        headers: headers,
      );

      print('💰 Overall Inflation API Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        print('⚠️ Insufficient data for overall inflation');
        return null;
      } else {
        throw Exception('Failed to get overall inflation: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error getting overall inflation: $e');
      return null;
    }
  }

  // 🆕 GET PKR DEVALUATION
  Future<Map<String, dynamic>?> getPKRDevaluation() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/inflation/pkr-devaluation'),
        headers: headers,
      );

      print('💱 PKR Devaluation API Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get PKR devaluation: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error getting PKR devaluation: $e');
      return null;
    }
  }

  // 🆕 PREDICT INFLATION FOR SPECIFIC CATEGORY
  Future<Map<String, dynamic>?> predictCategoryInflation({
    String? category,
    int monthsAhead = 6,
  }) async {
    try {
      final headers = await _getHeaders();
      final queryParams = {
        'months_ahead': monthsAhead.toString(),
        if (category != null && category.isNotEmpty) 'category': category,
      };

      final uri = Uri.parse('$baseUrl/inflation/predict')
          .replace(queryParameters: queryParams);

      final response = await http.get(uri, headers: headers);

      print('🔮 Predict Inflation API Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        final error = json.decode(response.body);
        throw Exception(error['detail'] ?? 'Insufficient data for prediction');
      } else {
        throw Exception('Failed to predict inflation: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error predicting category inflation: $e');
      rethrow;
    }
  }

  // FALLBACK: Mock inflation prediction when backend has insufficient data
  Map<String, dynamic> _getMockInflationPrediction(
      Map<String, double> categorySpending,
      double totalSpending,
      ) {
    // Pakistan-specific inflation rates (approximate)
    Map<String, double> inflationRates = {
      'food': 28.5,       // Food inflation in Pakistan
      'rent': 12.3,       // Rental inflation
      'transport': 35.2,  // Fuel/transport inflation
      'utilities': 18.8,  // Electricity/gas inflation
      'entertainment': 8.5, // Entertainment inflation
      'healthcare': 15.0, // Healthcare inflation
      'education': 10.5,  // Education inflation
      'shopping': 14.2,   // General goods inflation
      'other': 12.0,      // Other categories
    };

    Map<String, Map<String, dynamic>> categoryImpact = {};
    double totalInflationImpact = 0.0;

    categorySpending.forEach((category, spending) {
      double rate = inflationRates[category] ?? 12.0;
      double impact = spending * (rate / 100);
      totalInflationImpact += impact;

      categoryImpact[category] = {
        'current_spending': spending,
        'inflation_rate': rate,
        'predicted_increase': impact,
        'future_spending': spending + impact,
      };
    });

    double avgInflation = totalSpending > 0
        ? (totalInflationImpact / totalSpending * 100)
        : 0.0;

    return {
      'category_impact': categoryImpact,
      'total_current': totalSpending,
      'total_impact': totalInflationImpact,
      'total_predicted': totalSpending + totalInflationImpact,
      'average_inflation': avgInflation,
      'usd_to_pkr': 280.5,
      'status': avgInflation > 10 ? 'increasing' : 'stable',
      'recommendation': avgInflation > 10
          ? '⚡ HIGH: Inflation is above 10%. Consider investing in inflation-protected assets.'
          : '✅ STABLE: Inflation is manageable. Continue monitoring your spending.',
    };
  }

  // Get investment recommendations (unchanged)
  List<Map<String, dynamic>> getInvestmentRecommendations(double availableAmount) {
    return [
      {
        'name': 'OGDC (PSX)',
        'type': 'Stock',
        'expected_return': '12-15%',
        'risk': 'Medium',
        'min_investment': 10000,
        'icon': '📈',
        'color': 0xFF0B6B43,
      },
      {
        'name': 'Gold Investment',
        'type': 'Commodity',
        'expected_return': '8-10%',
        'risk': 'Low',
        'min_investment': 5000,
        'icon': '💰',
        'color': 0xFFFFAA00,
      },
      {
        'name': 'UBL Fund',
        'type': 'Mutual Fund',
        'expected_return': '10-12%',
        'risk': 'Low-Medium',
        'min_investment': 1000,
        'icon': '🏦',
        'color': 0xFF00C192,
      },
      {
        'name': 'PPL (PSX)',
        'type': 'Stock',
        'expected_return': '10-13%',
        'risk': 'Medium',
        'min_investment': 8000,
        'icon': '📊',
        'color': 0xFF4ECDC4,
      },
      {
        'name': 'Pakistan Investment Bonds',
        'type': 'Government Bonds',
        'expected_return': '13-15%',
        'risk': 'Low',
        'min_investment': 50000,
        'icon': '🏛️',
        'color': 0xFF6B5B95,
      },
    ];
  }

  // No need to load TFLite model anymore!
  Future<void> loadModel() async {
    print('✅ Inflation service initialized (using backend API)');
  }

  void dispose() {
    print('✅ Inflation service disposed');
  }
}