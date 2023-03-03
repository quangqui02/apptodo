import 'package:demoapp_todo/user/login_screen.dart';
import 'package:demoapp_todo/user/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height * 1,
        width: size.height * 1,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/welcome.json', height: size.height * 0.13),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/login2.json', height: size.height * 0.35),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.07,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Container(
                  alignment: Alignment.center,
                  width: size.width * 0.6,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: Text(
                    'Đăng Ký',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ))),
          SizedBox(
            height: size.height * 0.008,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Container(
                  alignment: Alignment.center,
                  width: size.width * 0.6,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: Text(
                    'Đăng Nhập',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ))),
        ]),
      ),
    );
  }
}
