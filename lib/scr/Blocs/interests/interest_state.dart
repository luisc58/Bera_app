import 'package:bera/scr/UI/Stepper/Interests/Item.dart';
import 'package:equatable/equatable.dart';

abstract class InterestState extends Equatable {
  const InterestState();
  @override
  List<Object> get props => [];

}

class InterestEmpty extends InterestState {}
class InterestUpdated extends InterestState {
  final List<Item> interests;
  const InterestUpdated([this.interests = const []]);
  @override
  List<Object> get props => [interests];
}

class InterestSelected extends InterestState {
  final Item interest;
  InterestSelected(this.interest);
  @override
  List<Object> get props => [interest];
}

class InterestError extends InterestState {}