import 'package:bera/scr/Blocs/accommodation/accommodation_bloc.dart';
import 'package:bera/scr/Blocs/accommodation/accommodation_event.dart';
import 'package:bera/scr/Blocs/accommodation/accommodation_state.dart';
import 'package:bera/scr/Blocs/stepper/stepper_bloc.dart';
import 'package:bera/scr/Blocs/stepper/stepper_events.dart';
import 'package:bera/scr/DataLayer/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AccommodationSearch extends StatefulWidget {
  UserRepository _userRepository;

  AccommodationSearch({Key key, @required UserRepository userRepository})
    : assert(userRepository != null),
    _userRepository = userRepository,
    super(key: key);

  State<AccommodationSearch> createState() => _AccommodationSearchState();
}

class _AccommodationSearchState extends State<AccommodationSearch> {
  final TextEditingController _searchController = TextEditingController();
  AccommodationBloc _accommodationBloc;
  StepperBloc _stepperBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _accommodationBloc = BlocProvider.of<AccommodationBloc>(context);
    _stepperBloc = BlocProvider.of<StepperBloc>(context);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccommodationBloc, AccommodationState>(
      listener: (context, state) {
        if(state is AccommodationError) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Unable to find Accommodation'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      if(state is AccommodationLoaded) {
        _stepperBloc.add(AddAccommodations(state.accommodations));
      }
      },

      child: BlocBuilder<AccommodationBloc, AccommodationState>(
        builder: (context, state) {
          Widget chipList() {
            final list = _stepperBloc.state.accommodations;
            if ( list != null) {
              //final list = state.accommodations;
              List<Widget> choices = List();
              list.forEach( (item) {
                choices.add(Container(
                  padding: const EdgeInsets.all(2.0),
                  child: ChoiceChip(
                    label: Text(item.accommodation),
                    selected: true,
                    selectedColor: Colors.black87,
                    labelStyle: TextStyle(color: Colors.white),
                    onSelected: (selected) {
                      _accommodationBloc.add(
                        RemoveAccommodation(item)
                      );
                    }
                  )
                ));
              });
              return Wrap(
                  children: choices
              );
            }
            return Container();
          }

            return Container(
                margin: const EdgeInsets.only(top: 90.0),
                child: Padding(
                  padding: const EdgeInsets.only(left:55.0, right: 55.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text('Let employers know what accomodations you need.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23
                          ),
                        ),
                      ),
                      SizedBox(height: 60.0),
                      Text('Search for accomodations'),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Reminders, Job coaches....',
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search, color: Colors.black),
                              onPressed: () {
                                _accommodationBloc.add(
                                    FetchAccommodation( _searchController.text)
                                );
                                _searchController.clear();
                              }
                          ),
                          focusColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 40.0),
                      chipList(),
                    ],
                  ),
                )
            );
        },

      )

    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    print(_searchController.text);
  }

}

