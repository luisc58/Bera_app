import 'package:bera/scr/UI/login_screen.dart';
import "package:flutter/material.dart";
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(BeraApp());

//TODO
// 1. Build login UI -- completed
// 2. login blocs and connect firebase to app
// 3. create user model
////||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
class BeraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: LoginScreen()
    );
  }

}