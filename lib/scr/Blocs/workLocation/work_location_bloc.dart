import 'dart:async';
import 'package:bera/scr/Blocs/workLocation/work_location_event.dart';
import 'package:bera/scr/Blocs/workLocation/work_location_state.dart';
import 'package:bloc/bloc.dart';


class WorkLocationBloc extends Bloc<WorkLocationEvent, WorkLocationState> {
  @override
  WorkLocationState get initialState => InitialWorkLocationState();

  @override
  Stream<WorkLocationState> mapEventToState(WorkLocationEvent event) async* {
    if(event is SelectWorkLocation) {
      yield WorkLocationSelected(event.selectedLocation);
    }
  }
}
