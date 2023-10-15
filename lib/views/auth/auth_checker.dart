import 'package:csse_app/providers/loading_provider.dart';
import 'package:csse_app/providers/user_provider.dart';
import 'package:csse_app/services/auth_service.dart';
import 'package:csse_app/services/local_prefs.dart';
import 'package:csse_app/views/auth/home_screen.dart';
import 'package:csse_app/views/auth/login_screen.dart';
import 'package:csse_app/views/no_permissions.dart';
import 'package:csse_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  final _localPrefs = LocalPreferences.instance;
  final _authService = AuthService();

  late LoadingProvider loadingProvider;
  late UserProvider userProvider;
  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.updateLoadingState(state: true);
    _authService.getCurrentUser().then((user) {
      if (user != null) {
        userProvider.updateUser(user);
      }
    });
    loadingProvider.updateLoadingState(state: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _localPrefs.getToken(),
      builder: (context, AsyncSnapshot<String?> snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.data != null
                ? Consumer<UserProvider>(builder: (context, value, child) {
                    return value.user != null
                        ? value.user!.role == 'admin'
                            ? const NoPermissions()
                            : value.user!.role == "traveller"
                                ? const HomeScreen()
                                : const NoPermissions()
                        : Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            color: Colors.green,
                          );
                  })
                : const LoginScreen()
            : const Loading();
      },
    );
  }
}
