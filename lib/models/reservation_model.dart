import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  String? id;
  String busId;
  String createdBy;
  List<String> seatIds;

  Reservation({
    this.id,
    required this.busId,
    required this.createdBy,
    required this.seatIds,
  });

  // Factory method to create a Reservation object from a JSON Map
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      busId: json['busId'] as String,
      createdBy: json['createdBy'] as String,
      seatIds: List<String>.from(json['seatIds']),
    );
  }

  // Convert Reservation object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'busId': busId,
      'createdBy': createdBy,
      'seatIds': seatIds,
    };
  }

  factory Reservation.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Reservation(
      id: snapshot.id,
      busId: data['busId'] as String,
      createdBy: data['createdBy'] as String,
      seatIds: List<String>.from(data['seatIds']),
    );
  }
}
