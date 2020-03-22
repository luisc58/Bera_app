

class WorkLocationAddress {
  final lat;
  final lng;
  final formattedAdr;

  WorkLocationAddress({double lat, double lng, String formattedAdr}) :
      this.lat = lat, this.lng = lng, this.formattedAdr = formattedAdr;
}