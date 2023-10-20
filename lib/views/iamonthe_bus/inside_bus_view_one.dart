import 'dart:typed_data';

import 'package:csse_app/models/ticket_model.dart';
import 'package:csse_app/services/ticket_service.dart';
import 'package:csse_app/utils/constants.dart';
import 'package:csse_app/utils/index.dart';
import 'package:csse_app/views/auth/home_screen.dart';
import 'package:csse_app/widgets/input_field.dart';
import 'package:csse_app/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class InsideBusViewOne extends StatefulWidget {
  const InsideBusViewOne({super.key});

  @override
  State<InsideBusViewOne> createState() => _InsideBusViewOneState();
}

class _InsideBusViewOneState extends State<InsideBusViewOne> {
  final destination = TextEditingController();
  final numOfSeats = TextEditingController();
  final key = GlobalKey<FormState>();
  String busId = 'nKKCxbJ2zpZplemswVk2';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan the QR"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            color: Colors.red,
            child: MobileScanner(
              // fit: BoxFit.contain,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;
                for (final barcode in barcodes) {
                  debugPrint('Barcode found! ${barcode.rawValue}');
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: MainButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Form(
                        key: key,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomInputField(
                              label: 'Destination',
                              hint: 'Destination',
                              controller: destination,
                            ),
                            CustomInputField(
                              label: 'Num of seats',
                              hint: 'Num of seats',
                              controller: numOfSeats,
                            ),
                            MainButton(
                              onPressed: () async {
                                if (key.currentState!.validate()) {
                                  try {
                                    Ticket ticket = Ticket(
                                      destination: destination.text,
                                      numOfSeats: numOfSeats.text,
                                      createdBy: FirebaseAuth
                                              .instance.currentUser?.uid ??
                                          '',
                                      busId: busId,
                                      cretedAt: DateTime.now().toString(),
                                    );
                                    await TicketService.getInstance()
                                        .createTicket(ticket);
                                    context.showSnackBar(
                                        'You bought ticket successfully');
                                    Navigator.pop(context);
                                    context.navigator(context, HomeScreen(),
                                        shouldBack: false);
                                  } catch (e) {
                                    Navigator.pop(context);
                                    context.showSnackBar(e.toString());
                                  }
                                }
                              },
                              title: 'Buy Tickets',
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              title: "Scan",
            ),
          ),
        ],
      ),
    );
  }
}
