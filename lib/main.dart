import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/config/route/app_routes.dart';
import 'src/core/util/options_firebase.dart';
import 'src/core/util/numbers.dart';
import 'src/core/util/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: OptionsFirebase.apiKey,
      appId: OptionsFirebase.appId,
      messagingSenderId: OptionsFirebase.messagingSenderId,
      projectId: OptionsFirebase.projectId,
      databaseURL: OptionsFirebase.databaseURL,
    ),
  ).then(
    (value) {
      runApp(
        const ProviderScope(
          child: MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Numbers.colorAppBar,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Strings.homeRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
