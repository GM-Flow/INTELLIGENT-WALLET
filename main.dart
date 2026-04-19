/*import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/transaction_screen.dart';
import 'screens/smart_investment.dart';
import 'screens/profile_screen.dart';
import 'screens/forgot_password.dart';
import 'screens/edit_profile.dart';
import 'screens/change_password.dart';
import 'screens/notifications.dart';
import 'screens/app_info.dart';
import 'screens/AddTransactionScreen.dart';
import 'screens/fraud_Prevention_ui_screen.dart';
import 'screens/ai_wallet_insights_ui_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intelligent Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
      routes: {
        '/login': (_) => LoginScreen(),
        '/signup': (_) => SignupScreen(),
        '/forgot': (_) => ForgotPasswordScreen(),
        '/home': (_) => HomeScreen(),
        '/fraud_prevention': (_) => FraudPreventionScreen(),  // New: Fraud UI
        '/wallet_insights': (_) => WalletInsightsScreen(),    // New: Insights UI
        // Main Features
        '/transactions': (_) => TransactionsScreen(),
        '/smart_investment': (_) => SmartInvestmentScreen(),
        '/add_transaction': (_) => AddTransactionScreen(),

        // Profile Related Screens
        '/profile': (_) => ProfileScreen(),
        '/edit_profile': (_) => EditProfileScreen(),
        '/change_password': (_) => ChangePasswordScreen(),
        '/notifications': (_) => NotificationsScreen(),
        '/app_info': (_) => AppInfoScreen(),
      },
    );
  }
}


*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/transaction_screen.dart';
import 'screens/smart_investment.dart';
import 'screens/profile_screen.dart';
import 'screens/forgot_password.dart';
import 'screens/edit_profile.dart';
import 'screens/change_password.dart';
import 'screens/notifications.dart';
import 'screens/app_info.dart';
import 'screens/AddTransactionScreen.dart';
import 'screens/fraud_Prevention_ui_screen.dart';
import 'screens/ai_wallet_insights_ui_screen.dart';
import 'screens/-settings_screen.dart';
import 'screens/analytics_screen.dart';
// ✅ NEW IMPORTS
import 'screens/email_verification_screen.dart';
import 'screens/reset_password_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intelligent Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: SplashScreen(),
      routes: {
        '/login': (_) => LoginScreen(),
        '/signup': (_) => SignupScreen(),
        '/forgot': (_) => ForgotPasswordScreen(),
        '/home': (_) => HomeScreen(),
        '/fraud_prevention': (_) => FraudPreventionScreen(),
        '/wallet_insights': (_) => WalletInsightsScreen(),
        '/transactions': (_) => TransactionScreen(),
        '/smart_investment': (_) => SmartInvestmentScreen(),
        '/add_transaction': (_) => AddTransactionScreen(),
        '/profile': (_) => ProfileScreen(),
        '/edit_profile': (_) => EditProfileScreen(),
        '/change_password': (_) => ChangePasswordScreen(),
        '/notifications': (_) => NotificationsScreen(),
        '/app_info': (_) => AppInfoScreen(),
        '/settings': (_) => SettingsScreen(),
        '/analytics': (_) => AnalyticsScreen(),
      },
      // ✅ NEW: Handle routes with arguments (email verification & reset password)
      onGenerateRoute: (settings) {
        if (settings.name == '/email_verification') {
          final email = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (_) => EmailVerificationScreen(email: email ?? ''),
          );
        }
        if (settings.name == '/reset_password') {
          final email = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(email: email ?? ''),
          );
        }
        return null;
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Navigate to login after 2.2 seconds
    Future.delayed(Duration(milliseconds: 2900), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF0B6B43), // Dashboard green background
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: SizedBox()),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            'assets/images/wallet.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 28),
              Text(
                'Intelligent Wallet ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Let your wallet think for you.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}


// ================= Bottom Navigation =================
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    TransactionScreen(),
    SmartInvestmentScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF0B6B43),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Investment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}