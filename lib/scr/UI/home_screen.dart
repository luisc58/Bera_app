import 'package:bera/scr/Blocs/stepper/stepper_bloc.dart';
import 'package:bera/scr/Blocs/stepper/stepper_events.dart';
import 'package:bera/scr/Blocs/stepper/stepper_state.dart';
import 'package:bera/scr/DataLayer/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Stepper/Interests/interests_screen.dart';
import 'Stepper/accomodation_screen.dart';
import 'Stepper/work_location_screen.dart';
import 'Stepper/work_type_screen.dart';


class MyHomePage extends StatefulWidget {
  final UserRepository _userRepository;

  const MyHomePage({Key key, @required UserRepository userRepository}) :
        assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MobileStepper(
          steps: <Widget> [
            InterestsScreen(),
            WorkLocation(),
            WorkAccommodation(userRepository: widget._userRepository),
            WorkType()
          ],
        )
      ),
    );
  }
}


class MobileStepper extends StatefulWidget {
  final List<Widget> steps;
  const MobileStepper({this.steps});

  @override
  State createState() => new _MobileStepperState();
}
class _MobileStepperState extends State<MobileStepper> with TickerProviderStateMixin{
  TabController _controller;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StepperBloc>(
      create: (BuildContext context) => StepperBloc(),
      child: BlocBuilder<StepperBloc, StepperState>(
        builder: (context, state) {
          Widget leftController() {
            return (
                new RawMaterialButton(
                    fillColor: Colors.black,
                    child:  new Icon(Icons.chevron_left, color: Colors.white),
                    shape: new CircleBorder(),
                    padding: const EdgeInsets.all(12.0),
                    onPressed: _controller.index >= 0
                        ? () { _controller.animateTo(_controller.index - 1);
                                //BlocProvider.of<StepperBloc>(context).add(BackEvent());
                              }
                        : null
                )
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: new TabBarView(
                    children: widget.steps,
                    controller: _controller,
                  ),
                ),
                new Row(
                    children: <Widget> [
                      leftController(),
                      new Expanded(
                        child: new Center(
                          child: new TabPageSelector(
                              controller: _controller,
                              selectedColor: Colors.black,
                              indicatorSize: 10.0,
                          ),
                        ),
                      ),
                      new RawMaterialButton(
                          fillColor: Colors.black,
                          child:  new Icon(Icons.chevron_right, color: Colors.white),
                          shape: new CircleBorder(),
                          padding: const EdgeInsets.all(12.0),
                          onPressed: _controller.index < _controller.length - 1
                              ? () {
                            _controller.animateTo(_controller.index + 1);
                            //BlocProvider.of<StepperBloc>(context).add(ContinueEvent());
                          }
                              : null
                      ),
                    ]
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: widget.steps.length, vsync: this);
  }
}





