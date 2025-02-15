import 'package:bera/scr/Models/Accommodation.dart';
import 'package:bera/scr/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference accommodationCollection = Firestore.instance.collection('accommodations');
  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }


  Stream<List<Accommodation>> getAccommodations(accommodation) {
    return accommodationCollection.where("accommodation", isEqualTo: accommodation)
        .snapshots().map( (snapshot) {
          return snapshot.documents
              .map((doc) => Accommodation.fromEntity(AccommodationEntity.fromSnapshot(doc))).toList();
    });
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  Future<DocumentSnapshot> userExists(uid) async {
    return await userCollection.document(uid).get();
  }

  Future<void> updateUserData(data) async {
    return await userCollection.document(data['uid']).setData(data);
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }
  
  Future<bool> isFirstTimeUser(uid) async {
    var doc = await userCollection.document(uid).get();
    return User.fromMap(doc.data, doc.documentID).isFirstTimeUser;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).uid;
  }
}