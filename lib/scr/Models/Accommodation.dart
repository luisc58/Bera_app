
import 'package:cloud_firestore/cloud_firestore.dart';

class AccommodationEntity {
  final String accommodation;

  AccommodationEntity(this.accommodation);

  static AccommodationEntity fromSnapshot(DocumentSnapshot snap) {
    return AccommodationEntity(
        snap.data['accommodation']
    );
  }
}

class Accommodation {
  final String accommodation;
  Accommodation(this.accommodation);

  static Accommodation fromEntity(AccommodationEntity entity) {
    return Accommodation(
        entity.accommodation
    );
  }
}