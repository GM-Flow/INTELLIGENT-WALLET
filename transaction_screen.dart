/*import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> today = [
    {"name": "Whole Foods Market", "category": "Groceries", "amount": -84.50, "icon": Icons.shopping_cart},
    {"name": "Starbucks Coffee", "category": "Coffee", "amount": -5.75, "icon": Icons.local_cafe},
  ];

  final List<Map<String, dynamic>> yesterday = [
    {"name": "Monthly Salary", "category": "Income", "amount": 2500.00, "icon": Icons.work},
    {"name": "Metro Transit", "category": "Transportation", "amount": -2.25, "icon": Icons.directions_bus},
  ];

  final List<Map<String, dynamic>> older = [
    {"name": "Netflix Subscription", "category": "Entertainment", "amount": -15.49, "icon": Icons.movie},
    {"name": "Venmo Payment", "category": "From Jane Doe", "amount": 30.00, "icon": Icons.receipt_long},
  ];

  Widget itemTile(name, cat, amount, icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ]),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFEFF7F5),
            child: Icon(icon, color: Colors.black87),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700)),
                SizedBox(height: 2),
                Text(cat,
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(
            "${amount < 0 ? "-" : "+"}\$${amount.abs().toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: amount < 0 ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Transactions 💳",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("Today",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            for (var t in today)
              itemTile(t["name"], t["category"], t["amount"], t["icon"]),
            SizedBox(height: 20),
            Text("Yesterday",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            for (var t in yesterday)
              itemTile(t["name"], t["category"], t["amount"], t["icon"]),
            SizedBox(height: 20),
            Text("October 25",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            for (var t in older)
              itemTile(t["name"], t["category"], t["amount"], t["icon"]),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
*/

