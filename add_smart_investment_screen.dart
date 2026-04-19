import 'package:flutter/material.dart';

class AddSmartInvestmentScreen extends StatefulWidget {
  @override
  _AddSmartInvestmentScreenState createState() =>
      _AddSmartInvestmentScreenState();
}

class _AddSmartInvestmentScreenState extends State<AddSmartInvestmentScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  String? selectedCategory;
  String? selectedDuration;
  String? selectedRisk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Smart Investment",
            style: TextStyle(fontWeight: FontWeight.w800)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------- CATEGORY -------------------
            _sectionTitle("Investment Category"),
            _roundedContainer(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  borderRadius: BorderRadius.circular(16),
                  hint: Text("Select Category"),
                  items: [
                    "Stocks (PSX)",
                    "Mutual Funds",
                    "Gold",
                    "Real Estate",
                    "USD / Forex",
                    "Bonds / Savings Certificates",
                    "Custom",
                  ].map((val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = val;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // ------------------- AMOUNT -------------------
            _sectionTitle("Amount Invested (PKR)"),
            _roundedContainer(
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter amount in PKR",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // ------------------- DATE -------------------
            _sectionTitle("Investment Date"),
            _roundedContainer(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Date: ${selectedDate.toLocal().toString().split(' ')[0]}",
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.calendar_month, color: Color(0xFF0B6B43)),
                onTap: _pickDate,
              ),
            ),
            SizedBox(height: 20),

            // ------------------- HOLDING DURATION -------------------
            _sectionTitle("Expected Holding Duration"),
            _roundedContainer(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedDuration,
                  borderRadius: BorderRadius.circular(16),
                  hint: Text("Select Duration"),
                  items: [
                    "3 Months",
                    "6 Months",
                    "12 Months",
                    "2 Years",
                    "5 Years",
                    "Custom",
                  ].map((val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedDuration = val;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // ------------------- RISK LEVEL -------------------
            _sectionTitle("Risk Level"),
            _roundedContainer(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedRisk,
                  borderRadius: BorderRadius.circular(16),
                  hint: Text("Select Risk Level"),
                  items: ["Low", "Medium", "High"].map((val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedRisk = val;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 25),

            // ------------------- AI SUGGESTION BOX -------------------
            if (amountController.text.isNotEmpty ||
                selectedCategory != null)
              _aiSuggestionBox(),

            SizedBox(height: 25),

            // ------------------- NOTES -------------------
            _sectionTitle("Notes (Optional)"),
            _roundedContainer(
              child: TextField(
                controller: noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Add any additional notes...",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 40),

            // ------------------- SAVE BUTTON -------------------
            GestureDetector(
              onTap: () {
                // TODO: Save to DB -> Navigate back
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Color(0xFF0B6B43),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    "Add Smart Investment →",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------
  // ---------------------- WIDGET HELPERS ------------------------
  // --------------------------------------------------------------

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
    );
  }

  Widget _roundedContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF4FBF7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _aiSuggestionBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Color(0xFF0B6B43),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AI Recommendation",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
            "Based on inflation trends in Pakistan:",
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 10),
          Text(
            "• 40% Gold\n• 35% Mutual Funds\n• 25% Stocks\n\nExpected Return: ~11.8% yearly",
            style: TextStyle(color: Colors.white, height: 1.4),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDate: selectedDate,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
