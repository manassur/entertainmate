

import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          home: Welcome ( ),
        ),
      ),
   );
}






