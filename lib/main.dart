import 'package:demoapp_todo/hometab.dart';
import 'package:demoapp_todo/hometodo.dart';
import 'package:demoapp_todo/user/login_screen.dart';
import 'package:demoapp_todo/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();

//   print("Handling a background message: ${message.messageId}");
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
// Future<void> main(List<String> args) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(YakoApp());
// }

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
      //   'home': (context) => HomePage(),
      // },
      home: WelcomePage(),
    );
  }
}
