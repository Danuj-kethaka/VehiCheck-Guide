import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> addVehicle({
    required String model,
    required String year,
    required String imageUrl,
  }) async {
    await FirebaseFirestore.instance.collection("vehicles").add({
      "model": model,
      "year": year,
      "image": imageUrl,
    });
  }

  Future<void> createUser({required String uid, required String email}) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "email": email,
      "role": "user",
    });
  }

  Future<void> addInspectionStep({
    required String vehicleId,
    required int stepNo,
    required String title,
    required String instruction,
    required String imageUrl,
    required String audioUrl,
    required String videoUrl,
  }) async {
    await FirebaseFirestore.instance
        .collection("vehicles")
        .doc(vehicleId)
        .collection("inspectionSteps")
        .add({
          "stepNo": stepNo,
          "title": title,
          "instruction": instruction,
          "image": imageUrl,
          "audio": audioUrl,
          "video": videoUrl,
          "createdAt": FieldValue.serverTimestamp(),
        });
  }
}
