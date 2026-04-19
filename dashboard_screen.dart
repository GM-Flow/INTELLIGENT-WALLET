/*import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.dashboard, size: 30, color: Color(0xFF0B6B43)),
            Icon(Icons.history, size: 28, color: Colors.grey),
            Icon(Icons.show_chart, size: 28, color: Colors.grey),
            Icon(Icons.person_outline, size: 28, color: Colors.grey),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("Intelligent Wallet 💼",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              SizedBox(height: 10),
              Text("Hi, Olivia! 👋",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text("Let your wallet think for you. 🤖",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              SizedBox(height: 25),

              // Current Balance Card
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF00C192), Color(0xFF0B8F67)]),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Balance",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    SizedBox(height: 8),
                    Text("\$12,450.75",
                        style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                    SizedBox(height: 6),
                    Text("+\$250.30 from last month",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("View Details ➜",
                            style:
                            TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F9F5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_downward,
                              color: Colors.green, size: 26),
                          SizedBox(height: 6),
                          Text("\$5,830.00",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800)),
                          SizedBox(height: 4),
                          Text("+8.2%",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 2),
                          Text("Received",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F9F5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_upward,
                              color: Colors.orange, size: 26),
                          SizedBox(height: 6),
                          Text("\$2,150.50",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800)),
                          SizedBox(height: 4),
                          Text("+12.5%",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 2),
                          Text("Spent",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 26),
              Text("Spending Trends 📊",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              SizedBox(height: 6),

              // Trend Chart Placeholder
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text("Trend Chart Placeholder")),
              ),

              SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Color(0xFF00B68C),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                    child: Text("Smart Investment 📈",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700))),
              ),

              SizedBox(height: 24),
              Text("Inflation Impact 📉",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              SizedBox(height: 10),

              // Inflation Chart Placeholder
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text("Inflation Chart Placeholder")),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final Color primaryColor = Color(0xFF0B6B43);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("Intelligent Wallet 💼",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              SizedBox(height: 10),
              Text("Hi, Olivia! 👋",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text("Let your wallet think for you. 🤖",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              SizedBox(height: 25),

              // Current Balance Card
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF00C192), Color(0xFF0B8F67)]),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Balance",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    SizedBox(height: 8),
                    Text("Rs.20,450.75",
                        style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                    SizedBox(height: 6),
                    Text("+Rs.250.30 from last month",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to Transaction Screen
                          Navigator.pushNamed(context, '/transactions');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text("View Details ➜",
                              style: TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F9F5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_downward, color: Colors.green, size: 26),
                          SizedBox(height: 6),
                          Text("Rs.5,830.00",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800)),
                          SizedBox(height: 4),
                          Text("+8.2%",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 2),
                          Text("Received",
                              style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F9F5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_upward, color: Colors.orange, size: 26),
                          SizedBox(height: 6),
                          Text("Rs.2,150.50",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800)),
                          SizedBox(height: 4),
                          Text("+12.5%",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 2),
                          Text("Spent",
                              style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 26),
              Text("Spending Trends 📊",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              SizedBox(height: 6),
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text("Trend Chart Placeholder")),
              ),

              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/smart_investment');
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                      child: Text("Smart Investment 📈",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w700))),
                ),
              ),

              SizedBox(height: 24),
              Text("Inflation Impact 📉",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              SizedBox(height: 10),
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text("Inflation Chart Placeholder")),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
*/
//now this part 2
/*import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final Color primaryColor = Color(0xFF0B6B43);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header
              const Text("Intelligent Wallet 💼",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              const Text("Hi, Olivia! 👋",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text("Let your wallet think for you. 🤖",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),

              const SizedBox(height: 25),

              // Current Balance Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF00C192), Color(0xFF0B8F67)]),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Current Balance",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    const SizedBox(height: 8),
                    const Text("Rs.20,450.75",
                        style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(height: 6),
                    const Text("+Rs.250.30 from last month",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),

                    // View Details Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/transactions');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text("View Details ➜",
                              style:
                              TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // --------------------- ADD TRANSACTION BUTTON ---------------------
              // ADD TRANSACTION BUTTON (functional)
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/add_transaction');
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      "Add Transaction ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),



              const SizedBox(height: 24),

              // --------------------- RECEIVED & SPENT CARDS ---------------------
              Row(
                children: [
                  // RECEIVED (Clickable)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/transactions');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F9F5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.arrow_downward,
                                color: Colors.green, size: 26),
                            const SizedBox(height: 6),
                            const Text("Rs.5,830.00",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 4),
                            Text("Received",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // SPENT (Clickable)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/transactions');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F9F5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.arrow_upward,
                                color: Colors.orange, size: 26),
                            const SizedBox(height: 6),
                            const Text("Rs.2,150.50",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 4),
                            Text("Spent",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Spending Trends
              const Text("Spending Trends 📊",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),

              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(child: Text("Trend Chart Placeholder")),
              ),

              const SizedBox(height: 24),

              // Smart Investment Button
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/smart_investment');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text("Smart Investment 📈",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text("Inflation Impact 📉",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),

              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(child: Text("Inflation Chart Placeholder")),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final Color primaryColor = Color(0xFF0B6B43);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header
              const Text("Intelligent Wallet 💼",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              const Text("Hi, Olivia! 👋",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text("Let your wallet think for you. 🤖",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),

              const SizedBox(height: 25),

              // Current Balance Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF00C192), Color(0xFF0B8F67)]),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Current Balance",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    const SizedBox(height: 8),
                    const Text("Rs.20,450.75",
                        style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(height: 6),
                    const Text("+Rs.250.30 from last month",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),

                    // View Details Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/transactions');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text("View Details ➜",
                              style:
                              TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ADD TRANSACTION BUTTON
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/add_transaction');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      "Add Transaction ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // RECEIVED & SPENT CARDS
              Row(
                children: [
                  // RECEIVED (Clickable)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/transactions');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F9F5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.arrow_downward,
                                color: Colors.green, size: 26),
                            const SizedBox(height: 6),
                            const Text("Rs.5,830.00",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 4),
                            Text("Received",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // SPENT (Clickable)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/transactions');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F9F5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.arrow_upward,
                                color: Colors.orange, size: 26),
                            const SizedBox(height: 6),
                            const Text("Rs.2,150.50",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 4),
                            Text("Spent",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Spending Trends
              const Text("Spending Trends 📊",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),

              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(child: Text("Trend Chart Placeholder")),
              ),

              const SizedBox(height: 24),

              // Smart Investment Button
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/smart_investment');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text("Smart Investment 📈",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text("Inflation Impact 📉",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),

              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(child: Text("Inflation Chart Placeholder")),
              ),

              const SizedBox(height: 40),

              // --------------------- NAVIGATION TO FRAUD PREVENTION ---------------------
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/fraud_prevention');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      "Go to Fraud Prevention 🔒",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // --------------------- NAVIGATION TO WALLET INSIGHTS ---------------------
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/wallet_insights');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      "Go to Wallet Insights 💡",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color primaryColor = Color(0xFF0B6B43);

  bool _isLoading = true;
  String _userName = "User";
  double _currentBalance = 0.0;
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    try {
      // Get user info
      final authProvider = context.read<AuthProvider>();
      final user = authProvider.user;

      if (user != null && user['name'] != null) {
        _userName = user['name'];
      }

      // Fetch transaction summary from backend
      final response = await ApiService.get(
        '/api/v1/transactions/stats/summary',
        authenticated: true,
      );

      print('📊 Dashboard Stats Response: ${response.statusCode}');
      print('📄 Dashboard Stats Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _totalIncome = (data['total_income'] ?? 0.0).toDouble();
          _totalExpense = (data['total_expenses'] ?? 0.0).toDouble();
          _currentBalance = (data['net_balance'] ?? 0.0).toDouble();
          _isLoading = false;
        });
      } else if (response.statusCode == 404) {
        // No transactions yet - this is okay
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Failed to load dashboard data";
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Dashboard Error: $e');
      setState(() {
        _errorMessage = "Network error: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadDashboardData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Header
                const Text("Intelligent Wallet 💼",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),

                // Real Username from Backend
                Text("Hi, $_userName! 👋",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text("Let your wallet think for you. 🤖",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),

                const SizedBox(height: 25),

                // Show loading or error
                if (_isLoading)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                  )
                else if (_errorMessage.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[700]),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Current Balance Card - Real Data
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF00C192), Color(0xFF0B8F67)]),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Current Balance",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      const SizedBox(height: 8),

                      // Real Balance from Backend
                      Text(
                        "Rs.${_currentBalance.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 6),

                      Text(
                        _currentBalance >= 0
                            ? "Net balance (Income - Expenses)"
                            : "Expenses exceed income",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),

                      // View Details Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/transactions');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text("View Details ➜",
                                style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ADD TRANSACTION BUTTON
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/add_transaction');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        "Add Transaction ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // RECEIVED & SPENT CARDS - Real Data
                Row(
                  children: [
                    // RECEIVED (Real Income)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/transactions');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F9F5),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.arrow_downward,
                                  color: Colors.green, size: 26),
                              const SizedBox(height: 6),
                              Text(
                                "Rs.${_totalIncome.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 4),
                              Text("Received",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    // SPENT (Real Expenses)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/transactions');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F9F5),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.arrow_upward,
                                  color: Colors.orange, size: 26),
                              const SizedBox(height: 6),
                              Text(
                                "Rs.${_totalExpense.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 4),
                              Text("Spent",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Spending Trends
                const Text("Spending Trends 📊",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),

                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(child: Text("Trend Chart Placeholder")),
                ),

                const SizedBox(height: 24),

                // Smart Investment Button
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/smart_investment');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text("Smart Investment 📈",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text("Inflation Impact 📉",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),

                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(child: Text("Inflation Chart Placeholder")),
                ),

                const SizedBox(height: 40),

                // --------------------- NAVIGATION TO FRAUD PREVENTION (AI MODEL) ---------------------
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/fraud_prevention');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        "Fraud Prevention AI 🔒",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // --------------------- NAVIGATION TO INFLATION TRACKING (AI MODEL) ---------------------
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/wallet_insights');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        "Inflation Tracking AI 💡",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
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
import 'package:fl_chart/fl_chart.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color primaryColor = Color(0xFF0B6B43);

  bool _isLoading = true;
  String _userName = "User";
  double _currentBalance = 0.0;
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  String _errorMessage = "";

  // Chart data
  List<Map<String, dynamic>> _recentTransactions = [];
  Map<String, double> _categoryData = {};
  List<FlSpot> _trendData = [];

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    try {
      final authProvider = context.read<AuthProvider>();
      final user = authProvider.user;

      if (user != null && user['name'] != null) {
        _userName = user['name'];
      }

      // Fetch ALL transactions
      final transactionsResponse = await ApiService.get(
        '/api/v1/transactions/',
        authenticated: true,
      );

      if (transactionsResponse.statusCode == 200) {
        final transactionBody = jsonDecode(transactionsResponse.body);

        List transactions = [];
        if (transactionBody is List) {
          transactions = transactionBody;
        } else if (transactionBody is Map && transactionBody['items'] != null) {
          transactions = transactionBody['items'] as List;
        }

        print('✅ Loaded ${transactions.length} transactions');

        if (transactions.isNotEmpty) {
          // Calculate totals manually from transactions
          _totalIncome = 0.0;
          _totalExpense = 0.0;
          Map<String, double> categoryTotals = {};

          for (var trans in transactions) {
            double amount = (trans['amount'] as num).toDouble();
            String type = trans['type'] ?? '';
            String category = trans['category'] ?? 'other';

            if (type == 'income') {
              _totalIncome += amount;
            } else if (type == 'expense') {
              _totalExpense += amount;

              // Aggregate by category for pie chart
              categoryTotals[category] = (categoryTotals[category] ?? 0) + amount;
            }
          }

          _currentBalance = _totalIncome - _totalExpense;
          _categoryData = categoryTotals;

          // Store recent transactions (last 5)
          _recentTransactions = transactions.reversed.take(5).map((t) => {
            'id': t['id'],
            'amount': (t['amount'] as num).toDouble(),
            'type': t['type'],
            'category': t['category'],
            'date': t['date'],
          }).toList();

          // Generate trend data
          _generateTrendData(transactions);

          print('💰 Income: $_totalIncome, Expense: $_totalExpense, Balance: $_currentBalance');
          print('📊 Categories: $_categoryData');
        }
      } else {
        print('❌ Transactions API error: ${transactionsResponse.statusCode}');
        _errorMessage = "Failed to load transactions";
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Dashboard Error: $e');
      setState(() {
        _errorMessage = "Network error. Pull down to refresh.";
        _isLoading = false;
      });
    }
  }

  void _generateTrendData(List transactions) {
    // Get last 7 expense transactions and distribute them
    Map<int, double> dailySpending = {};

    for (int i = 0; i < 7; i++) {
      dailySpending[i] = 0.0;
    }

    List expenseTransactions = transactions
        .where((t) => t['type'] == 'expense')
        .toList();

    for (int i = 0; i < expenseTransactions.length && i < 7; i++) {
      double amount = (expenseTransactions[i]['amount'] as num).toDouble();
      dailySpending[i] = amount;
    }

    _trendData = dailySpending.entries
        .map((e) => FlSpot(e.key.toDouble(), e.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadDashboardData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Header
                const Text("Intelligent Wallet 💼",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),

                // Real Username from Backend
                Text("Hi, $_userName! 👋",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text("Let your wallet think for you. 🤖",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),

                const SizedBox(height: 25),

                // Show loading or error
                if (_isLoading)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                  )
                else if (_errorMessage.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[700]),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Current Balance Card - Real Data
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF00C192), Color(0xFF0B8F67)]),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Current Balance",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      const SizedBox(height: 8),

                      Text(
                        "Rs.${_currentBalance.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 6),

                      Text(
                        _currentBalance >= 0
                            ? "Net balance (Income - Expenses)"
                            : "Expenses exceed income",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/transactions');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text("View Details ➜",
                                style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ADD TRANSACTION BUTTON - UPDATED WITH REFRESH ⬇️
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.pushNamed(context, '/add_transaction');
                    if (result == true) {
                      // Refresh dashboard when transaction is added
                      _loadDashboardData();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        "Add Transaction",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // RECEIVED & SPENT CARDS
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/transactions');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F9F5),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.arrow_downward,
                                  color: Colors.green, size: 26),
                              const SizedBox(height: 6),
                              Text(
                                "Rs.${_totalIncome.toStringAsFixed(0)}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 4),
                              Text("Received",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/transactions');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F9F5),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.arrow_upward,
                                  color: Colors.orange, size: 26),
                              const SizedBox(height: 6),
                              Text(
                                "Rs.${_totalExpense.toStringAsFixed(0)}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 4),
                              Text("Spent",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

// Spending Trends - REAL CHART WITH NAVIGATION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Spending Trends 📊",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/analytics');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: primaryColor.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'View Analytics',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 16, color: primaryColor),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Container(
                  height: 200,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: _trendData.isEmpty
                      ? Center(
                    child: Text(
                      "No transaction data yet",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                      : LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                'Rs.${value.toInt()}',
                                style: TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                              int index = value.toInt();
                              if (index >= 0 && index < days.length) {
                                return Text(days[index], style: TextStyle(fontSize: 10));
                              }
                              return Text('');
                            },
                          ),
                        ),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _trendData,
                          isCurved: true,
                          color: primaryColor,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: primaryColor.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Smart Investment Button
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/smart_investment');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text("Smart Investment 📈",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Category Spending - REAL PIE CHART
                const Text("Category Spending 🥧",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),

                Container(
                  height: 220,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: _categoryData.isEmpty
                      ? Center(
                    child: Text(
                      "No category data yet",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                      : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: PieChart(
                          PieChartData(
                            sections: _getCategoryChartSections(),
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _getCategoryLegend(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // FRAUD PREVENTION AI BUTTON
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/fraud_prevention');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        "Fraud Prevention AI 🔒",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // INFLATION TRACKING AI BUTTON
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/wallet_insights');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        "Inflation Tracking AI 💡",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper: Generate pie chart sections
  List<PieChartSectionData> _getCategoryChartSections() {
    final colors = [
      Color(0xFF0B6B43),
      Color(0xFF00C192),
      Color(0xFFFF6B6B),
      Color(0xFFFFAA00),
      Color(0xFF4ECDC4),
    ];

    int index = 0;
    return _categoryData.entries.map((entry) {
      final color = colors[index % colors.length];
      index++;
      return PieChartSectionData(
        value: entry.value,
        title: 'Rs.${entry.value.toInt()}',
        color: color,
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  // Helper: Generate legend for pie chart
  List<Widget> _getCategoryLegend() {
    final colors = [
      Color(0xFF0B6B43),
      Color(0xFF00C192),
      Color(0xFFFF6B6B),
      Color(0xFFFFAA00),
      Color(0xFF4ECDC4),
    ];

    int index = 0;
    return _categoryData.entries.map((entry) {
      final color = colors[index % colors.length];
      index++;
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                entry.key,
                style: TextStyle(fontSize: 11),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}