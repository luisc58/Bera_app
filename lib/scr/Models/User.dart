
import 'package:bera/scr/Entities/UserEntity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String displayName;
  final bool isEmployee;
  final bool isFirstTimeUser;

  const User({this.isEmployee = true, this.isFirstTimeUser = true, String email, String uid, String displayName, String photoUrl}) :
      this.email = email, this.uid = uid, this.displayName = displayName, this.photoUrl = photoUrl;


  factory User.fromDocument(DocumentSnapshot document ) {
    return User(
      email: document['Email'],
      uid: document['uid'],
      photoUrl: document['photoUrt'],
      displayName: document['displayName'],
      isEmployee: document['isEmployee'],
      isFirstTimeUser: document['isFirstTimeUser']
    );
  }

   User.fromMap(Map snapshot, String id) :
    email = snapshot['email'] ?? '',
    uid = id ?? '',
    photoUrl =  snapshot['photoUrl'] ?? '',
    displayName = snapshot['displayName'] ?? '',
    isEmployee = snapshot['isEmployee'] ?? true,
    isFirstTimeUser = snapshot['isFirstTimeUser'] ?? true;

  String get userId => uid;

  UserEntity toEntity() {
    return UserEntity(email,uid,photoUrl,displayName, isEmployee);
  }

}