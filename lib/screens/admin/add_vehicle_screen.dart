import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/cloudinary_service.dart';
import '../services/firestore_service.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final modelController = TextEditingController();
  final yearController = TextEditingController();

  File? imageFile;
  bool loading = false;

  final picker = ImagePicker();

  Future pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future saveVehicle() async {
    if (imageFile == null) return;

    setState(() => loading = true);

    final cloudinary = CloudinaryService();

    String imageUrl = await cloudinary.uploadImage(imageFile!);

    final firestore = FirestoreService();

    await firestore.addVehicle(
      model: modelController.text,
      year: yearController.text,
      imageUrl: imageUrl,
    );

    setState(() => loading = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Vehicle Added")));

    modelController.clear();
    yearController.clear();
    setState(() => imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Vehicle"), backgroundColor: Colors.red),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: modelController,
              decoration: InputDecoration(labelText: "Model"),
            ),
            TextField(
              controller: yearController,
              decoration: InputDecoration(labelText: "Year"),
            ),

            SizedBox(height: 20),

            imageFile == null
                ? Text("No image selected")
                : Image.file(imageFile!, height: 150),

            ElevatedButton(onPressed: pickImage, child: Text("Pick Image")),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading ? null : saveVehicle,
              child: loading
                  ? CircularProgressIndicator()
                  : Text("Save Vehicle"),
            ),
          ],
        ),
      ),
    );
  }
}
