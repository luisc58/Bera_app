
import 'package:bera/scr/Models/Accommodation.dart';
import 'package:bera/scr/Models/WorkLocation.dart';
import 'package:equatable/equatable.dart';

abstract class StepperEvent extends Equatable {
  const StepperEvent();
  @override
  List<Object> get props => [];
}

class ContinueEvent extends StepperEvent {}
class BackEvent extends StepperEvent {}

// ignore: must_be_immutable
 class WorkLocationUpdated extends StepperEvent {
  final WorkLocationAddress locationSelected;

  WorkLocationUpdated(this.locationSelected);
  @override
  List<Object> get props => [locationSelected];
}

class AddAccommodations extends StepperEvent {
  final List<Accommodation> accommodations;
  AddAccommodations(this.accommodations);
  @override
  List<Object> get props => [accommodations];
}