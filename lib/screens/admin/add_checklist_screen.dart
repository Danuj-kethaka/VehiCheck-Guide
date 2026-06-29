import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/cloudinary_service.dart';
import '../services/firestore_service.dart';

class AddInspectionScreen extends StatefulWidget {
  const AddInspectionScreen({super.key});

  @override
  State<AddInspectionScreen> createState() => _AddInspectionScreenState();
}

class _AddInspectionScreenState extends State<AddInspectionScreen> {
  File? imageFile;
  final picker = ImagePicker();

  bool loading = false;

  String? selectedVehicle;
  int selectedStep = 1;

  final titleController = TextEditingController();
  final instructionController = TextEditingController();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future<void> saveChecklist() async {
    try {
      if (selectedVehicle == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a vehicle")),
        );
        return;
      }

      if (titleController.text.isEmpty || instructionController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fill all required fields")),
        );
        return;
      }

      if (imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a guide image")),
        );
        return;
      }

      setState(() {
        loading = true;
      });

      final cloudinary = CloudinaryService();

      String imageUrl = await cloudinary.uploadImage(imageFile!);

      final firestore = FirestoreService();

      await firestore.addInspectionStep(
        vehicleId: selectedVehicle!,
        stepNo: selectedStep,
        title: titleController.text.trim(),
        instruction: instructionController.text.trim(),
        imageUrl: imageUrl,
        audioUrl: "",
        videoUrl: "",
      );

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Inspection Step Saved")));
    } catch (e) {
      setState(() {
        loading = false;
      });

      print(e);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Inspection Checklist")),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("vehicles").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final vehicles = snapshot.data!.docs;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedVehicle,
                  decoration: const InputDecoration(
                    labelText: "Select Vehicle",
                    border: OutlineInputBorder(),
                  ),

                  items: vehicles.map((vehicle) {
                    return DropdownMenuItem(
                      value: vehicle.id,
                      child: Text(vehicle["model"]),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVehicle = value;
                    });
                  },
                ),

                const SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: selectedStep,
                  decoration: const InputDecoration(
                    labelText: "Step Number",
                    border: OutlineInputBorder(),
                  ),

                  items: List.generate(
                    13,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text("Step ${index + 1}"),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedStep = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Step Title",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: instructionController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: "Instructions",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                Column(
                  children: [
                    if (imageFile != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          imageFile!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                    const SizedBox(height: 10),

                    OutlinedButton.icon(
                      onPressed: pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text("Pick Guide Image"),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Pick Guide Audio"),
                ),

                const SizedBox(height: 15),

                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Pick Guide Video"),
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : saveChecklist,
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text("Save Checklist"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
