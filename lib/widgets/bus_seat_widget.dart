import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csse_app/models/reservation_model.dart';
import 'package:csse_app/providers/loading_provider.dart';
import 'package:csse_app/services/reservation_service.dart';
import 'package:csse_app/utils/collection_names.dart';
import 'package:csse_app/utils/constants.dart';
import 'package:csse_app/utils/index.dart';
import 'package:csse_app/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusSeatWidget extends StatefulWidget {
  final int numSeats;
  final String busId;
  const BusSeatWidget({
    required this.numSeats,
    required this.busId,
  });

  @override
  State<BusSeatWidget> createState() => _BusSeatWidgetState();
}

class _BusSeatWidgetState extends State<BusSeatWidget> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    final LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(reservationsCollection)
              .where(
                'busId',
                isEqualTo: widget.busId,
              )
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            List<String> bookedSeats = [];
            if (snapshot.data != null) {
              if (snapshot.data!.docs.isNotEmpty) {
                for (DocumentSnapshot s in snapshot.data!.docs) {
                  Reservation r = Reservation.fromDocumentSnapshot(s);
                  bookedSeats += r.seatIds;
                }
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._buildSeatRows(bookedSeats),
                MainButton(
                  onPressed: () async {
                    loadingProvider.updateLoadingState(state: true);
                    try {
                      Reservation r = Reservation(
                        busId: widget.busId,
                        createdBy: FirebaseAuth.instance.currentUser?.uid ?? '',
                        seatIds: selectedSeats,
                      );
                      await ReservationService.getInstance()
                          .createReservation(r);
                      context.showSnackBar('Reserved successfully');
                      Navigator.pop(context);
                    } catch (e) {
                      context.showSnackBar(e.toString());
                    }
                    loadingProvider.updateLoadingState(state: true);
                  },
                  title: 'Make my reservation',
                ),
              ],
            );
          }),
    );
  }

  List<Widget> _buildSeatRows(List<String> bookedSeats) {
    List<Widget> rows = [];
    int rowCount = (widget.numSeats / 4).ceil(); // Assuming 4 columns per row

    for (int i = 0; i < rowCount; i++) {
      String rowLabel =
          String.fromCharCode('A'.codeUnitAt(0) + i); // A, B, C, ...
      List<Widget> rowSeats = _buildSeatRow(rowLabel, bookedSeats);
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowSeats,
        ),
      );
    }

    return rows;
  }

  List<Widget> _buildSeatRow(String rowLabel, List<String> bookedSeats) {
    List<Widget> seats = [];

    for (int i = 1; i <= 4; i++) {
      String seatLabel = '$rowLabel$i'; // A1, A2, A3, ...
      seats.add(_buildSeatBox(seatLabel, bookedSeats));
    }

    return seats;
  }

  Widget _buildSeatBox(String seatLabel, List<String> bookedSeats) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          if (!bookedSeats.contains(seatLabel)) {
            if (selectedSeats.contains(seatLabel)) {
              selectedSeats.remove(seatLabel);
            } else {
              selectedSeats.add(seatLabel);
            }
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: bookedSeats.contains(seatLabel)
              ? Colors.red
              : selectedSeats.contains(seatLabel)
                  ? primaryColor
                  : null,
          border: Border.all(),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(seatLabel),
      ),
    );
  }
}
