import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/api_service.dart';
import 'dart:convert';
import 'dart:math' as math;
import 'add_smart_investment_screen.dart';

class SmartInvestmentScreen extends StatefulWidget {
  const SmartInvestmentScreen({Key? key}) : super(key: key);

  @override
  _SmartInvestmentScreenState createState() => _SmartInvestmentScreenState();
}

class _SmartInvestmentScreenState extends State<SmartInvestmentScreen> {
  final Color primaryColor = const Color(0xFF0B6B43);

  bool _isLoading = true;
  double _currentBalance = 0.0;
  double _inflationRate = 8.5;
  double _recommendedInvestment = 0.0;
  String _errorMessage = "";

  // AI-powered predictions
  Map<String, dynamic>? _inflationPrediction;
  Map<String, dynamic>? _categoryTrends;
  double _predictedInflationImpact = 0.0;
  String _aiRecommendation = "";
  bool _hasAIData = false;

  // Investment options
  final List<Map<String, dynamic>> _investmentOptions = [
    {
      'name': 'Gold Investment',
      'icon': Icons.diamond,
      'color': Color(0xFFFFD700),
      'expectedReturn': 12.0,
      'risk': 'Low',
      'description': 'Safe hedge against inflation',
      'minInvestment': 10000.0,
    },
    {
      'name': 'Mutual Funds',
      'icon': Icons.trending_up,
      'color': Color(0xFF0B6B43),
      'expectedReturn': 15.0,
      'risk': 'Medium',
      'description': 'Diversified portfolio managed by experts',
      'minInvestment': 5000.0,
    },
    {
      'name': 'PSX Stocks',
      'icon': Icons.show_chart,
      'color': Color(0xFF2196F3),
      'expectedReturn': 18.0,
      'risk': 'Medium-High',
      'description': 'Pakistan Stock Exchange equities',
      'minInvestment': 15000.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadInvestmentData();
  }

  Future<void> _loadInvestmentData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    try {
      final response = await ApiService.get(
        '/api/v1/transactions/',
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        List transactions = body is List ? body : body['items'] ?? [];

        double totalIncome = 0.0;
        double totalExpense = 0.0;

        for (var trans in transactions) {
          double amount = (trans['amount'] as num).toDouble();
          String type = trans['type'] ?? '';

          if (type == 'income') {
            totalIncome += amount;
          } else if (type == 'expense') {
            totalExpense += amount;
          }
        }

        _currentBalance = totalIncome - totalExpense;

        await _fetchAIPredictions();

        if (_hasAIData && _predictedInflationImpact > 0) {
          double recommendedPercentage = _predictedInflationImpact > 10 ? 0.40 : 0.30;
          _recommendedInvestment = _currentBalance * recommendedPercentage;
        } else {
          _recommendedInvestment = _currentBalance * 0.30;
        }

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Could not load balance data";
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Investment Screen Error: $e');
      setState(() {
        _errorMessage = "Network error. Pull to refresh.";
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchAIPredictions() async {
    try {
      final inflationResponse = await ApiService.get(
        '/api/v1/inflation/predict',
        authenticated: true,
      );

      final trendsResponse = await ApiService.get(
        '/api/v1/inflation/category-trends',
        authenticated: true,
      );

      final overallResponse = await ApiService.get(
        '/api/v1/inflation/overall',
        authenticated: true,
      );

      if (inflationResponse.statusCode == 200) {
        _inflationPrediction = jsonDecode(inflationResponse.body);
        print('✅ AI Inflation Prediction: $_inflationPrediction');
      }

      if (trendsResponse.statusCode == 200) {
        _categoryTrends = jsonDecode(trendsResponse.body);
        print('✅ AI Category Trends: $_categoryTrends');
      }

      if (overallResponse.statusCode == 200) {
        final overallData = jsonDecode(overallResponse.body);
        _predictedInflationImpact = (overallData['predicted_inflation_impact'] ?? 0.0).toDouble();
        _aiRecommendation = overallData['recommendation'] ?? '';
        _hasAIData = true;
        print('✅ AI Overall Impact: $_predictedInflationImpact%');
        print('✅ AI Recommendation: $_aiRecommendation');
      }
    } catch (e) {
      print('⚠️ Could not fetch AI predictions: $e');
      _hasAIData = false;
    }
  }

  int _getAIRank(String optionName) {
    if (!_hasAIData) return 999;

    if (_predictedInflationImpact > 10) {
      if (optionName == 'Gold Investment') return 1;
      if (optionName == 'Mutual Funds') return 2;
      return 3;
    } else if (_predictedInflationImpact >= 6) {
      if (optionName == 'Mutual Funds') return 1;
      if (optionName == 'Gold Investment') return 2;
      return 3;
    } else {
      if (optionName == 'PSX Stocks') return 1;
      if (optionName == 'Mutual Funds') return 2;
      return 3;
    }
  }

  Color _getRiskColor(String risk) {
    switch (risk) {
      case 'Low':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'Medium-High':
        return Colors.deepOrange;
      case 'High':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Smart Investment 📈",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: primaryColor))
          : RefreshIndicator(
        onRefresh: _loadInvestmentData,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_errorMessage.isNotEmpty) _buildErrorCard(),
              _buildInflationWarningCard(),
              const SizedBox(height: 24),
              if (_hasAIData) _buildAIInsightsCard(),
              if (_hasAIData) const SizedBox(height: 24),
              _buildRecommendationCard(),
              const SizedBox(height: 24),
              _buildInflationImpactChart(),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Investment Options 💎",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (_hasAIData)
                        Text(
                          "Ranked by AI for your profile",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        if (_hasAIData) ...[
                          Icon(Icons.psychology, size: 12, color: primaryColor),
                          SizedBox(width: 4),
                        ],
                        Text(
                          "${_investmentOptions.length} Options",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ..._investmentOptions.map((option) => _buildInvestmentCard(option)),
              const SizedBox(height: 28),
              _buildWhyInvestSection(),
              const SizedBox(height: 28),
              _buildActionButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red[700]),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              _errorMessage,
              style: TextStyle(color: Colors.red[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInflationWarningCard() {
    double displayInflationRate = _hasAIData && _predictedInflationImpact > 0
        ? _predictedInflationImpact
        : _inflationRate;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red[400]!, Colors.red[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _hasAIData ? "AI-Predicted Inflation Alert!" : "Inflation Alert!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    if (_hasAIData)
                      Text(
                        "Based on your spending patterns",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (_hasAIData) Icon(Icons.psychology, color: Colors.white, size: 14),
                    if (_hasAIData) SizedBox(width: 4),
                    Text(
                      "${displayInflationRate.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            "Your money is losing value every day!",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Rs.100,000 today will be worth Rs.${(100000 / math.pow(1 + displayInflationRate/100, 1)).toStringAsFixed(0)} next year due to ${displayInflationRate.toStringAsFixed(1)}% inflation.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIInsightsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6B46C1), Color(0xFF9333EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF9333EA).withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.psychology, color: Colors.white, size: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AI Investment Insights",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Powered by your spending data",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.amber, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "AI",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "📊 AI Recommendation:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  _aiRecommendation.isNotEmpty
                      ? _aiRecommendation
                      : "Based on your spending patterns, consider diversifying into inflation-resistant assets.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (_categoryTrends != null && _categoryTrends!['categories'] != null) ...[
            SizedBox(height: 12),
            Text(
              "Most Affected Categories:",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            ..._buildTopInflationCategories(),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildTopInflationCategories() {
    if (_categoryTrends == null || _categoryTrends!['categories'] == null) {
      return [];
    }

    try {
      final categories = _categoryTrends!['categories'] as Map<String, dynamic>;

      // Convert category data to a sortable list
      List<MapEntry<String, double>> categoryRates = [];

      categories.forEach((categoryName, categoryData) {
        if (categoryData is List && categoryData.isNotEmpty) {
          // Get the latest month's data (last item in the list)
          final latestData = categoryData.last;
          final inflationRate = (latestData['inflation_rate'] ?? 0.0).toDouble();
          categoryRates.add(MapEntry(categoryName, inflationRate));
        }
      });

      // Sort by inflation rate (highest first)
      categoryRates.sort((a, b) => b.value.compareTo(a.value));

      return categoryRates.take(3).map((entry) {
        final categoryName = entry.key;
        final inflationRate = entry.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  categoryName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  inflationRate > 0
                      ? "+${inflationRate.toStringAsFixed(1)}%"
                      : "${inflationRate.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList();
    } catch (e) {
      print('⚠️ Error parsing category trends: $e');
      return [];
    }
  }

  Widget _buildRecommendationCard() {
    String recommendationText = _hasAIData && _predictedInflationImpact > 10
        ? "40% of balance (High inflation detected)"
        : "30% of balance";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, Color(0xFF00C192)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Current Balance",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Rs.${_currentBalance.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 16),
          Divider(color: Colors.white24, thickness: 1),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(
                _hasAIData ? Icons.psychology : Icons.lightbulb,
                color: Colors.amber,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _hasAIData ? "AI-Recommended Investment" : "Recommended Investment",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Rs.${_recommendedInvestment.toStringAsFixed(0)} ($recommendationText)",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInflationImpactChart() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Value Erosion Over Time 📉",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          'Rs.${(value / 1000).toStringAsFixed(0)}k',
                          style: TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          'Y${value.toInt()}',
                          style: TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: _generateInflationSpots(),
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.red.withOpacity(0.1),
                    ),
                  ),
                  LineChartBarData(
                    spots: _generateInvestmentSpots(),
                    isCurved: true,
                    color: primaryColor,
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: primaryColor.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem("Savings (No Investment)", Colors.red),
              _buildLegendItem("With Investment", primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateInflationSpots() {
    double initialAmount = 100000;
    List<FlSpot> spots = [];
    for (int i = 0; i < 6; i++) {
      double value = initialAmount / math.pow(1 + _inflationRate / 100, i);
      spots.add(FlSpot(i.toDouble(), value));
    }
    return spots;
  }

  List<FlSpot> _generateInvestmentSpots() {
    double initialAmount = 100000;
    double avgReturn = 15.0;
    List<FlSpot> spots = [];
    for (int i = 0; i < 6; i++) {
      double value = initialAmount * math.pow(1 + avgReturn / 100, i);
      spots.add(FlSpot(i.toDouble(), value));
    }
    return spots;
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildInvestmentCard(Map<String, dynamic> option) {
    bool isAffordable = _currentBalance >= option['minInvestment'];
    int aiRank = _getAIRank(option['name']);
    bool showAIBadge = _hasAIData && aiRank <= 1;

    return GestureDetector(
      onTap: () {
        _showInvestmentDetails(option);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: showAIBadge
                ? Color(0xFF9333EA)
                : isAffordable
                ? option['color'].withOpacity(0.3)
                : Colors.grey[300]!,
            width: showAIBadge ? 2.5 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: showAIBadge
                  ? Color(0xFF9333EA).withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: showAIBadge ? 12 : 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: option['color'].withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    option['icon'],
                    color: option['color'],
                    size: 28,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              option['name'],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (showAIBadge)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF6B46C1), Color(0xFF9333EA)],
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                                  SizedBox(width: 4),
                                  Text(
                                    "AI Top Pick",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        option['description'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoChip(
                    "Expected Return",
                    "${option['expectedReturn']}%",
                    Colors.green,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildInfoChip(
                    "Risk Level",
                    option['risk'],
                    _getRiskColor(option['risk']),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  size: 16,
                  color: Colors.grey[600],
                ),
                SizedBox(width: 6),
                Text(
                  "Min: Rs.${option['minInvestment'].toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                if (!isAffordable)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Insufficient Balance",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showInvestmentDetails(Map<String, dynamic> option) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: option['color'].withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            option['icon'],
                            color: option['color'],
                            size: 32,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                option['name'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                option['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    _buildProjectionCard(option),
                    SizedBox(height: 20),
                    Text(
                      "Investment Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildDetailRow("Expected Return", "${option['expectedReturn']}% per year"),
                    _buildDetailRow("Risk Level", option['risk']),
                    _buildDetailRow("Minimum Investment", "Rs.${option['minInvestment'].toStringAsFixed(0)}"),
                    _buildDetailRow("Investment Horizon", "Long-term (3-5 years)"),
                    SizedBox(height: 20),
                    Text(
                      "Why Invest in ${option['name']}?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      _getInvestmentBenefits(option['name']),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _currentBalance >= option['minInvestment']
                            ? () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddSmartInvestmentScreen(),
                            ),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _currentBalance >= option['minInvestment']
                              ? "Start Investing"
                              : "Insufficient Balance",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectionCard(Map<String, dynamic> option) {
    double investment = option['minInvestment'].toDouble();
    double returnRate = option['expectedReturn'] / 100;

    double threeYears = investment * math.pow(1 + returnRate, 3);
    double fiveYears = investment * math.pow(1 + returnRate, 5);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, Color(0xFF00C192)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Investment Projection",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProjectionItem("Initial", investment),
              _buildProjectionItem("3 Years", threeYears),
              _buildProjectionItem("5 Years", fiveYears),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectionItem(String label, double amount) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Rs.${(amount / 1000).toStringAsFixed(0)}k",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _getInvestmentBenefits(String optionName) {
    switch (optionName) {
      case 'Gold Investment':
        return "Gold is a traditional hedge against inflation and currency devaluation. It maintains its value over time and provides portfolio diversification. Particularly valuable in times of economic uncertainty.";
      case 'Mutual Funds':
        return "Mutual funds offer professional management and diversification across multiple assets. They provide exposure to various sectors and are suitable for investors seeking balanced growth with moderate risk.";
      case 'PSX Stocks':
        return "Pakistan Stock Exchange offers opportunities for capital appreciation through equity investments. Suitable for investors willing to accept higher volatility for potentially higher returns over the long term.";
      default:
        return "This investment option provides opportunities for wealth growth and financial security.";
    }
  }

  Widget _buildWhyInvestSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700], size: 24),
              SizedBox(width: 12),
              Text(
                "Why Invest Now?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue[900],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildWhyInvestPoint("💰", "Beat Inflation: Grow your wealth faster than inflation erodes it"),
          _buildWhyInvestPoint("📈", "Compound Growth: Your returns earn returns over time"),
          _buildWhyInvestPoint("🛡️", "Financial Security: Build a safety net for the future"),
          _buildWhyInvestPoint("🎯", "Achieve Goals: Fund education, retirement, or major purchases"),
        ],
      ),
    );
  }

  Widget _buildWhyInvestPoint(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSmartInvestmentScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.trending_up, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Start Investing Today",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}