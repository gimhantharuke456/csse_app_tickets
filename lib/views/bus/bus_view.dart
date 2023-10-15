import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csse_app/models/bus_model.dart';
import 'package:csse_app/utils/collection_names.dart';
import 'package:csse_app/widgets/bus_seat_widget.dart';
import 'package:csse_app/widgets/loading.dart';
import 'package:flutter/material.dart';

class BusView extends StatelessWidget {
  final String busId;
  const BusView({
    super.key,
    required this.busId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(busId),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection(busCollection)
              .doc(busId)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.data == null) return Loading();
            Bus bus = Bus.fromDocumentSnapshot(snapshot.data!);
            int numberOfSeats = int.parse(bus.numSeats);
            return Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Driver Name : ${bus.driverId}',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    BusSeatWidget(
                      numSeats: numberOfSeats,
                      busId: busId,
                    ),
                  ],
                )),
              ],
            );
          }),
    );
  }
}
