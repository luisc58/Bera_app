import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

//abstract class AuthenticationEvent extends Equatable {
//  @override
//  List<Object> get props => [];
//}
@immutable
abstract class OnBoardingEvent extends Equatable {
    @override
  List<Object> get props => [];
}

class UserLoaded extends OnBoardingEvent {}
