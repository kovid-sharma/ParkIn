class PendingLocation {
  String lotName;
  String name;
  int maxCapacity;
  int rows;
  int cols;
  double latitude;
  double longitude;
  String address;
  List<List<int>> selectedSeats; // List of pairs of two ints

  PendingLocation({
    required this.lotName,
    required this.name,
    required this.maxCapacity,
    required this.rows,
    required this.cols,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.selectedSeats,
  });

  Map<String, dynamic> toMap() {
    return {
      'lotName': lotName,
      'name': name,
      'maxCapacity': maxCapacity,
      'rows': rows,
      'cols': cols,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'selectedSeats': selectedSeats,
    };
  }

  factory PendingLocation.fromMap(Map<String, dynamic> map) {
    return PendingLocation(
      lotName: map['lotName'],
      name: map['name'],
      maxCapacity: map['maxCapacity'],
      rows: map['rows'],
      cols: map['cols'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      selectedSeats: List<List<int>>.from(map['selectedSeats'] ?? []),
    );
  }
}
class Location {
  String name;
  String lotName;
  String image;
  int rows;
  int cols;
  int maxCapacity;
  double latitude;
  double longitude;
  String address;
  List<String> selectedSeats;

  Location({
    required this.name,
    required this.lotName,
    required this.image,
    required this.rows,
    required this.cols,
    required this.maxCapacity,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.selectedSeats,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lotName': lotName,
      'image': image,
      'rows': rows,
      'cols': cols,
      'maxCapacity': maxCapacity,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'selectedSeats': selectedSeats,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] ?? '',
      lotName: map['lotName'] ?? '',
      image: map['image'] ?? '',
      rows: map['rows'] ?? 0,
      cols: map['cols'] ?? 0,
      maxCapacity: map['maxCapacity'] ?? 0,
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      address: map['address'] ?? '',
      selectedSeats: List<String>.from(map['selectedSeats'] ?? []),
    );
  }

// Add any additional methods or conversions as needed
}
