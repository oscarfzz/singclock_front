class LocationModel {
  final String idReg;
  final String lat;
  final String lon;
  final String timestamp;

  LocationModel({
    required this.idReg,
    required this.lat,
    required this.lon,
    required this.timestamp,
  });

  factory LocationModel.fromJson(Map<String, dynamic> jsonData) {
    return LocationModel(
      idReg: jsonData['id_reg'],
      lat: jsonData['lat'],
      lon: jsonData['lon'],
      timestamp: jsonData['timestamp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id_reg': idReg,
        'lat': lat,
        'lon': lon,
        'timestamp': timestamp,
      };
}
