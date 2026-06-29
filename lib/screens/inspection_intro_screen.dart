import 'package:flutter/material.dart';

class InspectionIntroScreen extends StatelessWidget {
  const InspectionIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Start Inspection")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Before you Begin",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),
            const Text(
              "For completing the Inspection,you must follow all 13 Inspection steps",
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vehicle Condition Options",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("✅ Good"),
                  Text("⚠️ Average"),
                  Text("❌ Poor"),
                  Text("⛔ Not Available"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inspection Steps",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text("1. Vehicle Basic Information"),
                  Text("2. Exterior Body Inspection"),
                  Text("3. Windshield and Glass Inspection"),
                  Text("4. Tire and Wheel Inspection"),
                  Text("5. Engine Bay Inspection"),
                  Text("6. Interior Inspection"),
                  Text("7. Suspension Inspection"),
                  Text("8. Brake Inspection"),
                  Text("9. Underbody Inspection"),
                  Text("10. Test Drive Inspection"),
                  Text("11. Insurance & Accident History"),
                  Text("12. AI Damage Detection"),
                  Text("13. Final Report Generation"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
