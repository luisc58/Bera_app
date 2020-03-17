import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/jobs/v3.dart';
import 'dart:async';
import 'package:bera/scr/cts_api/SecureStorage.dart';


class CtsClient{
  static const String _assetPath = "assets/key.json";         //path to key fle
  static const _SCOPE = const[JobsApi.JobsScope];             // scope of api
  final storage = SecureStorage();                            //storage for key

  //load key.json from assets
  Future<String> _loadAsset() async{
    return await rootBundle.loadString('assets/key.json');
  }

  // initialize credentials
  Future getCredentials() async{

    ServiceAccountCredentials credentials = new ServiceAccountCredentials
        .fromJson(await _loadAsset());

    //save credentials
    await storage.saveCredentials(credentials);
  }


  //get authenticated client
  Future<AuthClient> getAuthClient() async{
    var credentials = await storage.getCredentials();

    if(credentials == null){
      await getCredentials();
    }

    return await clientViaServiceAccount(new ServiceAccountCredentials(credentials['email'],
        ClientId(credentials['identifier'], credentials['secret']),
        credentials['privateKey']),_SCOPE);
  }
}