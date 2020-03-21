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

class CtsClient {
  static final CtsClient _singleton = CtsClient._internal(); //singleton
  static const String _assetPath = "assets/key.json"; //path to key fle
  static const tenantId = "projects/jobsolutionstest"; //name of project on gcloud
  static const _SCOPE = const[JobsApi.JobsScope]; // scope of api
  final storage = SecureStorage(); //storage for key


  /// singleton constructor
  factory CtsClient() => _singleton;

  // private constructor
  CtsClient._internal();

  //load key.json from assets
  Future<String> _loadAsset() async {
    return await rootBundle.loadString(_assetPath);
  }

  /// initialize credentials
  Future _getCredentials() async {
    ServiceAccountCredentials credentials = new ServiceAccountCredentials
        .fromJson(await _loadAsset());
    //save credentials
    await storage.saveCredentials(credentials);
  }


  /// get authenticated client
  Future<AuthClient> _getAuthClient() async {
    var credentials = await storage.getCredentials();

    if (credentials == null) {
      await _getCredentials();
      credentials = await storage.getCredentials();
    }

    return await clientViaServiceAccount(
        ServiceAccountCredentials(credentials["email"],
            ClientId(credentials["identifier"], null),
            credentials["privateKey"]), _SCOPE);
  }

  /// get jobs api client
  Future<JobsApi> _getClient() async {
    return JobsApi(await _getAuthClient());
  }

  //List companies in cls
  Future<List<Company>> getListCompanies({String pageToken = "",
    int pageSize = 100, bool requireOpenJobs = false}) async {
    var jobs = await _getClient();

    print("Getting All Companies...");

    try {
      // return list of companies
      ListCompaniesResponse response = await jobs.projects.companies.list(
          tenantId,
          pageToken: pageToken,
          pageSize: pageSize,
          requireOpenJobs: requireOpenJobs);

      return (response.companies == null) ? [] : response.companies;
    } on DetailedApiRequestError catch (e) {
      _errorHandler(e);
      return null;
    }
  }

  /// Get all jobs from a specific company
  Future<List<Job>> getListJobsByCompany(String filter, {
    String pageToken = "", int pageSize = 100,
    String jobView = "JOB_VIEW_UNSPECIFIED" }) async {
    var jobs = await _getClient();

    print("Getting Filtered Jobs...");

    try {
      ListJobsResponse response = await jobs.projects.jobs.list(tenantId,
          jobView: jobView, pageToken: pageToken, pageSize: pageSize,
          filter: filter);

      // return empty list if no jobs
      return (response.jobs == null) ? [] : response.jobs;
    } on DetailedApiRequestError catch (e) {
      _errorHandler(e);
      return null;
    }
  }

  /// get all jobs in our model
  Future<List<Job>> getAllJobs() async {
    List<Job> allJobs = [];
    List<Company> companies = await getListCompanies();

    try {
      for (Company i in companies) {
        String name = i.name;
        String filter = 'companyName="' + name + '"';
        allJobs.addAll(await getListJobsByCompany(filter));
      }
      return allJobs;
    } on NoSuchMethodError catch (e) {
      print("Invalid Method Call...");
      print(e);
      return null;
    }
  }

  /// get a company or job instance in our model
  Future<dynamic> getInstance(String name, bool isCompany) async {
    var jobs = await _getClient();

    try {
      if (isCompany) {
        return await jobs.projects.companies.get(name);
      }
      return await jobs.projects.jobs.get(name);
    } on DetailedApiRequestError catch (e) {
      _errorHandler(e);
      return null;
    }
  }

  /// create a new company or job in our model
  Future<dynamic> createInstance(Map info, bool isCompany) async {
    var jobs = await _getClient();

    try {
      if (isCompany) {
        return await jobs.projects.companies.create(
            CreateCompanyRequest.fromJson({"company": info}),
            tenantId);
      }
      return await jobs.projects.jobs.create(
          CreateJobRequest.fromJson({"job": info}),
          tenantId);
    } on DetailedApiRequestError catch (e) {
      _errorHandler(e);
      return null;
    }
  }


  Future deleteInstance(String name, bool isCompany) async {
    var jobs = await _getClient();

    try {
      (isCompany) ? await jobs.projects.companies.delete(name) : await jobs
          .projects.jobs.delete(name);
    } on DetailedApiRequestError catch (e) {
      print("Unsuccessfull: Error Occured...");
      _errorHandler(e);
    }
  }

  Future<List<MatchingJob>> searchJob(Map query)async {
    var jobs = await _getClient();

    try {
      SearchJobsRequest request = SearchJobsRequest.fromJson(query);
      SearchJobsResponse response = await jobs.projects.jobs.search(
          request, tenantId);

      return (response.matchingJobs == null)? []: response.matchingJobs;
    } on DetailedApiRequestError catch(e){
      _errorHandler(e);
      return null;
    }
  }

  /// helper error handler
  void _errorHandler(DetailedApiRequestError e) {
    print("Error With Api Call...");

    switch (e.status) {
      case 400:
        {
          print("Issue With Query Parameters...");
          print("Error Code: ${e.status}\nError Message: ${e.message}");
          break;
        }
      case 401:
        {
          print("Issue With Authentication...");
          print("Error Code: ${e.status}\nError Message: ${e.message}");
          break;
        }
      case 403:
        {
          print("Issue with Authorization...");
          print("Error Code: ${e.status}\nError Message: ${e.message}");
          break;
        }
      case 404:
        {
          print("Resource Not Found");
          print("Error Code: ${e.status}\nError Message: ${e.message}");
          break;
        }
      case 503:
        {
          print("Issue With Server");
          print("Error Code: ${e.status}\nError Message: ${e.message}");
          break;
        }
      default:
        {
          print("Unknown Issue...");
          print("Error Code: ${e.status}\nError Message: ${e.message}\n"
              "Error List:${e.errors}");
        }
    }
  }
}