import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';
import 'providers/auth_provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        // ChangeNotifierProvider<LanguageProvider>(
        //   create: (context) => LanguageProvider(),
        // ),
      ],
      child: const MyApp(
        // databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
        key: Key('MyApp'),
      ),
    ),
  );
}
