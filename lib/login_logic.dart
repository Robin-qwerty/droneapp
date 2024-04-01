import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> checkLoggedIn() async {
  final storage = FlutterSecureStorage();
  final userId = await storage.read(key: 'userId');
  return userId != null;
}
