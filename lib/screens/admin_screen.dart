import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_vehicle_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),

            // 🔥 ADD VEHICLE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddVehicleScreen()),
                  );
                },
                child: Text(
                  "Add Vehicle",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 30),

            Text(
              "Vehicles List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // 👇 LIVE VEHICLE LIST (FIRESTORE)
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("vehicles")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final vehicles = snapshot.data!.docs;

                  if (vehicles.isEmpty) {
                    return Center(child: Text("No vehicles added yet"));
                  }

                  return ListView.builder(
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      var data = vehicles[index];

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data["image"],
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),

                              SizedBox(height: 10),

                              Text(
                                "Model: ${data["model"]}",
                                style: TextStyle(fontSize: 16),
                              ),

                              Text(
                                "Year: ${data["year"]}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
