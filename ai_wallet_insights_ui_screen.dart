import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/inflation_service.dart';
import '../services/api_service.dart';
import 'dart:convert';

class WalletInsightsScreen extends StatefulWidget {
  @override
  _WalletInsightsScreenState createState() => _WalletInsightsScreenState();
}

class _WalletInsightsScreenState extends State<WalletInsightsScreen> {
  final Color primaryColor = Color(0xFF0B6B43);
  final InflationService _inflationService = InflationService();

  bool _isLoading = true;
  Map<String, dynamic>? _inflationData;
  List<Map<String, dynamic>> _investments = [];
  Map<String, double> _categorySpending = {};
  double _totalSpending = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeAndPredict();
  }

  Future<void> _initializeAndPredict() async {
    setState(() => _isLoading = true);

    await _inflationService.loadModel();
    await _fetchSpendingData();
    await _predictInflation();
    _loadInvestmentRecommendations();

    setState(() => _isLoading = false);
  }

  Future<void> _fetchSpendingData() async {
    try {
      final response = await ApiService.get(
        '/api/v1/transactions/',
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        List transactions = body is List ? body : body['items'] ?? [];

        Map<String, double> categoryTotals = {};
        double total = 0.0;

        for (var trans in transactions) {
          if (trans['type'] == 'expense') {
            String category = trans['category'] ?? 'other';
            double amount = (trans['amount'] as num).toDouble();

            categoryTotals[category] = (categoryTotals[category] ?? 0) + amount;
            total += amount;
          }
        }

        setState(() {
          _categorySpending = categoryTotals;
          _totalSpending = total;
        });
      }
    } catch (e) {
      print('❌ Error fetching spending: $e');
    }
  }

  Future<void> _predictInflation() async {
    final prediction = await _inflationService.predictInflationImpact(
      categorySpending: _categorySpending,
      totalSpending: _totalSpending,
    );

    setState(() {
      _inflationData = prediction;
    });
  }

  void _loadInvestmentRecommendations() {
    final recommendations = _inflationService.getInvestmentRecommendations(
      _totalSpending * 0.2, // Suggest investing 20% of spending
    );

    setState(() {
      _investments = recommendations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Inflation Tracking AI",
            style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blue[700]))
          : RefreshIndicator(
        onRefresh: _initializeAndPredict,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Inflation Impact Summary
              _buildInflationSummaryCard(),

              const SizedBox(height: 24),

              // Category-wise Impact
              const Text("Category Impact 📊",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              _buildCategoryImpactChart(),

              const SizedBox(height: 24),

              // Detailed Breakdown
              _buildDetailedBreakdown(),

              const SizedBox(height: 24),

              // Investment Recommendations
              const Text("Smart Investment Options 💡",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              _buildInvestmentRecommendations(),

              const SizedBox(height: 24),

              // Savings Tips
              _buildSavingsTips(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInflationSummaryCard() {
    if (_inflationData == null) return SizedBox.shrink();

    double totalImpact = _inflationData!['total_impact'] ?? 0.0;
    double avgInflation = _inflationData!['average_inflation'] ?? 0.0;
    double predictedTotal = _inflationData!['total_predicted'] ?? 0.0;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
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
              Icon(Icons.trending_up, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              const Text(
                "Inflation Impact",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildSummaryRow(
            "Current Monthly Spending",
            "Rs.${_totalSpending.toStringAsFixed(0)}",
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            "Inflation Impact",
            "+Rs.${totalImpact.toStringAsFixed(0)}",
            highlight: true,
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            "Predicted Spending (Next Month)",
            "Rs.${predictedTotal.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Average inflation rate: ${avgInflation.toStringAsFixed(1)}%",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: highlight ? 20 : 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryImpactChart() {
    if (_inflationData == null || _inflationData!['category_impact'] == null) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            "No data available",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      );
    }

    Map<String, dynamic> categoryImpact = _inflationData!['category_impact'];

    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxValue(categoryImpact) * 1.2,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  List<String> categories = categoryImpact.keys.toList();
                  if (value.toInt() >= 0 && value.toInt() < categories.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        categories[value.toInt()].substring(0, 3).toUpperCase(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    'Rs.${value.toInt()}',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: _createBarGroups(categoryImpact),
        ),
      ),
    );
  }

  double _getMaxValue(Map<String, dynamic> categoryImpact) {
    double max = 0;
    categoryImpact.forEach((key, value) {
      double predicted = (value['future_spending'] ?? 0).toDouble();
      if (predicted > max) max = predicted;
    });
    return max;
  }

  List<BarChartGroupData> _createBarGroups(Map<String, dynamic> categoryImpact) {
    List<BarChartGroupData> groups = [];
    int index = 0;

    categoryImpact.forEach((category, data) {
      double current = (data['current_spending'] ?? 0).toDouble();
      double predicted = (data['future_spending'] ?? 0).toDouble();

      groups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: current,
              color: primaryColor,
              width: 12,
              borderRadius: BorderRadius.circular(4),
            ),
            BarChartRodData(
              toY: predicted,
              color: Colors.orange,
              width: 12,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
      index++;
    });

    return groups;
  }

  Widget _buildDetailedBreakdown() {
    if (_inflationData == null || _inflationData!['category_impact'] == null) {
      return SizedBox.shrink();
    }

    Map<String, dynamic> categoryImpact = _inflationData!['category_impact'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Detailed Breakdown 📈",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ...categoryImpact.entries.map((entry) {
          String category = entry.key;
          Map<String, dynamic> data = entry.value;

          return _buildCategoryBreakdownCard(category, data);
        }).toList(),
      ],
    );
  }

  Widget _buildCategoryBreakdownCard(String category, Map<String, dynamic> data) {
    double current = (data['current_spending'] ?? 0).toDouble();
    double rate = (data['inflation_rate'] ?? 0).toDouble();
    double increase = (data['predicted_increase'] ?? 0).toDouble();
    double future = (data['future_spending'] ?? 0).toDouble();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _getCategoryIcon(category),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "+${rate.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Text(
                    "Rs.${current.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward, color: Colors.grey[400]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Predicted",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Text(
                    "Rs.${future.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.orange[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Expected increase: Rs.${increase.toStringAsFixed(0)}",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _getCategoryIcon(String category) {
    Map<String, IconData> icons = {
      'food': Icons.restaurant,
      'rent': Icons.home,
      'transport': Icons.directions_car,
      'utilities': Icons.electrical_services,
      'entertainment': Icons.movie,
    };

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icons[category] ?? Icons.attach_money,
        color: primaryColor,
        size: 20,
      ),
    );
  }

  Widget _buildInvestmentRecommendations() {
    return Column(
      children: _investments.map((investment) {
        return _buildInvestmentCard(investment);
      }).toList(),
    );
  }

  Widget _buildInvestmentCard(Map<String, dynamic> investment) {
    Color cardColor = Color(investment['color']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cardColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            _showInvestmentDetails(investment);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    investment['icon'],
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        investment['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        investment['type'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildInfoChip(
                            investment['expected_return'],
                            Colors.green,
                          ),
                          const SizedBox(width: 8),
                          _buildInfoChip(
                            investment['risk'],
                            Colors.orange,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  void _showInvestmentDetails(Map<String, dynamic> investment) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    investment['icon'],
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          investment['name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          investment['type'],
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
              const SizedBox(height: 20),
              _buildDetailRow("Expected Return", investment['expected_return']),
              _buildDetailRow("Risk Level", investment['risk']),
              _buildDetailRow(
                "Minimum Investment",
                "Rs.${investment['min_investment']}",
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Investment feature coming soon!",
                        ),
                        backgroundColor: primaryColor,
                      ),
                    );
                  },
                  child: const Text(
                    "Learn More",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Savings Tips 💰",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        _buildTipCard(
          "Track high-inflation categories closely",
          Icons.trending_up,
        ),
        _buildTipCard(
          "Consider investing surplus in low-risk funds",
          Icons.account_balance,
        ),
        _buildTipCard(
          "Set budget alerts for expense-heavy categories",
          Icons.notifications_active,
        ),
        _buildTipCard(
          "Review and optimize monthly subscriptions",
          Icons.subscriptions,
        ),
      ],
    );
  }

  Widget _buildTipCard(String tip, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[700], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _inflationService.dispose();
    super.dispose();
  }
}