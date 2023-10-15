import 'package:csse_app/models/user_model.dart';
import 'package:csse_app/providers/loading_provider.dart';
import 'package:csse_app/services/user_service.dart';
import 'package:csse_app/utils/constants.dart';
import 'package:csse_app/utils/index.dart';
import 'package:csse_app/views/auth/auth_checker.dart';
import 'package:csse_app/widgets/input_field.dart';
import 'package:csse_app/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isSupplier = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final lodingProvider = Provider.of<LoadingProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        reverse: true,
        child: Column(
          children: [
            const SizedBox(
              height: 54,
            ),
            CustomInputField(
              label: "Name",
              hint: "Name",
              controller: name,
            ),
            CustomInputField(
              label: "Email",
              hint: "Email",
              controller: email,
            ),
            CustomInputField(
              label: "Password",
              hint: "Password",
              controller: password,
              isPassword: true,
            ),
            MainButton(
              onPressed: () {
                lodingProvider.updateLoadingState(state: true);
                try {
                  UserModel user = UserModel(
                      name: name.text, email: email.text, role: 'traveller');
                  UserService().addUser(user, password.text);
                  context.navigator(context, AuthChecker(), shouldBack: false);
                } catch (e) {
                  context.showSnackBar(e.toString());
                }
                lodingProvider.updateLoadingState(state: false);
              },
              title: "Signup",
            ),
          ],
        ),
      ),
    );
  }

  InkWell rolePickerButton(VoidCallback onTap, String title, bool shouldShow) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          border: !shouldShow
              ? const Border(
                  bottom: BorderSide(
                  color: primaryColor,
                  width: 2,
                ))
              : null,
        ),
        duration: defaultDuration,
        child: Text(
          title,
        ),
      ),
    );
  }
}
