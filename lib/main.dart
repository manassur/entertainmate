

import 'package:entertainmate/mate.dart';
import 'package:entertainmate/screens/log_in.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'invite.dart';
import 'mate_home.dart';
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

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Mate ( ),
        ),
      ),
   );
}






