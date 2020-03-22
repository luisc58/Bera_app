import 'dart:async';
import 'package:bera/scr/Blocs/accommodation/accommodation_state.dart';
import 'package:bera/scr/Blocs/stepper/stepper_bloc.dart';
import 'package:bera/scr/DataLayer/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'accommodation_event.dart';
import 'package:bera/scr/Models/Accommodation.dart';


class AccommodationBloc extends Bloc<AccommodationEvent, AccommodationState> {
  StreamSubscription _accommodationsSubscription;
  final UserRepository _userRepository;

  AccommodationBloc({@required UserRepository userRepository}) :
      assert(userRepository != null),
      _userRepository = userRepository;
  @override
  AccommodationState get initialState => AccommodationEmpty();


  @override
  Stream<AccommodationState> mapEventToState(AccommodationEvent event) async* {
    if(event is FetchAccommodation) {
        yield* _mapLoadAccommodationToState(event.accommodation);
    }
    else if(event is AccommodationsUpdated) {
      yield AccommodationLoaded(event.accommodations);
    }
    else if(event is AddAccommodation) {
        yield* _mapAddAccommodationToState(event.accommodation);
    }
    else if(event is FetchError) {
      yield AccommodationError();
    }
    else if(event is RemoveAccommodation) {
      yield* _mapRemoveAccommodationToState(event.removedAccommodation);
    }
  }

  Stream<AccommodationState> _mapRemoveAccommodationToState(accommodation) async* {
    // access accommodations stored in state and find the one to be deleted
    if (state is AccommodationLoaded) {
      final List<Accommodation> accommodations = List.from((state as AccommodationLoaded).accommodations)
        ..remove(accommodation);
      add(AccommodationsUpdated(accommodations));
    }
  }

  Stream<AccommodationState> _mapLoadAccommodationToState(accommodation) async* {
    _accommodationsSubscription?.cancel();
    _accommodationsSubscription = _userRepository.getAccommodations(accommodation).listen(
        (accommodations) {
          if(accommodations.length == 0) {
            return add(FetchError());
          }
            return add(AddAccommodation(accommodations[0]));
        }
    );
  }


Stream<AccommodationState> _mapAddAccommodationToState(accommodation) async* {
  if(state is AccommodationEmpty) {
    final List<Accommodation> updatedAccommodations = [accommodation];
    add(AccommodationsUpdated(updatedAccommodations));
  } else  {
    final List<Accommodation> updatedAccommodations = List.from((state as AccommodationLoaded).accommodations)
       ..add(accommodation);
    add(AccommodationsUpdated(updatedAccommodations));
  }

  }
}