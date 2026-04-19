import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

class FraudDetectionService {
  Interpreter? _interpreter;
  bool _isModelLoaded = false;

  // Initialize the model
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/models/fraud_model.tflite');
      _isModelLoaded = true;
      print('✅ Fraud detection model loaded');
    } catch (e) {
      print('❌ Error loading fraud model: $e');
      _isModelLoaded = false;
    }
  }

  // Analyze transaction for fraud
  Future<Map<String, dynamic>> analyzeTransaction({
    required double amount,
    required String category,
    required String type,
    String? location,
  }) async {
    if (!_isModelLoaded) {
      await loadModel();
    }

    try {
      // Prepare input features
      var input = _prepareInput(amount, category, type, location);

      // Prepare output buffer
      var output = List.filled(1, 0.0).reshape([1, 1]);

      // Run inference
      _interpreter?.run(input, output);

      double riskScore = output[0][0];

      return {
        'risk_score': riskScore,
        'is_suspicious': riskScore > 0.7,
        'risk_level': _getRiskLevel(riskScore),
        'confidence': (riskScore * 100).toStringAsFixed(1),
      };
    } catch (e) {
      print('❌ Error during fraud analysis: $e');
      return _getMockFraudAnalysis(amount);
    }
  }

  // Prepare input based on your model requirements
  List<List<double>> _prepareInput(
      double amount,
      String category,
      String type,
      String? location,
      ) {
    // Example: Normalize and encode features
    double normalizedAmount = amount / 10000.0;
    double categoryEncoded = _encodeCategory(category);  // ✅ FIXED
    double typeEncoded = type == 'expense' ? 1.0 : 0.0;

    return [
      [normalizedAmount, categoryEncoded, typeEncoded, 0.0, 0.0]
    ];
  }

  double _encodeCategory(String category) {
    Map<String, double> categoryMap = {
      'food': 0.1,
      'rent': 0.2,
      'transport': 0.3,
      'utilities': 0.4,
      'entertainment': 0.5,
      'salary': 0.6,
      'other': 0.7,
    };
    return categoryMap[category] ?? 0.7;
  }

  String _getRiskLevel(double score) {
    if (score > 0.8) return 'HIGH';
    if (score > 0.5) return 'MEDIUM';
    return 'LOW';
  }

  // Mock analysis for testing
  Map<String, dynamic> _getMockFraudAnalysis(double amount) {
    double mockScore = amount > 5000 ? 0.75 : 0.25;
    return {
      'risk_score': mockScore,
      'is_suspicious': mockScore > 0.7,
      'risk_level': _getRiskLevel(mockScore),
      'confidence': (mockScore * 100).toStringAsFixed(1),
    };
  }

  void dispose() {
    _interpreter?.close();
  }
}