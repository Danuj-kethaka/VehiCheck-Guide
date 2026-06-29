import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class CloudinaryService {
  Future<String> uploadImage(File file) async {
    const cloudName = "dyefzt4pu";
    const uploadPreset = "b3luwkri";

    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    final request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath("file", file.path));

    final response = await request.send();

    final body = await response.stream.bytesToString();

    return jsonDecode(body)["secure_url"];
  }
}
