import 'package:bera/scr/Models/Accommodation.dart';
import 'package:equatable/equatable.dart';


abstract class AccommodationState extends Equatable {
  const AccommodationState();
  @override
  List<Object> get props => [];
}

class AccommodationEmpty extends AccommodationState {}
class AccommodationLoading extends AccommodationState {}

class AccommodationLoaded extends AccommodationState {
  final List<Accommodation> accommodations;
  const AccommodationLoaded([this.accommodations = const []]);

  @override
  List<Object> get props => [accommodations];
}

class AccommodationError extends AccommodationState {}

