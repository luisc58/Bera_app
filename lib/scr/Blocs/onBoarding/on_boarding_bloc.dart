import 'dart:async';
import 'package:bera/scr/DataLayer/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'on_boarding_event.dart';
import 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final UserRepository _userRepository;

  OnBoardingBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  OnBoardingState get initialState => Loading();

  @override
  Stream<OnBoardingState> mapEventToState(OnBoardingEvent event) async* {
    if(event is UserLoaded) {
      yield* _mapUserStartedToState();
    }
  }

  Stream<OnBoardingState> _mapUserStartedToState() async* {
    try {
      final userId = await _userRepository.getUser();
      final isFirstTimeUser = await _userRepository.isFirstTimeUser(userId);

      if(isFirstTimeUser) {
        yield FirstTimeUser();
      } else {
        yield ExistingUser();
      }
    } catch (_) {

    }
  }
}
