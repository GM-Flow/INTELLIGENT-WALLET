/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController recipientController = TextEditingController(); // NEW CONTROLLER

  String? selectedCategory;

  final List<String> categories = [
    "Food",
    "Salary",
    "Shopping",
    "Entertainment",
    "Transport",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    final String todayFormatted =
    DateFormat("MMMM dd, yyyy").format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Transaction",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0B6B43),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Amount Field
            const Text(
              "Amount",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // -------------------- NEW RECIPIENT FIELD --------------------
            const Text(
              "Recipient",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: recipientController,
              keyboardType: TextInputType.number,
              decoration: InputStreamDecoration("Enter recipient"),
            ),
            const SizedBox(height: 20),
            // --------------------------------------------------------------

            const SizedBox(height: 8),
            const SizedBox(height: 20),

            // Category Dropdown
            const Text(
              "Category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              hint: const Text("Select category"),
              items: categories
                  .map((cat) =>
                  DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Fixed Date (non-editable)
            const Text(
              "Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    todayFormatted,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Note Field
            const Text(
              "Note (Optional)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputStreamDecoration("Enter note..."),
            ),

            const SizedBox(height: 35),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (amountController.text.isEmpty ||
                      selectedCategory == null ||
                      recipientController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Amount, Category & Recipient are required")),
                    );
                    return;
                  }

                  if (recipientController.text.length != 11) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Recipient must be exactly 11 digits")),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Transaction Added Successfully")),
                  );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B6B43),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// Helper widget for cleaner input decoration
InputDecoration InputStreamDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import 'dart:convert';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();

  String? selectedCategory;
  String selectedType = 'expense'; // NEW: income or expense
  bool _isLoading = false;

  final List<String> categories = [
    "food",
    "salary",
    "shopping",
    "entertainment",
    "transport",
    "rent",
    "utilities",
    "healthcare",
    "education",
    "freelance",
    "business",
    "investment",
    "other",
  ];

  @override
  Widget build(BuildContext context) {
    final String todayFormatted = DateFormat("MMMM dd, yyyy").format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Transaction",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0B6B43),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------- TRANSACTION TYPE --------------------
            const Text(
              "Transaction Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Income'),
                    value: 'income',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                    activeColor: const Color(0xFF0B6B43),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Expense'),
                    value: 'expense',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                    activeColor: const Color(0xFF0B6B43),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Amount Field
            const Text(
              "Amount",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter amount",
                prefixText: "Rs. ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recipient Field (Optional - for geo_location)
            const Text(
              "Recipient / Location (Optional)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: recipientController,
              decoration: InputStreamDecoration("Enter recipient or location"),
            ),
            const SizedBox(height: 20),

            // Category Dropdown
            const Text(
              "Category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              hint: const Text("Select category"),
              items: categories
                  .map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat[0].toUpperCase() + cat.substring(1)),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Fixed Date (non-editable)
            const Text(
              "Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    todayFormatted,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Note Field
            const Text(
              "Note (Optional)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputStreamDecoration("Enter note..."),
            ),

            const SizedBox(height: 35),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B6B43),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text(
                  "Add Transaction",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitTransaction() async {
    // Validation
    if (amountController.text.isEmpty || selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Amount and Category are required"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Parse amount
    double? amount = double.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid amount"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      print('🔄 Creating transaction...');
      print('📦 Type: $selectedType');
      print('💰 Amount: $amount');
      print('📂 Category: $selectedCategory');

      // Prepare request body matching backend schema
      final requestBody = {
        'amount': amount,
        'type': selectedType,
        'category': selectedCategory,
        'geo_location': recipientController.text.isNotEmpty
            ? recipientController.text
            : null,
      };

      print('📤 Request body: ${jsonEncode(requestBody)}');

      // Send POST request
      final response = await ApiService.post(
        '/api/v1/transactions/',
        requestBody,
        authenticated: true,
      );

      print('📡 Response status: ${response.statusCode}');
      print('📄 Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Success!
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "✅ Transaction Added Successfully! (${selectedType == 'income' ? '+' : '-'}Rs.$amount)",
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Go back and pass true to trigger refresh
        Navigator.pop(context, true);
      } else {
        // Error response
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['detail'] ?? 'Failed to create transaction');
      }
    } catch (e) {
      print('❌ Error creating transaction: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    recipientController.dispose();
    super.dispose();
  }
}

/// Helper widget for cleaner input decoration
InputDecoration InputStreamDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

 */


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import 'dart:convert';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();

  String? selectedCategory;
  String selectedType = 'expense'; // 'income' or 'expense'
  bool _isLoading = false;

  final List<String> categories = [
    "food",
    "salary",
    "shopping",
    "entertainment",
    "transport",
    "rent",
    "utilities",
    "healthcare",
    "education",
    "freelance",
    "business",
    "investment",
    "other",
  ];

  @override
  Widget build(BuildContext context) {
    final String todayFormatted = DateFormat("MMMM dd, yyyy").format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Transaction",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0B6B43),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------- TRANSACTION TYPE --------------------
            const Text(
              "Transaction Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Income'),
                    value: 'income',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                    activeColor: const Color(0xFF0B6B43),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Expense'),
                    value: 'expense',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                    activeColor: const Color(0xFF0B6B43),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Amount Field
            const Text(
              "Amount",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter amount",
                prefixText: "Rs. ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recipient Field
            const Text(
              "Recipient / Location (Optional)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: recipientController,
              decoration: InputDecoration(
                hintText: "Enter recipient or location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Category Dropdown
            const Text(
              "Category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              hint: const Text("Select category"),
              items: categories
                  .map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat[0].toUpperCase() + cat.substring(1)),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Date Display
            const Text(
              "Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    todayFormatted,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const Icon(Icons.calendar_today, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Note Field
            const Text(
              "Note (Optional)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter note...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 35),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B6B43),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text(
                  "Add Transaction",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitTransaction() async {
    // Validation
    if (amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter amount"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a category"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Parse amount
    double? amount = double.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid amount"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      print('🔄 Creating transaction...');
      print('💰 Amount: $amount');
      print('📂 Type: $selectedType');
      print('📂 Category: $selectedCategory');
      print('📱 Recipient: ${recipientController.text}');

      // Prepare request body
      final requestBody = {
        'amount': amount,
        'type': selectedType,
        'category': selectedCategory!.toLowerCase(),
        'recipient': recipientController.text.isNotEmpty
            ? recipientController.text
            : null,
        'description': noteController.text.isNotEmpty
            ? noteController.text
            : null,
      };

      print('📤 Request body: ${jsonEncode(requestBody)}');

      // Send POST request
      final response = await ApiService.post(
        '/api/v1/transactions/',
        requestBody,
        authenticated: true,
      );

      print('📡 Response status: ${response.statusCode}');
      print('📄 Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Success!
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "✅ Transaction Added! ${selectedType == 'income' ? '+' : '-'}Rs.$amount",
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Go back and pass true to trigger refresh
        Navigator.pop(context, true);
      } else {
        // Error response
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['detail'] ?? 'Failed to create transaction');
      }
    } catch (e) {
      print('❌ Error creating transaction: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ Error: ${e.toString()}"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    recipientController.dispose();
    super.dispose();
  }
}