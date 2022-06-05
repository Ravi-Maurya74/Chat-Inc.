import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = new FlutterSecureStorage();
  Future writeData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future getData(String key) async {
    var data = await storage.read(key: key);
    print(data.toString());
    return data.toString();
  }
}
