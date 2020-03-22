import 'package:bera/scr/Blocs/onBoarding/on_boarding_bloc.dart';
import 'package:bera/scr/Blocs/onBoarding/on_boarding_event.dart';
import 'package:bera/scr/Blocs/onBoarding/on_boarding_state.dart';
import 'package:bera/scr/DataLayer/user_repository.dart';
import 'package:bera/scr/UI/Home/Navigation.dart';
import 'package:bera/scr/UI/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeePage extends StatefulWidget {
  final UserRepository _userRepository;

  const EmployeePage({Key key, @required UserRepository userRepository}) :
        assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _EmployeePageState createState() => _EmployeePageState();
}
// decision tree to decide what page to display after user logs in
class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnBoardingBloc>(
      create: (context) => OnBoardingBloc(userRepository: widget._userRepository)
        ..add(UserLoaded()),
        child: BlocBuilder<OnBoardingBloc, OnBoardingState>(
            builder: (context, state) {
              if(state is FirstTimeUser) {
                return MyHomePage(userRepository: widget._userRepository);
              } else if(state is ExistingUser) {
                return NavigationBar();
              }
              return Container();
            }
       ),
    );
  }
}