/*
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  static const Color accent = Color(0xFF0B6B43);

  String selectedFilter = "ALL"; // ALL / SENT / RECEIVED

  // ---------------------- SAMPLE DATA ----------------------
  final List<Map<String, dynamic>> today = [
    {"name": "Whole Foods Market", "category": "Groceries", "amount": -845.0, "icon": Icons.shopping_cart},
    {"name": "Starbucks Coffee", "category": "Coffee", "amount": -575.0, "icon": Icons.local_cafe},
  ];

  final List<Map<String, dynamic>> yesterday = [
    {"name": "Monthly Salary", "category": "Income", "amount": 250000.0, "icon": Icons.work},
    {"name": "Metro Transit", "category": "Transportation", "amount": -225.0, "icon": Icons.directions_bus},
  ];

  final List<Map<String, dynamic>> older = [
    {"name": "Netflix Subscription", "category": "Entertainment", "amount": -1549.0, "icon": Icons.movie},
    {"name": "Payment Received", "category": "From Jane", "amount": 3000.0, "icon": Icons.receipt_long},
  ];

  // ---------------------- FILTER LOGIC ----------------------
  List<Map<String, dynamic>> applyFilter(List<Map<String, dynamic>> list) {
    if (selectedFilter == "ALL") return list;
    if (selectedFilter == "SENT") return list.where((t) => t["amount"] < 0).toList();
    if (selectedFilter == "RECEIVED") return list.where((t) => t["amount"] > 0).toList();
    return list;
  }

  // ---------------------- UI: TRANSACTION CARD ----------------------
  Widget transactionTile(Map<String, dynamic> t) {
    bool sent = t["amount"] < 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFEFF7F5),
            child: Icon(t["icon"], color: accent),
          ),
          const SizedBox(width: 14),

          // NAME + CATEGORY
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t["name"], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(t["category"], style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),

          // AMOUNT
          Text(
            "${sent ? "-" : "+"} Rs. ${t["amount"].abs().toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: sent ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------- UI: FILTER PILLS ----------------------
  Widget filterPill(String text) {
    bool active = (selectedFilter == text);

    return GestureDetector(
      onTap: () => setState(() => selectedFilter = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: active ? accent : Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: accent, width: 1.4),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : accent,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ---------------------- BUILD UI ----------------------
  @override
  Widget build(BuildContext context) {
    final todayList = applyFilter(today);
    final yesterdayList = applyFilter(yesterday);
    final olderList = applyFilter(older);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Transactions 💳",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------------- FILTER BAR ----------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                filterPill("ALL"),
                filterPill("SENT"),
                filterPill("RECEIVED"),
              ],
            ),

            const SizedBox(height: 20),

            // ---------------------- TODAY ----------------------
            if (todayList.isNotEmpty) ...[
              const Text("Today",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              for (var t in todayList) transactionTile(t),
              const SizedBox(height: 20),
            ],

            // ---------------------- YESTERDAY ----------------------
            if (yesterdayList.isNotEmpty) ...[
              const Text("Yesterday",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              for (var t in yesterdayList) transactionTile(t),
              const SizedBox(height: 20),
            ],

            // ---------------------- OLDER DATE (DO NOT CHANGE FORMAT) ----------------------
            if (olderList.isNotEmpty) ...[
              const Text("October 25",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              for (var t in olderList) transactionTile(t),
              const SizedBox(height: 40),
            ],
          ],
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import 'dart:convert';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final Color primaryColor = const Color(0xFF0B6B43);

  bool _isLoading = true;
  List<dynamic> _allTransactions = [];
  List<dynamic> _filteredTransactions = [];
  String _selectedFilter = 'all';
  String _selectedCategory = 'all';

  final List<String> categories = [
    'all',
    'salary',
    'freelance',
    'business',
    'investment',
    'food',
    'rent',
    'transport',
    'utilities',
    'entertainment',
    'healthcare',
    'education',
    'shopping',
    'other',
  ];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoading = true);

    try {
      final response = await ApiService.get(
        '/api/v1/transactions/',
        authenticated: true,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List transactions = data is List ? data : data['items'] ?? [];

        transactions.sort((a, b) {
          DateTime aDate = DateTime.parse(
            a['created_at'] ?? a['date'] ?? DateTime.now().toString(),
          );
          DateTime bDate = DateTime.parse(
            b['created_at'] ?? b['date'] ?? DateTime.now().toString(),
          );
          return bDate.compareTo(aDate);
        });

        setState(() {
          _allTransactions = transactions;
          _filteredTransactions = transactions;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  void _applyFilters() {
    List<dynamic> filtered = _allTransactions;

    if (_selectedFilter != 'all') {
      filtered = filtered.where((t) => t['type'] == _selectedFilter).toList();
    }

    if (_selectedCategory != 'all') {
      filtered =
          filtered.where((t) => t['category'] == _selectedCategory).toList();
    }

    setState(() => _filteredTransactions = filtered);
  }

  Future<void> _deleteTransaction(int id) async {
    try {
      final response = await ApiService.delete(
        '/api/v1/transactions/$id',
        authenticated: true,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Transaction deleted'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        _loadTransactions();
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Failed to delete transaction'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add_transaction')
                  .then((_) => _loadTransactions());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: _isLoading
                ? Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
                : _filteredTransactions.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
              onRefresh: _loadTransactions,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredTransactions.length,
                itemBuilder: (context, index) {
                  return _buildTransactionCard(
                      _filteredTransactions[index]);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/add_transaction')
              .then((_) => _loadTransactions());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: primaryColor.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filter by Type',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              _filterChip('All', 'all'),
              _filterChip('Income', 'income'),
              _filterChip('Expense', 'expense'),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Filter by Category',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories
                  .map((c) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _categoryChip(c),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, String value) {
    final bool selected = _selectedFilter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: primaryColor,
        onSelected: (_) {
          _selectedFilter = value;
          _applyFilters();
        },
        labelStyle: TextStyle(
          color: selected ? Colors.white : primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _categoryChip(String category) {
    final bool selected = _selectedCategory == category;
    return ChoiceChip(
      label: Text(category.toUpperCase(), style: const TextStyle(fontSize: 11)),
      selected: selected,
      selectedColor: primaryColor.withOpacity(0.2),
      onSelected: (_) {
        _selectedCategory = category;
        _applyFilters();
      },
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> t) {
    final bool isIncome = t['type'] == 'income';
    final Color color = isIncome ? Colors.green : Colors.red;

    DateTime? date =
    DateTime.tryParse(t['created_at'] ?? t['date'] ?? '');
    final String dateStr =
    date != null ? DateFormat('MMM dd, yyyy').format(date) : 'Unknown';

    // NEW: Get recipient info
    final String recipient = t['recipient'] ?? '';
    final String description = t['description'] ?? 'No description';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          isIncome ? Icons.arrow_downward : Icons.arrow_upward,
          color: color,
        ),
        title: Text(
          description,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${t['category'] ?? 'other'} • $dateStr'),
            // NEW: Show recipient if exists
            if (recipient.isNotEmpty)
              Text(
                '👤 $recipient',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        trailing: Text(
          '${isIncome ? '+' : '-'}Rs.${(t['amount'] ?? 0).toStringAsFixed(0)}',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
        onLongPress: () => _showDeleteConfirmation(t['id']),
      ),
    );
  }

  // NEW: Add confirmation dialog before deleting
  void _showDeleteConfirmation(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteTransaction(id);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No Transactions Found',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}