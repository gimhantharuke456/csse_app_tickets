import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csse_app/models/schedule_model.dart';
import 'package:csse_app/utils/collection_names.dart';
import 'package:csse_app/utils/index.dart';
import 'package:csse_app/views/bus/bus_view.dart';
import 'package:csse_app/widgets/loading.dart';
import 'package:flutter/material.dart';

class ReserveBus extends StatelessWidget {
  const ReserveBus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve a bus'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(schedulesCollection)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            return ListView(
              children: snapshot.data!.docs.map((e) {
                Schedule s = Schedule.fromDocumentSnapshot(e);
                return Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    onTap: () {
                      context.navigator(context, BusView(busId: s.busId));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    title: Text('${s.routeName}-${s.routeNumber} '),
                    subtitle: Text(
                      '${s.time} ${s.date} ',
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
