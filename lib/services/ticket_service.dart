import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csse_app/models/ticket_model.dart';

class TicketService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static TicketService? _instance;

  TicketService._();

  static TicketService getInstance() {
    _instance ??= TicketService._();
    return _instance!;
  }

  // Create a new ticket
  Future<String> createTicket(Ticket ticket) async {
    try {
      CollectionReference<Map<String, dynamic>> tickets = _firestore
          .collection('tickets') as CollectionReference<Map<String, dynamic>>;
      DocumentReference<Map<String, dynamic>> docRef =
          await tickets.add(ticket.toJson());
      return docRef.id;
    } catch (e) {
      throw e;
    }
  }

  // Get a ticket by ID
  Future<Ticket> getTicketById(String ticketId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('tickets')
          .doc(ticketId)
          .get() as DocumentSnapshot<Map<String, dynamic>>;
      if (doc.exists) {
        return Ticket.fromDocumentSnapshot(doc);
      }
      throw Exception("Ticket not found");
    } catch (e) {
      throw e;
    }
  }

  // Update a ticket
  Future<void> updateTicket(String ticketId, Ticket ticket) async {
    try {
      await _firestore
          .collection('tickets')
          .doc(ticketId)
          .update(ticket.toJson());
    } catch (e) {
      throw e;
    }
  }

  // Delete a ticket
  Future<void> deleteTicket(String ticketId) async {
    try {
      await _firestore.collection('tickets').doc(ticketId).delete();
    } catch (e) {
      throw e;
    }
  }
}
