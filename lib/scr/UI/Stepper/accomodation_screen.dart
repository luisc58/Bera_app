import 'package:bera/scr/Blocs/accommodation/accommodation_bloc.dart';
import 'package:bera/scr/DataLayer/user_repository.dart';
import 'package:bera/scr/UI/Stepper/accommodation_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkAccommodation extends StatelessWidget {
  final UserRepository _userRepository;

  WorkAccommodation({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AccommodationBloc>(
        create: (context) => AccommodationBloc(userRepository: _userRepository),
        child: AccommodationSearch(userRepository: _userRepository ),
      )
    );
  }



}


