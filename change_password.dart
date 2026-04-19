/*import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  static const Color gradientStart = Color(0xFF00C192);
  static const Color gradientEnd = Color(0xFF0B8F67);
  static const Color accent = Color(0xFF0B6B43);

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: call backend to change password
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password changed (mock)')));
      Navigator.pop(context);
    }
  }

  String? _validateNew(String? v) {
    if (v == null || v.trim().length < 6) return 'New password must be at least 6 chars';
    return null;
  }

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
          child: const Text('Change Password', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _currentCtrl,
                    decoration: InputDecoration(
                      labelText: 'Current password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureCurrent ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscureCurrent = !_obscureCurrent),
                      ),
                    ),
                    obscureText: _obscureCurrent,
                    validator: (v) => (v == null || v.isEmpty) ? 'Enter current password' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _newCtrl,
                    decoration: InputDecoration(
                      labelText: 'New password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureNew ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscureNew = !_obscureNew),
                      ),
                    ),
                    obscureText: _obscureNew,
                    validator: (v) => _validateNew(v),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _confirmCtrl,
                    decoration: InputDecoration(
                      labelText: 'Confirm new password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                    ),
                    obscureText: _obscureConfirm,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Confirm password';
                      if (v != _newCtrl.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accent,
                            minimumSize: const Size.fromHeight(48),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Change Password'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  static const Color gradientStart = Color(0xFF00C192);
  static const Color gradientEnd = Color(0xFF0B8F67);
  static const Color accent = Color(0xFF0B6B43);

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: call backend to change password
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password changed (mock)')));
      Navigator.pop(context);
    }
  }

  String? _validateNew(String? v) {
    if (v == null || v.trim().length < 6) return 'New password must be at least 6 chars';
    return null;
  }

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
          child: const Text('     Change Password', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _currentCtrl,
                    decoration: InputDecoration(
                      labelText: 'Current password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureCurrent ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscureCurrent = !_obscureCurrent),
                      ),
                    ),
                    obscureText: _obscureCurrent,
                    validator: (v) => (v == null || v.isEmpty) ? 'Enter current password' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _newCtrl,
                    decoration: InputDecoration(
                      labelText: 'New password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureNew ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscureNew = !_obscureNew),
                      ),
                    ),
                    obscureText: _obscureNew,
                    validator: (v) => _validateNew(v),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _confirmCtrl,
                    decoration: InputDecoration(
                      labelText: 'Confirm new password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                    ),
                    obscureText: _obscureConfirm,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Confirm password';
                      if (v != _newCtrl.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accent,
                            minimumSize: const Size.fromHeight(48),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            'Change Password',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
