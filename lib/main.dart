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