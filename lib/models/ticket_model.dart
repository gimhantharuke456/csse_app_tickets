import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  String? id; // Assuming each ticket has a unique identifier
  String destination;
  String numOfSeats;
  String createdBy;
  String busId;
  String cretedAt;
  Ticket({
    this.id,
    required this.destination,
    required this.numOfSeats,
    required this.createdBy,
    required this.busId,
    required this.cretedAt,
  });

  // Factory method to create a Ticket object from a DocumentSnapshot
  factory Ticket.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Ticket(
        id: snapshot.id,
        destination: data['destination'] as String,
        numOfSeats: data['numOfSeats'] as String,
        createdBy: data['createdBy'] as String,
        busId: data['busId'] as String,
        cretedAt: data['cretedAt'] ?? '');
  }

  // Convert Ticket object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'numOfSeats': numOfSeats,
      'createdBy': createdBy,
      'busId': busId,
      'cretedAt': cretedAt,
    };
  }
}
