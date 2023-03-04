import 'package:demoapp_todo/hometab.dart';
import 'package:demoapp_todo/hometodo.dart';
import 'package:demoapp_todo/user/login_screen.dart';
import 'package:demoapp_todo/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job ToDo',
      debugShowCheckedModeBanner: false,
      // initialRoute:
      //     FirebaseAuth.instance.currentUser == null ? 'welcome' : 'home',
      // routes: {
      //   'welcome': (context) => WelcomePage(),
      //   'home': (context) => HomePage(),      // },
      home: WelcomePage(),
    );
  }
}
