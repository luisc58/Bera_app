import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class OnBoardingState extends Equatable{
  const OnBoardingState();
  @override
  List<Object> get props => [];
}
class Loading extends OnBoardingState {}
class FirstTimeUser extends OnBoardingState {}
class ExistingUser extends OnBoardingState {}
