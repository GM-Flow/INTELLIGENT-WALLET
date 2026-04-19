/*
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text("Profile 👤",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(26),
        child: Column(
          children: [
            SizedBox(height: 10),
            CircleAvatar(
              radius: 52,
              backgroundColor: Color(0xFFEFF7F5),
              child: Icon(Icons.person, size: 60, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Text("Olivia Johnson",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
            SizedBox(height: 4),
            Text("olivia.johnson@example.com",
                style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3))
                  ]),
              child: Column(
                children: [
                  profileTile(Icons.person_outline, "Edit Profile"),
                  Divider(),
                  profileTile(Icons.lock_outline, "Change Password"),
                  Divider(),
                  profileTile(Icons.notifications_outlined,
                      "Notification Settings"),
                  Divider(),
                  profileTile(Icons.info_outline, "App Information"),
                ],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: Text("Logout 🔐",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget profileTile(icon, text) {
    return Row(
      children: [
        Icon(icon, size: 26, color: Colors.black87),
        SizedBox(width: 16),
        Text(text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        Spacer(),
        Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
      ],
    );
  }
}


import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  final String username = 'OLIVIA';
  final String email = 'olivia.johnson@example.com';

  static const Color gradientStart = Color(0xFF00C192);
  static const Color gradientEnd = Color(0xFF0B8F67);
  static const Color cardBg = Color(0xFFF1F9F5);
  static const Color accent = Color(0xFF0B6B43);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Gradient header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 56, bottom: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [gradientStart, gradientEnd]),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white24,
                  child: const Icon(Icons.person, size: 36, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(email, style: const TextStyle(color: Colors.white70)),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // TODO: open avatar edit
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                )
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    children: [
                      _tile(context, Icons.person_outline, 'Edit Profile', () => Navigator.pushNamed(context, '/edit_profile')),
                      const Divider(),
                      _tile(context, Icons.lock_outline, 'Change Password', () => Navigator.pushNamed(context, '/change_password')),
                      const Divider(),
                      _tile(context, Icons.notifications_outlined, 'Notification Settings', () => Navigator.pushNamed(context, '/notifications')),
                      const Divider(),
                      _tile(context, Icons.info_outline, 'App Information', () => Navigator.pushNamed(context, '/app_info')),
                      const Divider(),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                          child: Row(
                            children: const [
                              Icon(Icons.logout, color: Colors.redAccent),
                              SizedBox(width: 12),
                              Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, size: 26, color: Colors.black87),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

*/

/*import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const Color gradientStart = Color(0xFF00C192);
  static const Color gradientEnd = Color(0xFF0B8F67);
  static const Color accent = Color(0xFF0B6B43);
  static const Color cardBg = Color(0xFFF1F9F5);

  final String username = 'OLIVIA';
  final String email = 'olivia.johnson@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Gradient header with rounded bottom
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 56, bottom: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [gradientStart, gradientEnd]),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  child: const CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 36, color: gradientStart),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(email, style: const TextStyle(color: Colors.white70)),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // TODO: open avatar edit
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                )
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Tiles (Option B - pill-shaped cards)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _pillTile(
                  context,
                  icon: Icons.person_outline,
                  label: 'Edit Profile',
                  onTap: () => Navigator.pushNamed(context, '/edit_profile'),
                ),
                const SizedBox(height: 12),
                _pillTile(
                  context,
                  icon: Icons.lock_outline,
                  label: 'Change Password',
                  onTap: () => Navigator.pushNamed(context, '/change_password'),
                ),
                const SizedBox(height: 12),
                _pillTile(
                  context,
                  icon: Icons.notifications_outlined,
                  label: 'Notification Settings',
                  onTap: () => Navigator.pushNamed(context, '/notifications'),
                ),
                const SizedBox(height: 12),
                _pillTile(
                  context,
                  icon: Icons.info_outline,
                  label: 'App Information',
                  onTap: () => Navigator.pushNamed(context, '/app_info'),
                ),
                const SizedBox(height: 20),

                // Logout full-width pill
                InkWell(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.redAccent),
                        SizedBox(width: 12),
                        Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pillTile(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: accent),
            ),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color primaryColor = Color(0xFF0B6B43);

  // Real user data from backend
  String _userName = "User";
  String _userEmail = "user@email.com";
  String _userUsername = "username";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section with Real User Info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00C192), Color(0xFF0B8F67)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // Profile Avatar with First Letter
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Text(
                        _userName.isNotEmpty ? _userName[0].toUpperCase() : 'U',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Real Username
                    Text(
                      _userName,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),

                    // Real Email
                    Text(
                      _userEmail,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 4),

                    // Real Username Handle
                    Text(
                      '@$_userUsername',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white60,
                      ),
                    ),

                    SizedBox(height: 20),

                    // Edit Profile Button
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/edit_profile');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit, size: 18, color: primaryColor),
                            SizedBox(width: 8),
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Menu Items
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.edit,
                      title: 'Edit Profile',
                      onTap: () {
                        Navigator.pushNamed(context, '/edit_profile');
                      },
                    ),

                    SizedBox(height: 12),

                    _buildMenuItem(
                      icon: Icons.lock,
                      title: 'Change Password',
                      onTap: () {
                        Navigator.pushNamed(context, '/change_password');
                      },
                    ),

                    SizedBox(height: 12),

                    _buildMenuItem(
                      icon: Icons.notifications,
                      title: 'Notification Settings',
                      onTap: () {
                        Navigator.pushNamed(context, '/notifications');
                      },
                    ),

                    SizedBox(height: 12),

                    _buildMenuItem(
                      icon: Icons.info,
                      title: 'App Information',
                      onTap: () {
                        Navigator.pushNamed(context, '/app_info');
                      },
                    ),

                    SizedBox(height: 30),

                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
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
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
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
                        },
                        icon: Icon(Icons.logout, color: Colors.white),
                        label: Text(
                          'Logout',
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
                  ],
                ),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFF4FBF7),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: primaryColor, size: 22),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}