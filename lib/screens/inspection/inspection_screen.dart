import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InspectionScreen extends StatefulWidget {
  final String vehicleId;

  const InspectionScreen({super.key, required this.vehicleId});

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("vehicles")
            .doc(widget.vehicleId)
            .collection("inspectionSteps")
            .orderBy("stepNo")
            .snapshots(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final steps = snapshot.data!.docs;

          if (steps.isEmpty) {
            return const Center(child: Text("No inspection steps found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              final step = steps[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step ${step["stepNo"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        step["title"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Image.network(
                        step["image"],
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      const SizedBox(height: 10),
                      Text(step["instruction"]),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
