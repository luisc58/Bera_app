import 'package:bera/scr/Models/Accommodation.dart';
import 'package:equatable/equatable.dart';

abstract class AccommodationEvent  extends Equatable {
  const AccommodationEvent();
  @override
  List<Object> get props => [];
}

class FetchAccommodation extends AccommodationEvent {
  final String accommodation;
  FetchAccommodation(this.accommodation);
  @override
  List<Object> get props => [accommodation];
}

class AccommodationsUpdated extends AccommodationEvent {
  final List<Accommodation> accommodations;

  AccommodationsUpdated(this.accommodations);
  List<Accommodation> get acc => accommodations;
  @override
  List<Object> get props => [accommodations];
}

class AddAccommodation extends AccommodationEvent {
  final Accommodation accommodation;
  AddAccommodation(this.accommodation);
  @override
  List<Object> get props => [accommodation];
}

class FetchError extends AccommodationEvent {}

class LoadAccommodations extends AccommodationEvent {}
class RemoveAccommodation extends AccommodationEvent {
 final Accommodation removedAccommodation;
 RemoveAccommodation(this.removedAccommodation);
 @override
  List<Object> get props => [removedAccommodation];

}