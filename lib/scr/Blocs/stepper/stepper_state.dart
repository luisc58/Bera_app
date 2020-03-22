

import 'package:bera/scr/Models/Accommodation.dart';
import 'package:bera/scr/Models/WorkLocation.dart';
import 'package:flutter/cupertino.dart';

class StepperState {
  final int currentStep;
  final bool submitting;
  final WorkLocationAddress workLocationAddress;
  final List<Accommodation> accommodations;
  WorkLocationAddress get location => workLocationAddress;

  StepperState({@required this.currentStep, this.submitting, this.workLocationAddress, this.accommodations});
  factory StepperState.initial() => StepperState(currentStep: 0, submitting: false, workLocationAddress: null, accommodations: []);

  factory StepperState.update(currentStep, workLocation, accommodations) {
    return StepperState(
      currentStep: currentStep ?? 0,
      submitting: false,
      workLocationAddress: workLocation ?? null,
      accommodations: accommodations ?? []
    );
  }

}