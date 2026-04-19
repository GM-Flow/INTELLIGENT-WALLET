/*import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  String? _emailError;
  String? _passwordError;

  final Color primaryColor = Color(0xFF0B6B43);

  // -----------------------
  // VALIDATION FUNCTIONS
  // -----------------------

  bool _validateEmail(String email) {
    final allowedDomains = ["gmail.com", "yahoo.com", "outlook.com"];
    if (!email.contains("@")) return false;

    final domain = email.split("@").last;
    return allowedDomains.contains(domain);
  }

  bool _validatePassword(String pass) {
    return pass.length >= 6;
  }

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final pass = _passwordController.text.trim();

    setState(() {
      _emailError = _validateEmail(email) ? null : "Enter a valid email (@gmail.com, @yahoo.com)";
      _passwordError = _validatePassword(pass) ? null : "Password must be at least 6 characters";
    });

    if (_emailError == null && _passwordError == null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5FFFA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -----------------------
              // TITLE
              // -----------------------
              Text(
                "Welcome Back 👋",
                style: TextStyle(
                  color: Color(0xFF0B4F3A),
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Login to your Intelligent Wallet",
                style: TextStyle(
                  color: Color(0xFF6E8B80),
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 32),

              // -----------------------
              // EMAIL FIELD
              // -----------------------
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: primaryColor),
                  prefixIcon: Icon(Icons.email, color: primaryColor),
                  errorText: _emailError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // -----------------------
              // PASSWORD FIELD
              // -----------------------
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: primaryColor),
                  prefixIcon: Icon(Icons.lock, color: primaryColor),
                  errorText: _passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      setState(() => _obscureText = !_obscureText);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              SizedBox(height: 24),

              // -----------------------
              // LOGIN BUTTON
              // -----------------------
              ElevatedButton(
                onPressed: _onLoginPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              SizedBox(height: 12),

              // -----------------------
              // FORGOT PASSWORD
              // -----------------------
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot');
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),

              // -----------------------
              // SIGN UP LINK
              // -----------------------
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      color: primaryColor, // MATCHES THE THEME 💚
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  String? _usernameError;
  String? _passwordError;

  final Color primaryColor = Color(0xFF0B6B43);

  void _onLoginPressed() async {
    final username = _usernameController.text.trim();
    final pass = _passwordController.text.trim();

    setState(() {
      _usernameError = username.isEmpty ? "Username required" : null;
      _passwordError = pass.length < 6 ? "Min 6 characters" : null;
    });

    if (_usernameError != null || _passwordError != null) return;

    final auth = context.read<AuthProvider>();
    final success = await auth.login(username, pass);

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.errorMessage ?? "Login failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      backgroundColor: Color(0xFFF5FFFA),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),

              Text(
                "Welcome Back 👋",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 8),

              Text(
                "Login to your account",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              SizedBox(height: 48),

              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  errorText: _usernameError,
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 16),

              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: _passwordError,
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                  ),
                ),
              ),

              // ✅ NEW: Forgot Password Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot');
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              ElevatedButton(
                onPressed: isLoading ? null : _onLoginPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 52),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  "Login",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              SizedBox(height: 16),

              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/signup'),
                child: Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}