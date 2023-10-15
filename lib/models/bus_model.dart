import 'package:cloud_firestore/cloud_firestore.dart';

class Bus {
  String id;
  String name;
  String numSeats;
  String routeNumber;
  String status;
  String driverId;

  Bus({
    required this.id,
    required this.name,
    required this.numSeats,
    required this.routeNumber,
    required this.status,
    required this.driverId,
  });

  // Factory method to create a Bus object from a DocumentSnapshot
  factory Bus.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Bus(
      id: snapshot.id,
      name: data['name'] ?? '',
      numSeats: data['numSeats'] ?? '',
      routeNumber: data['routeNumber'] ?? '',
      status: data['status'] ?? '',
      driverId: data['driver'] ?? '',
    );
  }
}
