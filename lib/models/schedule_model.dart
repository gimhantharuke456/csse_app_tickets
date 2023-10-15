import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  String id;
  String date;
  String time;
  String busId;
  String routeId;
  String routeNumber;
  String routeName;

  Schedule({
    required this.id,
    required this.date,
    required this.time,
    required this.busId,
    required this.routeId,
    required this.routeNumber,
    required this.routeName,
  });

  // Factory method to create a Schedule object from a DocumentSnapshot
  factory Schedule.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Schedule(
      id: snapshot.id,
      date: data['date'] ?? '',
      time: data['time'].toString(),
      busId: data['busId'] as String,
      routeId: data['routeId'] as String,
      routeNumber: data['routeNumber'] as String,
      routeName: data['routeName'] as String,
    );
  }
}
