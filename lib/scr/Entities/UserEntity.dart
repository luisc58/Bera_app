import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String uid;
  final String photoUrl;
  final String displayName;
  final bool isEmployee;


  const UserEntity(this.email, this.uid,this.photoUrl, this.displayName, this.isEmployee);
  Map<String, Object>toJson() {
    return {
      'email': email,
      'uid': uid,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'isEmployee': isEmployee
    };
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.data['email'],
      snap.documentID,
      snap.data['photoUrl'],
      snap.data['name'],
      snap.data['isEmployee'],
    );
  }

  Map<String, Object> toDocument() {
     return  {
        "email": email,
        "uid": uid,
        "photoUrl": photoUrl,
        "displayName": displayName,
        "isEmployee": isEmployee,
      };
  }

  @override
  // TODO: implement props
  List<Object> get props => [email, uid, photoUrl, displayName, isEmployee];


}