import 'package:bera/scr/Blocs/authentication/authentication_bloc.dart';
import 'package:bera/scr/Blocs/simple_bloc_delegate.dart';
import 'package:bera/scr/DataLayer/user_repository.dart';
import 'package:bera/scr/UI/Login/login_screen.dart';
import 'package:bera/scr/UI/home_screen.dart';
import 'package:bera/scr/cts_api/CtsClient.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/jobs/v3.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // MY TEST
  List<Job> myJobs;
  CtsClient jobs = CtsClient();

  String query = 'companyName="projects/jobsolutionstest/companies/fd831907-1af2-4323-92b1-e4dc9876cdf3"';    //note queries need to be made like this
  String query2 = 'companyName="projects/jobsolutionstest/companies/fd831907-1af2-4323-92b1-e4dc9876cdf3" AND status="OPEN"';   //MULITPLE PARAM QUERY
  print(query2);
  myJobs = await jobs.getListJobsByCompany(query2);
  for(Job i in myJobs){
    print("Job title is: ${i.title}");
  }
//  companies = await jobs.listCompanies();
//  for(Company i in companies){
//    print("Company Name is: ${i.name}");
//  }
  // END OF MY TEST

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
            return HomeScreen(name: state.displayName);
          }
          return Container();
        },
      ),
    );
  }
}