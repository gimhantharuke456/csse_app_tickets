import 'package:csse_app/providers/user_provider.dart';
import 'package:csse_app/services/auth_service.dart';
import 'package:csse_app/utils/constants.dart';
import 'package:csse_app/utils/index.dart';
import 'package:csse_app/views/auth/auth_checker.dart';
import 'package:csse_app/views/bus/reserve_bus.dart';
import 'package:csse_app/views/iamonthe_bus/inside_bus_view_one.dart';
import 'package:csse_app/views/my_tickets/my_tickets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Welcome ${userProvider.user?.name}'),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () async {
                await AuthService().signOutUser();
                context.navigator(context, AuthChecker(), shouldBack: false);
              },
              child: const Text(
                'Signout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            homeButton(context, InsideBusViewOne(), "I am on the bus"),
            homeButton(context, ReserveBus(), "Reserve a bus"),
            homeButton(context, MyTickets(), "My History"),
          ],
        ),
      );
    });
  }

  GestureDetector homeButton(BuildContext context, Widget widget, String text) {
    return GestureDetector(
      onTap: () {
        context.navigator(context, widget);
      },
      child: Container(
        margin: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(12)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
