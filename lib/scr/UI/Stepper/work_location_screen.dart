import 'package:bera/scr/Blocs/stepper/stepper_bloc.dart';
import 'package:bera/scr/Blocs/stepper/stepper_events.dart';
import 'package:bera/scr/Blocs/workLocation/work_location_bloc.dart';
import 'package:bera/scr/Blocs/workLocation/work_location_event.dart';
import 'package:bera/scr/Blocs/workLocation/work_location_state.dart';
import 'package:bera/scr/DataLayer/google_places.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class WorkLocation extends StatefulWidget {
  @override
  _WorkLocationState createState() => _WorkLocationState();
}

class _WorkLocationState extends State<WorkLocation>  {
  StepperBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _locationBloc = BlocProvider.of<StepperBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WorkLocationBloc(),
      child: Scaffold(
        body: BlocBuilder<WorkLocationBloc, WorkLocationState>(
          builder: (context, state) {
            final textController = TextEditingController();
            textController.text = _locationBloc.state.workLocationAddress?.formattedAdr ?? "";
            // don't forget to dispose controller
            return Container(
                margin: const EdgeInsets.only(top: 90.0),
                child: Padding(
                  padding: const EdgeInsets.only(left:55.0, right: 55.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text('Where do you want to work?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23
                          ),
                        ),
                      ),
                      SizedBox(height: 60.0),
                      Text('City, State, or Zip code'),
                      SizedBox(height: 10.0),
                      TextField(
                        // controller
                          controller: textController,
                          decoration: InputDecoration(
                              focusColor: Colors.black,
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.add_location, color: Colors.black),
                                  onPressed: () {}
                              )
                          ),
                          onTap: () async {
                            Prediction p = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: "AIzaSyAV704_RpNWOODNkKyGMk-X8dx7QNiVGs8",
                                mode: Mode.overlay,
                                language:"en"
                            );
                            final selection = await displayPrediction(p);
                            BlocProvider.of<WorkLocationBloc>(context).add(SelectWorkLocation(selection));
                            _locationBloc.add(WorkLocationUpdated(selection));
                            FocusScope.of(context).unfocus();
                          }
                      ),
                      SizedBox(height: 20.0),
                      Text('Miles'),
                      DropdownButton<String>(
                        hint: Text('20 Miles'),
                        items: <String>['A', 'B', 'C', 'D'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                      SizedBox(height: 60.0),
                      Center(
                        child: FlatButton(
                          child: Text("Remote"),
                          onPressed: () {},
                        ),
                      )

                    ],
                  ),
                )
            );
          }

        )
      ),
    );
  }

}
