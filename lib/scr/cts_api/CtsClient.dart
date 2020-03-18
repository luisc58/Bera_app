import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/jobs/v3.dart';
import 'dart:async';
import 'package:bera/scr/cts_api/SecureStorage.dart';


// class to accesss cts api
// requires google authentication credentials json file!
// download file can be found on google drive, named key.json
// save key.json to assets directory in project

class CtsClient{
  static const String _assetPath = "assets/key.json";         //path to key fle
  static const tenantId = "projects/jobsolutionstest";        //name of project on gcloud
  static const _SCOPE = const[JobsApi.JobsScope];             // scope of api
  final storage = SecureStorage();                            //storage for key
  

  //load key.json from assets
  Future<String> _loadAsset() async{
    return await rootBundle.loadString(_assetPath);
  }

  // initialize credentials
  Future _getCredentials() async{
    ServiceAccountCredentials credentials = new ServiceAccountCredentials
        .fromJson(await _loadAsset());
    //save credentials
    await storage.saveCredentials(credentials);
  }


  //get authenticated client
  Future<AuthClient> _getAuthClient() async{
    var credentials = await storage.getCredentials();

    if(credentials == null){
      await _getCredentials();
      credentials = await storage.getCredentials();
    }

    return await clientViaServiceAccount(new ServiceAccountCredentials(credentials["email"],
        ClientId(credentials["identifier"],null),
        credentials["privateKey"]),_SCOPE);
  }

  //get jobs api client
  Future<JobsApi> _getClient() async{
    return new JobsApi(await _getAuthClient());
  }

  //List companies in cls
  Future<List<Company>> listCompanies() async{
    var jobs = await _getClient();
    
    print("Getting Companies...");
    
    // return list of companies
    ListCompaniesResponse response = await jobs.projects.companies.list(tenantId);
    return response.companies;
  }

  //TODO listJobs()
  //TODO getCompany()
  //TODO getJob()
  //TODO deleteCompany()
  //TODO deleteJob()
  //TODO addCompany()
  //TODO addJob()
  //TODO jobSearch()

}