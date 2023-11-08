import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_challenge/src/config/route/app_router.dart';
import 'src/core/util/options_firebase.dart';
import 'src/core/util/numbers.dart';

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
        ProviderScope(
          child: MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(
            Numbers.colorAppBar,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
