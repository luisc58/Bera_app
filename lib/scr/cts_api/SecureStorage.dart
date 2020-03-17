import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:async';

class SecureStorage {
  final storage = FlutterSecureStorage();

  //save credentials
  Future saveCredentials(ServiceAccountCredentials credentials) async {
    print("Saving Credentials...");

    await storage.write(key: "email",
        value: credentials.email);
    await storage.write(key: "identifier",
        value: credentials.clientId.identifier);
    await storage.write(key: "secret",
        value: credentials.clientId.secret);
    await storage.write(key: "privateKey",
        value: credentials.privateKey);
    await storage.write(key: "privateRSAKey",
        value: credentials.privateRSAKey.toString());
  }

  //Get Saved Credentials
  Future<Map<String, dynamic>> getCredentials() async {
    var result = await storage.readAll();
    if (result.isEmpty) return null;
    return result;
  }

  //Clear Saved Credentials
  Future clear(){
    return storage.deleteAll();
  }

}