import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csse_app/models/ticket_model.dart';
import 'package:csse_app/utils/constants.dart';
import 'package:csse_app/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyTickets extends StatelessWidget {
  const MyTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My History'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tickets')
              .where("createdBy",
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Loading();
            }
            return ListView(
              children: snapshot.data!.docs.map((e) {
                Ticket ticket = Ticket.fromDocumentSnapshot(e);

                return GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.width * 0.8,
                                color: Colors.white,
                                child: QrImageView(
                                  data:
                                      '${ticket.busId},${ticket.destination},${ticket.numOfSeats}',
                                  size: 320,
                                  gapless: false,
                                  errorStateBuilder: (cxt, err) {
                                    return const Center(
                                      child: Text(
                                        'Uh oh! Something went wrong...',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ));
                  },
                  child: Card(
                    color: Colors.grey[100],
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Destination ${ticket.destination}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Number of seats ${ticket.numOfSeats}',
                            ),
                            Text(
                                'Date ${DateFormat('yyyy/MM/dd - hh:mm').format(DateTime.parse(ticket.cretedAt))}')
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
