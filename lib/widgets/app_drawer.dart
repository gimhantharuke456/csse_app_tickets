import 'package:csse_app/utils/constants.dart';
import 'package:csse_app/widgets/drawer_button.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            CustomDrawerButton(
              title: "Home",
              onPressed: () {},
              icon: const Icon(Icons.home),
            ),
            CustomDrawerButton(
              title: "Profile",
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
            CustomDrawerButton(
              title: "Requisitions",
              onPressed: () {},
              icon: const Icon(Icons.request_page),
            ),
            CustomDrawerButton(
              title: "Deliveries",
              onPressed: () {},
              icon: const Icon(Icons.bike_scooter),
            ),
            CustomDrawerButton(
              title: "Items",
              onPressed: () {},
              icon: const Icon(Icons.card_travel),
            ),
            CustomDrawerButton(
              title: "Signout",
              onPressed: () async {},
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
