import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class Auth {
  Future<FirebaseUser> signInWithGoogle();
  Future<void> signOut();
  Future<bool> isUserSignedIn();
  Future<String> getUser();
}

class AuthProvider implements Auth {
  final FirebaseAuth _auth ;
  final GoogleSignIn _googleSignIn;

  AuthProvider({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn
}): _auth = firebaseAuth ?? FirebaseAuth.instance,
    _googleSignIn =  googleSignIn ?? GoogleSignIn();

  @override
  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

    await _auth.signInWithCredential(credential);
    return _auth.currentUser();
  }

  @override
  Future<bool> isUserSignedIn() async{
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  Future<void> signOut() async {
    return Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut()
    ]);
  }

  @override
  Future<String> getUser() async{
    return (await _auth.currentUser()).uid;
  }

}