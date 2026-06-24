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
}
