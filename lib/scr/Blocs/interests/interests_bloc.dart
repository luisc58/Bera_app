import 'package:bera/scr/Blocs/interests/interest_state.dart';
import 'package:bera/scr/UI/Stepper/Interests/Item.dart';
import 'package:bloc/bloc.dart';
import 'interests_event.dart';

class InterestBloc extends Bloc<InterestEvent, InterestState> {
  @override
  InterestState get initialState => InterestEmpty();

  @override
  Stream<InterestState> mapEventToState(InterestEvent event) async* {
    if(event is AddInterest) {
        yield* _mapAddInterestToState(event.interest);
    }
    else if (event is UpdateInterests) {
      yield InterestUpdated(event.interests);
    }
    else if (event is RemoveInterest) {
      yield* _mapRemoveInterestToState(event.interest);
    }
  }

  Stream<InterestState> _mapRemoveInterestToState(interest) {
    final List<Item> updatedInterests = List.from((state as InterestUpdated).interests)
      ..remove(interest);
    add(UpdateInterests(updatedInterests));
  }
  Stream<InterestState> _mapAddInterestToState(interest) async* {
    if(state is InterestEmpty) {
      final List<Item> updatedInterest = [interest];
      add(UpdateInterests(updatedInterest));
    } else {
      final List<Item> updatedInterests = List.from((state as InterestUpdated).interests)
        ..add(interest);
      add(UpdateInterests(updatedInterests));
    }
  }
}


