import 'package:bera/scr/Blocs/authentication/authentication_bloc.dart';
import 'package:bera/scr/Blocs/simple_bloc_delegate.dart';
import 'package:bera/scr/DataLayer/user_repository.dart';
import 'package:bera/scr/UI/Employee_screen.dart';
import 'package:bera/scr/UI/Login/login_screen.dart';
import 'package:bera/scr/cts_api/CtsClient.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/jobs/v3.dart';




void main(){
  WidgetsFlutterBinding.ensureInitialized();
  myTest();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return EmployeePage(userRepository: _userRepository);
          }
          return Container();
        },
      ),
    );
  }
}

void myTest() async{
  CtsClient client = new CtsClient();
  List<Company> j = await client.getListCompanies();

//  for (Company i in j) {
//    if(i.displayName == "Google"){
//      i.keywordSearchableJobCustomAttributes = ["accommodations"];
//    }
//    print(i.displayName);
//    print(i.keywordSearchableJobCustomAttributes);
//  }

  Map metadata = {
    "domain":"bera.com",
    "sessionId": "122345",
    "userId": "asdfgh",
  };
//  List<MatchingJob> jobs = await client.searchJob(metadata,"goog");
  List<MatchingJob> jobs = await client.searchJob(metadata,"google", customAttributeFilter:'accommodations = "extra time"');

  for(MatchingJob i in jobs){
    print(i.job.title);
    print((i.job.customAttributes== null)? "None":i.job.customAttributes['accommodations'].stringValues);
    print(i.jobSummary);
  }

}