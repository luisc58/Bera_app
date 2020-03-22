 // Navigation Bloc implemenatation

 //Events
 import 'package:bloc/bloc.dart';

enum NavbarItems { Home, Chat, Saved, Profile }

 // States
 abstract class NavbarState {}

 class ShowHome extends NavbarState {
  final String title = "Home";
  final int itemIndex = 0;
 }

 class ShowChat extends NavbarState {
   final String title = "Chat";
   final int itemIndex = 1;
 }

 class ShowSaved extends NavbarState {
   final String title = "Saved";
   final int itemIndex = 2;
 }

 class ShowProfile extends NavbarState {
   final String title = "Profile";
   final int itemIndex = 3;
 }



//BLOC
 class NavbarBloc extends Bloc<NavbarItems, NavbarState> {
  @override
  NavbarState get initialState => ShowHome();

  @override
  Stream<NavbarState> mapEventToState(NavbarItems event) async* {
    switch (event) {
      case NavbarItems.Home:
        yield ShowHome();
        break;
      case NavbarItems.Chat:
        yield ShowChat();
        break;
      case NavbarItems.Saved:
        yield ShowSaved();
        break;
      case NavbarItems.Profile:
        yield ShowProfile();
        break;
    }
  }

 }