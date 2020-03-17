//google jobs api and google auth for service account imports
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/jobs/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> _loadAsset() async{
  return await rootBundle.loadString('assets/key.json');
}

//Future loadKeyFile() async{
//  String file = await _loadAsset();
//  print(file);
//}




//service account credentials json
final _accountCredentials = new ServiceAccountCredentials.fromJson(r'''
{
  "private_key_id": "a98286582f2aca1baa6125254bf0b8fca6f58adc",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCe5y38T2c4BZuL\nAK2sKj4fdYfesF2hnmWshYohJ4fwMVdjgYV4UbfK4615z7702naTQw49QmYmbGdJ\nT+j3FBy4sveDIqTRQNBuNhGHwtt3/95IuNvPHbps8GVNkikDlo5XsOe0X58SF37S\nDuQfUWlOaDD+nGMyTHXj7tSOFFouGXg/nGTg1YxdQ9/U5XVkwGxFSQfPsUEsZX4J\n6T54FR6Wwt8cH88/E1HccRGgvXPDSWq5C12mtPwPh5HiIiGsh6lClvmrMpCcTBRs\nUF5YzZ2VZzYP7ojmkVBLP/MHN8FtGEGitWDvpyTrfDPrFGJocwqv1k4NKZl7RkGE\n5Ij2AyL9AgMBAAECggEAHaX8yor2M1m4f+MMhIcNOElxpHc7wSAQ0HPKJg1+K67J\nI2PTR3PX2x9ICuZcNstcPHXSflOZQ6oOS3uBeDhkc4HQ9MLOBc0WFro34yDUWjt/\negoj2S0uz4y7GhIfXPAGdw4m7Vy6DWIc44yru7ww7dQ68Aa163igtnqlZi0d9mO2\nl+qNBdnF0ft+xrbYUvZDH7q5xn4qC7W0ATcpIPqQnrSvUE229t3SLUEsZUwIFJ9W\nJPdbN5yY19KqAOPsSmNKPFQXbV585fpoKor2u/1jDMaXWoyn9Q4xk88TaC+3E991\n9kIkNcNLl6ZfH9jYV7609zwgW0zoVHBJUq+r20WcAQKBgQDddzFFjXxVN7ZxHT9g\nqw0PVVud9o5dt3+NENo+QMIWezDLjzKGuubSbtaGEGJFDqnJITJP5gRk2fgsWHny\nirzY+UBNd2uBy78AImQ7KWkNWqZbFfYspxLxStVkENj5fSGbBwcPbVfJa/V1MapG\nS5kCali06JMHEZljzBLLKRzVvQKBgQC3roSk4tL7x1Cep8mbmKbs7qHuIqnJNMHF\nSDZk9IEj4i4LveUCE7EKNVevL7Vtf6B+lSL+iICuOsMx4MrUI7oix9MI9UQJnOWM\nxiFe6k2N7FYU0YW/nT1qbrDrGCMBJFU9uhPDJjQyUa2gh9b4gojfB5UN+a+I6/cb\ny+RHaTc2QQKBgQCZj0YI1hv58tF8CS2i17gMg8Es/IKmlM/Kfn71X220rOKeosIE\nDaBzFQuGleGtxIcRwQTjxbgSPdkI1qhn9q8PO3TMwhs3OpFLhI0/QG1pJwvmaInz\nWD2YNa1U3yGzjII6vlq05bpTHZprEm7goxaLSDYN6p3X7uoO+relSvKFeQKBgDQF\ncDnGp9x5EaMtgBLaRAR8fU4VcSK0F2EJV6Z1/REtoL7glDhnXU+31dKe33JYoBrZ\noCSYgmFV8SxyLt+wEqqBD4rM8+0JC5Y4EwFvuHFGiwawZIHlRZycJu0eU+Oh56Zo\nyeoOKuBJc7QwZLjTN3J7EkL4ATf1JHIx58A101ZBAoGARhdSSC1CcHdNrj4PNyxC\nmmYHHBrFY0ihNdHllOorTtxoogGORXnIRwN19XJUHC6wV5pVJxWkpeD40O08X+PK\n1Q0Kl/xG+4Jioe2bPtSyyl+GUfmiyySGDnmjbWoAqUbknLUcUMNTGGc7szl88EHB\nGDa2q4pwD2XSYkxa6+m4SzM=\n-----END PRIVATE KEY-----\n",
  "client_email": "job-editor@jobsolutionstest.iam.gserviceaccount.com",
  "client_id": "109259335066724849838",
  "type": "service_account"
}
''');


//not sure what this is but defines scope of jobs api?
const _SCOPES = const [JobsApi.JobsScope];

//function to list companies in cts
Future listCompanies() async {

  String a = "test";
  print(a);




  print("SECOND print ${_accountCredentials.email}");

  //create our client with service account credentials
  clientViaServiceAccount(_accountCredentials, _SCOPES).then((
      AuthClient client) {

    //initialize jobs api reference
    var jobs = new JobsApi(client);

    //call  companies list function
    jobs.projects.companies.list(
        "projects/jobsolutionstest").then((companies){
          print("Companies: ");
          for (var company in companies.companies){
            print(company.displayName);
          }
    });
    client.close();
  });
}
















