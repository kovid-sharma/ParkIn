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
