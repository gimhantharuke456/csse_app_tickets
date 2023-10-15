import 'package:csse_app/providers/loading_provider.dart';
import 'package:csse_app/providers/user_provider.dart';
import 'package:csse_app/services/local_prefs.dart';
import 'package:csse_app/utils/constants.dart';
import 'package:csse_app/views/auth/auth_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalPreferences localPreferences = LocalPreferences.instance;
  await localPreferences.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingProvider>(
          create: (context) => LoadingProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor,
            centerTitle: false,
          ),
        ),
        home: const AuthChecker(),
      ),
    );
  }
}
