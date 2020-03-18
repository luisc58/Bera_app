import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/jobs/v3.dart';
import 'dart:async';
import 'package:bera/scr/cts_api/SecureStorage.dart';


/*
singleton class to access cts api
can only create 1 instance of this class
requires google authentication credentials json file!
download file can be found on google drive, named key.json
save key.json to assets directory in project
*/

class CtsClient{
  static final CtsClient _singleton = CtsClient._internal();  //singleton
  static const String _assetPath = "assets/key.json";         //path to key fle
  static const tenantId = "projects/jobsolutionstest";        //name of project on gcloud
  static const _SCOPE = const[JobsApi.JobsScope];             // scope of api
  final storage = SecureStorage();                            //storage for key
  

  // singleton constructor
  factory CtsClient() => _singleton;

  // private constructor
  CtsClient._internal();

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

    return await clientViaServiceAccount(ServiceAccountCredentials(credentials["email"],
        ClientId(credentials["identifier"],null),
        credentials["privateKey"]),_SCOPE);
  }

  //get jobs api client
  Future<JobsApi> _getClient() async{
    return JobsApi(await _getAuthClient());
  }

  //List companies in cls
  Future<List<Company>> getListCompanies({String pageToken = "", int pageSize = 100, bool requireOpenJobs = false}) async{
    var jobs = await _getClient();
    
    print("Getting All Companies...");
    
    // return list of companies
    ListCompaniesResponse response = await jobs.projects.companies.list(tenantId,
        pageToken: pageToken,
        pageSize: pageSize,
        requireOpenJobs: requireOpenJobs);

    return response.companies;
  }

  Future<List<Job>> getListJobsByCompany(String filter,{String pageToken = "",int pageSize = 100, String jobView = "JOB_VIEW_UNSPECIFIED" }) async{
    var jobs = await _getClient();

    print("Getting Filtered Jobs...");

    ListJobsResponse response = await jobs.projects.jobs.list(tenantId,jobView: jobView,pageToken: pageToken,pageSize: pageSize,filter: filter);

    return response.jobs;
  }

  //TODO listAllJobs()
  //TODO getCompany()
  //TODO getJob()
  //TODO deleteCompany()
  //TODO deleteJob()
  //TODO addCompany()
  //TODO addJob()
  //TODO jobSearch()

}