import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Color primaryColor = Color(0xFF0B6B43);

  // User data from backend
  String _userName = "User";
  String _userEmail = "user@email.com";
  String _userUsername = "username";

  // Notification preferences (stored locally)
  bool pushNotif = true;
  bool emailNotif = false;
  bool smsNotif = false;
  bool budgetAlerts = true;
  bool investmentAlerts = true;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadNotificationPreferences();
  }

  Future<void> _loadUserData() async {
    final authProvider = context.read<AuthProvider>();
    final user = authProvider.user;

    if (user != null) {
      setState(() {
        _userName = user['name'] ?? 'User';
        _userEmail = user['email'] ?? 'user@email.com';
        _userUsername = user['username'] ?? 'username';
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadNotificationPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pushNotif = prefs.getBool('pushNotif') ?? true;
      emailNotif = prefs.getBool('emailNotif') ?? false;
      smsNotif = prefs.getBool('smsNotif') ?? false;
      budgetAlerts = prefs.getBool('budgetAlerts') ?? true;
      investmentAlerts = prefs.getBool('investmentAlerts') ?? true;
    });
  }

  Future<void> _saveNotificationPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pushNotif', pushNotif);
    await prefs.setBool('emailNotif', emailNotif);
    await prefs.setBool('smsNotif', smsNotif);
    await prefs.setBool('budgetAlerts', budgetAlerts);
    await prefs.setBool('investmentAlerts', investmentAlerts);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Settings saved successfully!'),
        backgroundColor: primaryColor,
      ),
    );
  }

  Future<void> _handleLogout() async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final authProvider = context.read<AuthProvider>();
      await authProvider.logout();

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: primaryColor),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Settings ⚙️",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Card - REAL DATA
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00C192), Color(0xFF0B8F67)],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar with first letter of name
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Text(
                      _userName.isNotEmpty ? _userName[0].toUpperCase() : 'U',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '@$_userUsername',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          _userEmail,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Notification Settings Section
            Text(
              "Notification Preferences 🔔",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 12),

            _notifTile(
              "Push Notifications",
              "Receive app alerts instantly 📱",
              pushNotif,
                  (v) {
                setState(() => pushNotif = v);
                _saveNotificationPreferences();
              },
            ),
            SizedBox(height: 12),

            _notifTile(
              "Email Notifications",
              "Get updates in your inbox ✉️",
              emailNotif,
                  (v) {
                setState(() => emailNotif = v);
                _saveNotificationPreferences();
              },
            ),
            SizedBox(height: 12),

            _notifTile(
              "SMS Alerts",
              "Important wallet alerts via SMS 📩",
              smsNotif,
                  (v) {
                setState(() => smsNotif = v);
                _saveNotificationPreferences();
              },
            ),

            SizedBox(height: 24),
            Divider(thickness: 1.2),
            SizedBox(height: 24),

            // Alert Preferences
            Text(
              "Alert Preferences 🚨",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 12),

            _notifTile(
              "Budget Alerts",
              "Warn me when I overspend 💸",
              budgetAlerts,
                  (v) {
                setState(() => budgetAlerts = v);
                _saveNotificationPreferences();
              },
            ),
            SizedBox(height: 12),

            _notifTile(
              "Investment Updates",
              "Track my investment performance 📈",
              investmentAlerts,
                  (v) {
                setState(() => investmentAlerts = v);
                _saveNotificationPreferences();
              },
            ),

            SizedBox(height: 30),
            Divider(thickness: 1.2),
            SizedBox(height: 20),

            // Account Actions
            Text(
              "Account 👤",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 12),

            _menuItem(
              icon: Icons.edit,
              title: "Edit Profile",
              subtitle: "Update your personal information",
              onTap: () {
                Navigator.pushNamed(context, '/edit_profile');
              },
            ),

            SizedBox(height: 12),

            _menuItem(
              icon: Icons.lock,
              title: "Change Password",
              subtitle: "Update your account password",
              onTap: () {
                Navigator.pushNamed(context, '/change_password');
              },
            ),

            SizedBox(height: 12),

            _menuItem(
              icon: Icons.info,
              title: "About App",
              subtitle: "Version and information",
              onTap: () {
                Navigator.pushNamed(context, '/app_info');
              },
            ),

            SizedBox(height: 30),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _handleLogout,
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _notifTile(
      String title,
      String subtitle,
      bool value,
      Function(bool) onChange,
      ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF4FBF7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: primaryColor,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFF4FBF7),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: primaryColor, size: 24),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
