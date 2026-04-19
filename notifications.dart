/*import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _push = true;
  bool _email = false;
  bool _sms = false;
  bool _promotions = true;

  static const Color gradientStart = Color(0xFF00C192);
  static const Color gradientEnd = Color(0xFF0B8F67);
  static const Color accent = Color(0xFF0B6B43);

  void _save() {
    // TODO: save notification prefs to backend
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification settings saved (mock)')));
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
          child: const Text('Notification Settings', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Card(
          color: const Color(0xFFF1F9F5),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              SwitchListTile.adaptive(
                title: const Text('Push Notifications'),
                subtitle: const Text('Receive app alerts'),
                value: _push,
                onChanged: (v) => setState(() => _push = v),
              ),
              const Divider(height: 1),
              SwitchListTile.adaptive(
                title: const Text('Email Notifications'),
                subtitle: const Text('Get updates in your inbox'),
                value: _email,
                onChanged: (v) => setState(() => _email = v),
              ),
              const Divider(height: 1),
              SwitchListTile.adaptive(
                title: const Text('SMS Alerts'),
                subtitle: const Text('Important wallet alerts via SMS'),
                value: _sms,
                onChanged: (v) => setState(() => _sms = v),
              ),
              const Divider(height: 1),
              SwitchListTile.adaptive(
                title: const Text('Promotional Messages'),
                subtitle: const Text('Offers and promotions'),
                value: _promotions,
                onChanged: (v) => setState(() => _promotions = v),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Save Settings'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _push = true;
  bool _email = false;
  bool _sms = false;
  bool _promotions = true;

  static const Color gradientStart = Color(0xFF00C192);
  static const Color gradientEnd = Color(0xFF0B8F67);
  static const Color accent = Color(0xFF0B6B43);
  static const Color cardBg = Color(0xFFF1F9F5);

  void _save() {
    // TODO: save notification prefs to backend
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification settings saved (mock)')));
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
          child: const Text('Notification Settings', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Card(
          color: cardBg,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              SwitchListTile.adaptive(
                title: const Text('Push Notifications'),
                subtitle: const Text('Receive app alerts'),
                value: _push,
                activeColor: accent, // thumb
                activeTrackColor: const Color(0xFF00C192), // track
                onChanged: (v) => setState(() => _push = v),
              ),
              const Divider(height: 1),
              SwitchListTile.adaptive(
                title: const Text('Email Notifications'),
                subtitle: const Text('Get updates in your inbox'),
                value: _email,
                activeColor: accent,
                activeTrackColor: const Color(0xFF00C192),
                onChanged: (v) => setState(() => _email = v),
              ),
              const Divider(height: 1),
              SwitchListTile.adaptive(
                title: const Text('SMS Alerts'),
                subtitle: const Text('Important wallet alerts via SMS'),
                value: _sms,
                activeColor: accent,
                activeTrackColor: const Color(0xFF00C192),
                onChanged: (v) => setState(() => _sms = v),
              ),
              const Divider(height: 1),
              SwitchListTile.adaptive(
                title: const Text('Promotional Messages'),
                subtitle: const Text('Offers and promotions'),
                value: _promotions,
                activeColor: accent,
                activeTrackColor: const Color(0xFF00C192),
                onChanged: (v) => setState(() => _promotions = v),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'Save Settings',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
