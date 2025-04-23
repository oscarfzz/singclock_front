class LocationModel {
  final String id_reg;
  final String lat;
  final String lon;
  final String timestamp;

  LocationModel({
    required this.id_reg,
    required this.lat,
    required this.lon,
    required this.timestamp,
  });

  factory LocationModel.fromJson(Map<String, dynamic> jsonData) {
    return LocationModel(
      id_reg: jsonData['id_reg'],
      lat: jsonData['lat'],
      lon: jsonData['lon'],
      timestamp: jsonData['timestamp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id_reg': id_reg,
        'lat': lat,
        'lon': lon,
        'timestamp': timestamp,
      };
}
