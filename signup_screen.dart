/*
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _phoneError;

  final Color primaryColor = Color(0xFF0B6B43);

  bool _validateEmail(String email) {
    final allowedDomains = ["gmail.com", "yahoo.com", "outlook.com"];
    if (!email.contains("@")) return false;
    return allowedDomains.contains(email.split("@").last);
  }

  bool _validatePhone(String phone) {
    return phone.length == 11 && RegExp(r'^[0-9]+$').hasMatch(phone);
  }

  void _registerUser() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final phone = _phoneController.text.trim();

    setState(() {
      _emailError =
      _validateEmail(email) ? null : "Enter a valid email (@gmail.com etc.)";

      _passwordError =
      password.length >= 6 ? null : "Password must be at least 6 characters";

      _phoneError =
      _validatePhone(phone) ? null : "Phone number must be 11 digits only";
    });

    if (_emailError == null &&
        _passwordError == null &&
        _phoneError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account created successfully!"),
          backgroundColor: primaryColor,
        ),
      );

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5FFFA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),

                Text(
                  "Create Account ✨",
                  style: TextStyle(
                    color: Color(0xFF0B4F3A),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),

                Text(
                  "Join the Intelligent Wallet system",
                  style: TextStyle(
                    color: Color(0xFF6E8B80),
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 32),

                // NAME
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(color: primaryColor),
                    prefixIcon: Icon(Icons.person, color: primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // EMAIL
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

                // PHONE (11 digits)
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: TextStyle(color: primaryColor),
                    prefixIcon: Icon(Icons.phone, color: primaryColor),
                    errorText: _phoneError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // PASSWORD
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: primaryColor),
                    prefixIcon: Icon(Icons.lock, color: primaryColor),
                    errorText: _passwordError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                SizedBox(height: 26),

                // REGISTER BUTTON
                ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // FIXED — now readable
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/










/*
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController(); // NEW
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _phoneError;
  String? _confirmPasswordError; // NEW

  final Color primaryColor = Color(0xFF0B6B43);

  bool _validateEmail(String email) {
    final allowedDomains = ["gmail.com", "yahoo.com", "outlook.com"];
    if (!email.contains("@")) return false;
    return allowedDomains.contains(email.split("@").last);
  }

  bool _validatePhone(String phone) {
    return phone.length == 11 && RegExp(r'^[0-9]+$').hasMatch(phone);
  }

  void _registerUser() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final phone = _phoneController.text.trim();

    setState(() {
      _emailError = _validateEmail(email)
          ? null
          : "Enter a valid email (@gmail.com etc.)";

      _passwordError =
      password.length >= 6 ? null : "Password must be at least 6 characters";

      _phoneError =
      _validatePhone(phone) ? null : "Phone number must be 11 digits only";

      _confirmPasswordError =
      password == confirmPassword ? null : "Passwords do not match"; // NEW
    });

    if (_emailError == null &&
        _passwordError == null &&
        _phoneError == null &&
        _confirmPasswordError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account created successfully!"),
          backgroundColor: primaryColor,
        ),
      );

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5FFFA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),

                Text(
                  "Create Account ✨",
                  style: TextStyle(
                    color: Color(0xFF0B4F3A),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),

                Text(
                  "Join the Intelligent Wallet system",
                  style: TextStyle(
                    color: Color(0xFF6E8B80),
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 32),

                // NAME
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(color: primaryColor),
                    prefixIcon: Icon(Icons.person, color: primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // EMAIL
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

                // PHONE
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: TextStyle(color: primaryColor),
                    prefixIcon: Icon(Icons.phone, color: primaryColor),
                    errorText: _phoneError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // PASSWORD
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: primaryColor),
                    prefixIcon: Icon(Icons.lock, color: primaryColor),
                    errorText: _passwordError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // CONFIRM PASSWORD — NEW
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: primaryColor),
                    prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                    errorText: _confirmPasswordError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                SizedBox(height: 26),

                // REGISTER BUTTON
                ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final Color primaryColor = const Color(0xFF0B6B43);

  // ---------------- VALIDATION ----------------
  bool _validateEmail(String email) {
    return email.contains("@") && email.contains(".");
  }

  bool _validatePassword(String password) {
    // Must match backend requirements:
    // 8+ chars, uppercase, lowercase, digit, special char
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false; // Uppercase
    if (!password.contains(RegExp(r'[a-z]'))) return false; // Lowercase
    if (!password.contains(RegExp(r'[0-9]'))) return false; // Digit
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false; // Special
    return true;
  }

  String _getPasswordError(String password) {
    if (password.length < 8) return "At least 8 characters required";
    if (!password.contains(RegExp(r'[A-Z]'))) return "Need uppercase letter";
    if (!password.contains(RegExp(r'[a-z]'))) return "Need lowercase letter";
    if (!password.contains(RegExp(r'[0-9]'))) return "Need a digit";
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Need special character (!@#\$%^&*)";
    }
    return "";
  }

  // ---------------- SIGNUP ----------------
  Future<void> _registerUser() async {
    final username = _usernameController.text.trim();
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _usernameError = username.isEmpty ? "Username required" : null;
      _emailError = _validateEmail(email) ? null : "Enter a valid email";

      if (!_validatePassword(password)) {
        _passwordError = _getPasswordError(password);
      } else {
        _passwordError = null;
      }

      _confirmPasswordError =
      password == confirmPassword ? null : "Passwords do not match";
    });

    if (_usernameError != null ||
        _emailError != null ||
        _passwordError != null ||
        _confirmPasswordError != null) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.signup(username, email, password, name);

    if (!mounted) return;

    if (success) {
      // ✅ UPDATED: Navigate to email verification instead of login
      Navigator.pushReplacementNamed(
        context,
        '/email_verification',
        arguments: email, // Pass email to verification screen
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account created! Please verify your email."),
          backgroundColor: primaryColor,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? "Signup failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FFFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              Text(
                "Create Account ✨",
                style: TextStyle(
                  color: Color(0xFF0B4F3A),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Join the Intelligent Wallet system",
                style: TextStyle(color: Color(0xFF6E8B80), fontSize: 16),
              ),

              const SizedBox(height: 32),

              // USERNAME (REQUIRED BY BACKEND)
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  errorText: _usernameError,
                  prefixIcon: Icon(Icons.account_circle, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  helperText: "Used for login",
                ),
              ),

              const SizedBox(height: 16),

              // FULL NAME
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // EMAIL
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: _emailError,
                  prefixIcon: Icon(Icons.email, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // PASSWORD
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: _passwordError,
                  prefixIcon: Icon(Icons.lock, color: primaryColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  helperText: "8+ chars, uppercase, lowercase, digit, special",
                  helperMaxLines: 2,
                ),
              ),

              const SizedBox(height: 16),

              // CONFIRM PASSWORD
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  errorText: _confirmPasswordError,
                  prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() =>
                      _obscureConfirmPassword = !_obscureConfirmPassword);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // REGISTER BUTTON
              ElevatedButton(
                onPressed: isLoading ? null : _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
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
                    : const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}