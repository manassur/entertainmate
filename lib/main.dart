

import 'package:entertainmate/mate.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:entertainmate/screens/utility/verify_user_provider.dart';
import 'package:entertainmate/screens/utility/create_event_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp (
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CompleteProfileProvider()),
          ChangeNotifierProvider(create: (_) => VerifyUserProvider()),
          ChangeNotifierProvider(create: (_) => CreateEventProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen (),
          // home: Mate(),
        ),
      ),
   );
}






