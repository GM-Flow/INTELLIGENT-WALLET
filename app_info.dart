/*import 'package:flutter/material.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({Key? key}) : super(key: key);

  final String version = '1.0.0';
  final String buildNumber = '123'; // renamed to avoid confusion

  static const Color gradientStart = Color(0xFF00C192);
  static const Color gradientEnd = Color(0xFF0B8F67);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 110,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [gradientStart, gradientEnd])),
          padding: const EdgeInsets.only(top: 36, left: 16),
          alignment: Alignment.centerLeft,
          child: const Text('App Information', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
        ),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline, size: 56, color: Colors.black87),
                const SizedBox(height: 12),
                const Text('Intelligent Wallet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('Version: $version', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text('Build: $buildNumber', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                const Text('© 2025 Intelligent Wallet', style: TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/



import 'package:flutter/material.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({Key? key}) : super(key: key);

  final String version = '1.0.0';
  final String buildNumber = '123'; // renamed to avoid confusion

  static const Color gradientStart = Color(0xFF00C192);
  static const Color gradientEnd = Color(0xFF0B8F67);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 110,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [gradientStart, gradientEnd])),
          padding: const EdgeInsets.only(top: 36, left: 16),
          alignment: Alignment.centerLeft,
          child: const Text('App Information', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
        ),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline, size: 56, color: Colors.black87),
                const SizedBox(height: 12),
                const Text('Intelligent Wallet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('Version: $version', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text('Build: $buildNumber', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                const Text('© 2025 Intelligent Wallet', style: TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
