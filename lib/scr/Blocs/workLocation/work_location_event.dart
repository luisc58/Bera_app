import 'package:bera/scr/Models/WorkLocation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WorkLocationEvent extends Equatable {
  const WorkLocationEvent();
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SelectWorkLocation extends WorkLocationEvent {
  WorkLocationAddress selectedLocation;
  SelectWorkLocation(this.selectedLocation);

  @override
  // TODO: implement props
  List<Object> get props => [selectedLocation];
}
