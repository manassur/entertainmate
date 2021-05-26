

import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:entertainmate/screens/utility/verify_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/profile.dart';
import 'screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp (
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CompleteProfileProvider()),
          ChangeNotifierProvider(create: (_) => VerifyUserProvider()),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Welcome ( ),
        ),
      ),
   );
}






