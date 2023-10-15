import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csse_app/models/reservation_model.dart';

class ReservationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static ReservationService? _instance;

  ReservationService._();

  static ReservationService getInstance() {
    if (_instance == null) {
      _instance = ReservationService._();
    }
    return _instance!;
  }

  // Create a new reservation
  Future<String> createReservation(Reservation reservation) async {
    try {
      CollectionReference<Map<String, dynamic>> reservations =
          _firestore.collection('reservations')
              as CollectionReference<Map<String, dynamic>>;
      DocumentReference<Map<String, dynamic>> docRef =
          await reservations.add(reservation.toJson());
      return docRef.id;
    } catch (e) {
      throw e;
    }
  }

  // Get a reservation by ID
  Future<Reservation?> getReservationById(String reservationId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('reservations')
          .doc(reservationId)
          .get() as DocumentSnapshot<Map<String, dynamic>>;
      if (doc.exists) {
        return Reservation.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw e;
    }
  }

  // Update a reservation
  Future<void> updateReservation(
      String reservationId, Reservation reservation) async {
    try {
      await _firestore
          .collection('reservations')
          .doc(reservationId)
          .update(reservation.toJson());
    } catch (e) {
      throw e;
    }
  }

  // Delete a reservation
  Future<void> deleteReservation(String reservationId) async {
    try {
      await _firestore.collection('reservations').doc(reservationId).delete();
    } catch (e) {
      throw e;
    }
  }
}
