

import 'package:bera/scr/Models/WorkLocation.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:math';

const kGoogelApiKey = "AIzaSyAV704_RpNWOODNkKyGMk-X8dx7QNiVGs8";

// to get places detail (lat/lng);
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogelApiKey);

Future<Object> displayPrediction(Prediction p) async {
  if(p != null) {
    //get detail (lat/lang)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;
    final formattedAdr = detail.result.formattedAddress;

    // return lat and lng and adr by returning location object
    return WorkLocationAddress(lat: lat, lng: lng, formattedAdr: formattedAdr);
  }
  return {};
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}