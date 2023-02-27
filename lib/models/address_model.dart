class Address {
  Address({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
