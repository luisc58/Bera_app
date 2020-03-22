import 'package:bera/scr/Blocs/interests/interests_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'gridBuilder.dart';

class InterestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => InterestBloc(),
        child: GridBuilder()
    );
  }
}