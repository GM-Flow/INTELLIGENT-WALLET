import 'package:flutter/material.dart';
import '../services/fraud_detection_service.dart';
import '../services/api_service.dart';
import 'dart:convert';

class FraudPreventionScreen extends StatefulWidget {
  @override
  _FraudPreventionScreenState createState() => _FraudPreventionScreenState();
}

class _FraudPreventionScreenState extends State<FraudPreventionScreen> {
  final Color primaryColor = Color(0xFF0B6B43);
  final FraudDetectionService _fraudService = FraudDetectionService();

  bool _isLoading = true;
  double _overallSecurityScore = 0.0;
  List<Map<String, dynamic>> _suspiciousTransactions = [];
  Map<String, dynamic>? _latestAnalysis;

  @override
  void initState() {
    super.initState();
    _initializeAndAnalyze();
  }

  Future<void> _initializeAndAnalyze() async {
    setState(() => _isLoading = true);

    await _fraudService.loadModel();
    await _analyzeRecentTransactions();

    setState(() => _isLoading = false);
  }

  Future<void> _analyzeRecentTransactions() async {
    try {
      final response = await ApiService.get(
        '/api/v1/transactions/',
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        List transactions = body is List ? body : body['items'] ?? [];

        List<Map<String, dynamic>> suspicious = [];
        double totalRisk = 0.0;

        for (var trans in transactions.take(10)) {
          final analysis = await _fraudService.analyzeTransaction(
            amount: (trans['amount'] as num).toDouble(),
            category: trans['category'] ?? 'other',
            type: trans['type'] ?? 'expense',
            location: trans['geo_location'],
          );

          totalRisk += analysis['risk_score'];

          if (analysis['is_suspicious']) {
            suspicious.add({
              ...trans,
              'analysis': analysis,
            });
          }
        }

        setState(() {
          _overallSecurityScore = (1 - (totalRisk / transactions.length)) * 100;
          _suspiciousTransactions = suspicious;
          if (transactions.isNotEmpty) {
            _latestAnalysis = suspicious.isNotEmpty
                ? suspicious.first['analysis']
                : null;
          }
        });
      }
    } catch (e) {
      print('❌ Error analyzing transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Fraud Prevention AI",
            style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.red[600],
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.red[600]))
          : RefreshIndicator(
        onRefresh: _analyzeRecentTransactions,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Security Score Card
              _buildSecurityScoreCard(),

              const SizedBox(height: 24),

              // Fraud Alerts
              const Text("Fraud Alerts 🔔",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),

              _suspiciousTransactions.isEmpty
                  ? _buildNoAlertsCard()
                  : Column(
                children: _suspiciousTransactions
                    .map((trans) => _buildAlertCard(trans))
                    .toList(),
              ),

              const SizedBox(height: 24),

              // Risk Analysis
              _buildRiskAnalysisSection(),

              const SizedBox(height: 24),

              // Protection Tips
              _buildProtectionTips(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityScoreCard() {
    Color scoreColor = _overallSecurityScore > 80
        ? Colors.green
        : _overallSecurityScore > 50
        ? Colors.orange
        : Colors.red;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scoreColor.withOpacity(0.8), scoreColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: scoreColor.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Security Score",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  value: _overallSecurityScore / 100,
                  strokeWidth: 12,
                  backgroundColor: Colors.white30,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              Column(
                children: [
                  Text(
                    "${_overallSecurityScore.toStringAsFixed(0)}%",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _overallSecurityScore > 80
                        ? "Excellent"
                        : _overallSecurityScore > 50
                        ? "Good"
                        : "At Risk",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _suspiciousTransactions.isEmpty
                ? "No suspicious activity detected"
                : "${_suspiciousTransactions.length} suspicious transaction(s) found",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoAlertsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green[700], size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All Clear!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.green[900],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "No suspicious transactions detected",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> trans) {
    final analysis = trans['analysis'];
    Color riskColor = analysis['risk_level'] == 'HIGH'
        ? Colors.red
        : analysis['risk_level'] == 'MEDIUM'
        ? Colors.orange
        : Colors.yellow[700]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: riskColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: riskColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: riskColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${analysis['risk_level']} RISK",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: riskColor,
                      ),
                    ),
                    Text(
                      "Rs.${trans['amount']} - ${trans['category']}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: riskColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${analysis['confidence']}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: riskColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            trans['description'] ?? "Transaction flagged for review",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          Text(
            "Date: ${trans['date']?.substring(0, 10) ?? 'N/A'}",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskAnalysisSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Risk Analysis 📊",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              _buildRiskItem("High-risk transactions", _suspiciousTransactions.length,
                  Colors.red),
              _buildRiskItem("Medium-risk alerts", 0, Colors.orange),
              _buildRiskItem("Secure transactions",
                  10 - _suspiciousTransactions.length, Colors.green),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRiskItem(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProtectionTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Protection Tips 🛡️",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        _buildTipCard("Enable transaction notifications for real-time alerts"),
        _buildTipCard("Review suspicious transactions immediately"),
        _buildTipCard("Set spending limits for high-risk categories"),
        _buildTipCard("Use secure networks for financial transactions"),
      ],
    );
  }

  Widget _buildTipCard(String tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.tips_and_updates, color: primaryColor, size: 20),
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
    _fraudService.dispose();
    super.dispose();
  }
}