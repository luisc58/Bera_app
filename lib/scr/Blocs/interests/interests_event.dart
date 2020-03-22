import 'package:bera/scr/UI/Stepper/Interests/Item.dart';
import 'package:equatable/equatable.dart';

abstract class InterestEvent extends Equatable {
  const InterestEvent();
  @override
  List<Object> get props => [];
}

class AddInterest extends InterestEvent {
  final Item interest;
  AddInterest(this.interest);
  @override
  List<Object> get props => [interest];
}

class UpdateInterests extends InterestEvent {
  final List<Item> interests;
  const UpdateInterests([this.interests = const []]);
  @override
  List<Object> get props => [interests];
}
class RemoveInterest extends AddInterest {
  RemoveInterest(Item interest) : super(interest);
}

class LoadInterest extends InterestEvent {}
