/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';

class ApiService {
  // CHANGE THIS LATER when backend is live
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<http.Response> post(
      String endpoint,
      Map<String, dynamic> body, {
        bool authenticated = false,
      }) async {
    final headers = await _buildHeaders(authenticated);

    return http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  static Future<Map<String, String>> _buildHeaders(bool authenticated) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    if (authenticated) {
      final token = await TokenService.getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }
}

..............................................................................
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';

class ApiService {
  // IMPORTANT: Change based on your testing device
  // Android Emulator: http://10.0.2.2:8000
  // iOS Simulator: http://localhost:8000
  // Physical Device: http://YOUR_PC_IP:8000 (e.g., http://192.168.1.100:8000)
  // Web Browser: http://localhost:8000
 // static const String baseUrl = 'http://10.0.2.2:8000';
  //static const String baseUrl = 'http://localhost:8000';
  static const String baseUrl = 'http://192.168.8.102:8000';
  // POST request
  static Future<http.Response> post(
      String endpoint,
      Map<String, dynamic> body, {
        bool authenticated = false,
      }) async {
    final headers = await _buildHeaders(authenticated);

    try {
      return await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );
    } catch (e) {
      // Return error response if network fails
      return http.Response(
        jsonEncode({'error': 'Network error', 'message': e.toString()}),
        500,
      );
    }
  }

  // GET request
  static Future<http.Response> get(
      String endpoint, {
        bool authenticated = false,
      }) async {
    final headers = await _buildHeaders(authenticated);

    try {
      return await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
    } catch (e) {
      return http.Response(
        jsonEncode({'error': 'Network error', 'message': e.toString()}),
        500,
      );
    }
  }

  // PUT request
  static Future<http.Response> put(
      String endpoint,
      Map<String, dynamic> body, {
        bool authenticated = false,
      }) async {
    final headers = await _buildHeaders(authenticated);

    try {
      return await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );
    } catch (e) {
      return http.Response(
        jsonEncode({'error': 'Network error', 'message': e.toString()}),
        500,
      );
    }
  }

  // DELETE request
  static Future<http.Response> delete(
      String endpoint, {
        bool authenticated = false,
      }) async {
    final headers = await _buildHeaders(authenticated);

    try {
      return await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
    } catch (e) {
      return http.Response(
        jsonEncode({'error': 'Network error', 'message': e.toString()}),
        500,
      );
    }
  }

  // Build headers with optional authentication
  static Future<Map<String, String>> _buildHeaders(bool authenticated) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    if (authenticated) {
      final token = await TokenService.getAccessToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }
}
 */

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';

class ApiService {
  // 🎯 CHANGE THIS WHEN YOU CHANGE LOCATION
  static const String _currentIp = '192.168.8.100'; // <-- Only change this line!

  // Alternatively, set this to your ngrok URL when using ngrok:
  // static const String _currentIp = 'abc123.ngrok.io';
  // static const bool _useHttps = true; // Set to true for ngrok

  static const bool _useHttps = false; // Set to true for ngrok or production
  static const int _port = 8000;

  // Auto-generated base URL
  static String get baseUrl {
    final protocol = _useHttps ? 'https' : 'http';
    final portStr = _useHttps ? '' : ':$_port'; // ngrok doesn't need port
    return '$protocol://$_currentIp$portStr';
  }

  static Future<http.Response> post(
      String endpoint,
      Map<String, dynamic> body, {
        bool authenticated = false,
      }) async {
    final headers = await _buildHeaders(authenticated);

    try {
      print('🌐 API Request: POST $baseUrl$endpoint');
      print('📦 Body: ${jsonEncode(body)}');

      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );

      print('📡 Response Status: ${response.statusCode}');
      print('📄 Response Body: ${response.body}');

      return response;
    } catch (e) {
      print('❌ API Error: $e');
      rethrow;
    }
  }

  static Future<http.Response> get(
      String endpoint, {
        bool authenticated = false,
      }) async {
    final headers = await _buildHeaders(authenticated);

    try {
      print('🌐 API Request: GET $baseUrl$endpoint');

      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );

      print('📡 Response Status: ${response.statusCode}');

      return response;
    } catch (e) {
      print('❌ API Error: $e');
      rethrow;
    }
  }

  static Future<http.Response> put(
      String endpoint,
      Map<String, dynamic> body, {
        bool authenticated = false,
      }) async {
    final headers = await _buildHeaders(authenticated);

    try {
      print('🌐 API Request: PUT $baseUrl$endpoint');
      print('📦 Body: ${jsonEncode(body)}');

      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );

      print('📡 Response Status: ${response.statusCode}');

      return response;
    } catch (e) {
      print('❌ API Error: $e');
      rethrow;
    }
  }

  static Future<http.Response> delete(
      String endpoint, {
        bool authenticated = false,
      }) async {
    final headers = await _buildHeaders(authenticated);

    try {
      print('🌐 API Request: DELETE $baseUrl$endpoint');

      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );

      print('📡 Response Status: ${response.statusCode}');

      return response;
    } catch (e) {
      print('❌ API Error: $e');
      rethrow;
    }
  }

  static Future<Map<String, String>> _buildHeaders(bool authenticated) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (authenticated) {
      final token = await TokenService.getAccessToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }
}