
import 'package:bera/scr/Blocs/stepper/stepper_events.dart';
import 'package:bera/scr/Blocs/stepper/stepper_state.dart';
import 'package:bloc/bloc.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {

  @override
  StepperState get initialState => StepperState.initial();

  @override
  Stream<StepperState> mapEventToState(StepperEvent event) async* {
       if (event is WorkLocationUpdated) {
        yield StepperState.update(state.currentStep,event.locationSelected, state.accommodations);
      } else if (event is ContinueEvent) {
         yield* _mapOnContinue();
       } else if (event is BackEvent) {
         yield* _mapOnBack();
       } else if (event is AddAccommodations) {
         yield StepperState.update(state.currentStep, state.workLocationAddress, event.accommodations);
       }
  }

  Stream<StepperState> _mapOnContinue() async* {
    final _currentStep = state.currentStep;
    yield StepperState.update(_currentStep + 1, state.workLocationAddress, state.accommodations);
  }

  Stream<StepperState> _mapOnBack() async* {
    final _currentStep = state.currentStep;
    yield StepperState.update(_currentStep - 1, state.workLocationAddress, state.accommodations);
  }

}