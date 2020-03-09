
import 'package:bera/scr/Blocs/login/login_event.dart';
import 'package:bera/scr/Blocs/login/login_state.dart';
import 'package:bera/scr/DataLayer/FirebaseAuth_provider.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthProvider _auth;
  LoginBloc(authProvider) : assert(authProvider != null), _auth = authProvider;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    yield LoginState.loading();
    try {
      await _auth.signInWithGoogle();
      yield LoginState.success();
    } catch (err) {
      print(err.toString());
      yield LoginState.failure();
    }
  }

}