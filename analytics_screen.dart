import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/api_service.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final Color primaryColor = Color(0xFF0B6B43);

  bool _isLoading = true;
  String _selectedPeriod = 'all_time';
  String _errorMessage = "";

  // Analytics data
  Map<String, double> _categoryData = {};
  List<Map<String, dynamic>> _monthlyData = [];
  List<Map<String, dynamic>> _topTransactions = [];

  // Summary stats (current period)
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  double _avgTransaction = 0.0;
  int _transactionCount = 0;

  // Comparison stats (previous period)
  double _prevTotalIncome = 0.0;
  double _prevTotalExpense = 0.0;
  double _incomeChange = 0.0;
  double _expenseChange = 0.0;

  @override
  void initState() {
    super.initState();
    _loadAnalyticsData();
  }

  Future<void> _loadAnalyticsData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    try {
      DateTime now = DateTime.now();
      String? startDate;
      String? endDate;
      String? prevStartDate;
      String? prevEndDate;

      switch (_selectedPeriod) {
        case 'this_month':
          startDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1));
          endDate = DateFormat('yyyy-MM-dd').format(now);
          DateTime prevMonth = DateTime(now.year, now.month - 1, 1);
          prevStartDate = DateFormat('yyyy-MM-dd').format(prevMonth);
          prevEndDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 0));
          break;

        case 'this_year':
          startDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year, 1, 1));
          endDate = DateFormat('yyyy-MM-dd').format(now);
          prevStartDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year - 1, 1, 1));
          prevEndDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year - 1, 12, 31));
          break;

        default:
          break;
      }

      await _fetchPeriodData(startDate, endDate, isPrevious: false);

      if (prevStartDate != null && prevEndDate != null) {
        await _fetchPeriodData(prevStartDate, prevEndDate, isPrevious: true);
        if (_prevTotalIncome > 0) {
          _incomeChange = ((_totalIncome - _prevTotalIncome) / _prevTotalIncome) * 100;
        }
        if (_prevTotalExpense > 0) {
          _expenseChange = ((_totalExpense - _prevTotalExpense) / _prevTotalExpense) * 100;
        }
      }

      setState(() {
        _isLoading = false;
      });

    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load analytics. Pull down to refresh.";
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchPeriodData(String? startDate, String? endDate, {required bool isPrevious}) async {
    String queryParams = '';
    if (startDate != null) {
      queryParams += 'start_date=$startDate';
    }
    if (endDate != null) {
      queryParams += queryParams.isEmpty ? 'end_date=$endDate' : '&end_date=$endDate';
    }

    final transUrl = '/api/v1/transactions/${queryParams.isEmpty ? '' : '?$queryParams'}';
    final transResponse = await ApiService.get(transUrl, authenticated: true);

    if (transResponse.statusCode == 200) {
      final transBody = jsonDecode(transResponse.body);
      List transactions = transBody is List ? transBody : (transBody['items'] ?? []);

      if (isPrevious) {
        _prevTotalIncome = 0.0;
        _prevTotalExpense = 0.0;
        for (var trans in transactions) {
          double amount = (trans['amount'] as num).toDouble();
          if (trans['type'] == 'income') {
            _prevTotalIncome += amount;
          } else {
            _prevTotalExpense += amount;
          }
        }
      } else {
        _transactionCount = transactions.length;
        _totalIncome = 0.0;
        _totalExpense = 0.0;

        for (var trans in transactions) {
          double amount = (trans['amount'] as num).toDouble();
          if (trans['type'] == 'income') {
            _totalIncome += amount;
          } else {
            _totalExpense += amount;
          }
        }

        _avgTransaction = _transactionCount > 0
            ? (_totalIncome + _totalExpense) / _transactionCount
            : 0.0;
      }
    }

    if (!isPrevious) {
      final catUrl = '/api/v1/transactions/stats/by-category${queryParams.isEmpty ? '' : '?$queryParams'}';
      final catResponse = await ApiService.get(catUrl, authenticated: true);

      if (catResponse.statusCode == 200) {
        final catBody = jsonDecode(catResponse.body);
        if (catBody['categories'] != null) {
          Map<String, double> tempCategoryData = {};
          for (var cat in catBody['categories']) {
            tempCategoryData[cat['category'] ?? 'other'] = (cat['total'] as num).toDouble();
          }
          _categoryData = tempCategoryData;
        }
      }

      final monthlyResponse = await ApiService.get('/api/v1/transactions/stats/monthly', authenticated: true);
      if (monthlyResponse.statusCode == 200) {
        final monthlyBody = jsonDecode(monthlyResponse.body);
        if (monthlyBody['monthly_stats'] != null) {
          _monthlyData = List<Map<String, dynamic>>.from(monthlyBody['monthly_stats']);
        }
      }

      final topUrl = '/api/v1/transactions/stats/top?limit=5${queryParams.isEmpty ? '' : '&$queryParams'}';
      final topResponse = await ApiService.get(topUrl, authenticated: true);
      if (topResponse.statusCode == 200) {
        final topBody = jsonDecode(topResponse.body);
        if (topBody['top_transactions'] != null) {
          _topTransactions = List<Map<String, dynamic>>.from(topBody['top_transactions']);
        }
      }
    }
  }

  Future<void> _exportData() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Export Analytics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text('Export as PDF'),
              onTap: () {
                Navigator.pop(context);
                _exportAsPDF();
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart, color: Colors.green),
              title: Text('Export as CSV'),
              onTap: () {
                Navigator.pop(context);
                _exportAsCSV();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _exportAsPDF() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text('PDF export ready - Use pdf package to implement')),
          ],
        ),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _exportAsCSV() {
    StringBuffer csv = StringBuffer();
    csv.writeln('Category,Amount');
    _categoryData.forEach((category, amount) {
      csv.writeln('$category,$amount');
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text('CSV generated - Use share_plus to save/share')),
          ],
        ),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text('Analytics & Insights', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: Colors.white),
            onPressed: _exportData,
            tooltip: 'Export Data',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadAnalyticsData,
        child: _isLoading
            ? Center(child: CircularProgressIndicator(color: primaryColor))
            : _errorMessage.isNotEmpty
            ? _buildErrorState()
            : SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _buildPeriodFilter(),
              _buildComparisonBanner(),
              _buildSummaryCards(),
              _buildCategoryBreakdown(),
              _buildMonthlyTrends(),
              _buildTopTransactions(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.05),
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: primaryColor, size: 20),
          SizedBox(width: 12),
          Text('Time Period:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[800])),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPeriod,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down, color: primaryColor),
                  style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.w600),
                  items: [
                    DropdownMenuItem(value: 'all_time', child: Text('All Time')),
                    DropdownMenuItem(value: 'this_month', child: Text('This Month')),
                    DropdownMenuItem(value: 'this_year', child: Text('This Year')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedPeriod = value!;
                    });
                    _loadAnalyticsData();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonBanner() {
    if (_selectedPeriod == 'all_time') return SizedBox.shrink();

    String comparisonText = _selectedPeriod == 'this_month' ? 'vs Last Month' : 'vs Last Year';

    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primaryColor.withOpacity(0.1), primaryColor.withOpacity(0.05)]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.compare_arrows, color: primaryColor, size: 20),
              SizedBox(width: 8),
              Text('Comparison $comparisonText', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: primaryColor)),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildComparisonItem('Income', _incomeChange, Icons.arrow_downward)),
              SizedBox(width: 12),
              Expanded(child: _buildComparisonItem('Expense', _expenseChange, Icons.arrow_upward)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonItem(String label, double change, IconData icon) {
    bool isPositive = change > 0;
    bool isIncome = label == 'Income';
    Color trendColor = isIncome ? (isPositive ? Colors.green : Colors.red) : (isPositive ? Colors.red : Colors.green);

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: Colors.grey[600]),
              SizedBox(width: 4),
              Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w500)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isPositive ? Icons.trending_up : Icons.trending_down, color: trendColor, size: 20),
              SizedBox(width: 4),
              Text('${change.abs().toStringAsFixed(1)}%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: trendColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.grey[800])),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text('$_transactionCount transactions', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primaryColor)),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatCard('Total Income', 'Rs.${_totalIncome.toStringAsFixed(0)}', Icons.arrow_downward, Colors.green)),
              SizedBox(width: 12),
              Expanded(child: _buildStatCard('Total Expense', 'Rs.${_totalExpense.toStringAsFixed(0)}', Icons.arrow_upward, Colors.red)),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard('Net Balance', 'Rs.${(_totalIncome - _totalExpense).toStringAsFixed(0)}', Icons.account_balance_wallet, primaryColor)),
              SizedBox(width: 12),
              Expanded(child: _buildStatCard('Avg Transaction', 'Rs.${_avgTransaction.toStringAsFixed(0)}', Icons.trending_up, Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w500)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.grey[900])),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    if (_categoryData.isEmpty) return _buildEmptyState('No category data available');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Category Breakdown', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          SizedBox(height: 16),
          Container(
            height: 300,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _categoryData.values.isEmpty ? 10 : (_categoryData.values.reduce((a, b) => a > b ? a : b) * 1.2),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String category = _categoryData.keys.elementAt(groupIndex);
                      return BarTooltipItem(
                        '$category\nRs.${rod.toY.toInt()}',
                        TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < _categoryData.length) {
                          String category = _categoryData.keys.elementAt(index);
                          return Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              category.length > 8 ? category.substring(0, 8) + '..' : category,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                          );
                        }
                        return Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text('Rs.${value.toInt()}', style: TextStyle(fontSize: 10));
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: true, drawVerticalLine: false),
                borderData: FlBorderData(show: false),
                barGroups: _categoryData.entries.map((e) {
                  int index = _categoryData.keys.toList().indexOf(e.key);
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: e.value,
                        color: primaryColor,
                        width: 20,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMonthlyTrends() {
    if (_monthlyData.isEmpty) return _buildEmptyState('No monthly data available');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Monthly Trends', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          SizedBox(height: 16),
          Container(
            height: 250,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        return Text('Rs.${value.toInt()}', style: TextStyle(fontSize: 10));
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < _monthlyData.length) {
                          String month = _monthlyData[index]['month'] ?? '';
                          return Text(month.length > 3 ? month.substring(0, 3) : month, style: TextStyle(fontSize: 10));
                        }
                        return Text('');
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(_monthlyData.length, (i) => FlSpot(i.toDouble(), (_monthlyData[i]['income'] as num?)?.toDouble() ?? 0)),
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                  ),
                  LineChartBarData(
                    spots: List.generate(_monthlyData.length, (i) => FlSpot(i.toDouble(), (_monthlyData[i]['expense'] as num?)?.toDouble() ?? 0)),
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend('Income', Colors.green),
              SizedBox(width: 20),
              _buildLegend('Expense', Colors.red),
            ],
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildTopTransactions() {
    if (_topTransactions.isEmpty) return _buildEmptyState('No transactions found');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top 5 Transactions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          SizedBox(height: 16),
          ..._topTransactions.map((trans) {
            String desc = trans['description'] ?? 'No description';
            String category = trans['category'] ?? 'other';
            double amount = (trans['amount'] as num?)?.toDouble() ?? 0;
            String dateStr = trans['date'] ?? '';

            String formattedDate = '';
            try {
              DateTime dt = DateTime.parse(dateStr);
              formattedDate = DateFormat('MMM dd, yyyy').format(dt);
            } catch (e) {
              formattedDate = dateStr;
            }

            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: Offset(0, 2))],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.arrow_upward, color: Colors.red, size: 24),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          desc.length > 30 ? desc.substring(0, 30) + '...' : desc,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4),
                        Text('$category • $formattedDate', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  Text('Rs.${amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.red)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.bar_chart, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(message, style: TextStyle(fontSize: 16, color: Colors.grey[600]), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            SizedBox(height: 16),
            Text(_errorMessage, style: TextStyle(fontSize: 16, color: Colors.grey[700]), textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadAnalyticsData,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Retry', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}