import 'package:bera/scr/Models/WorkLocation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WorkLocationState extends Equatable {
  const WorkLocationState();
  @override
  List<Object> get props => [];
}

class WorkLocationSelected extends WorkLocationState {
  final WorkLocationAddress selectedWorkLocation;
  const WorkLocationSelected(this.selectedWorkLocation);

  @override
  List<Object> get props => [selectedWorkLocation];
}
class InitialWorkLocationState extends WorkLocationState {}
