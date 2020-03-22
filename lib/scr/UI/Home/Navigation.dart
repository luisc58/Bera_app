import 'package:bera/scr/Blocs/navigation/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/Home.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  NavbarBloc _navbarBloc;

  @override
  void initState() {
    super.initState();
    _navbarBloc = NavbarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder (
      bloc: _navbarBloc,
      // ignore: missing_return
      builder: (BuildContext context, NavbarState state) {
        if(state is ShowHome) {
          return buildHomepage(state.title, Home(), state.itemIndex);
        }
        else if ( state is ShowChat) {
          return buildHomepage(state.title, Container(), state.itemIndex);
        }
        else if (state is ShowSaved) {
          return buildHomepage(state.title, Container(), state.itemIndex);
        }
        else if( state is ShowProfile) {
          return buildHomepage(state.title, Container(), state.itemIndex);
        }
      }
    );
  }

  Scaffold buildHomepage(String title, Widget container, int currentIndex) {
    return Scaffold(
      body: container,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if(index == 0) _navbarBloc.add(NavbarItems.Home);
          if(index == 1) _navbarBloc.add(NavbarItems.Chat);
          if(index == 2) _navbarBloc.add(NavbarItems.Saved);
          if(index == 3) _navbarBloc.add(NavbarItems.Profile);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              title: Text("Home", style: TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message, color: Colors.black),
              title: Text("Chat", style: TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.black),
              title: Text("Saved", style: TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.black),
              title: Text("Profile", style: TextStyle(color: Colors.black))
          ),
        ],
      ),
    );
  }
}



