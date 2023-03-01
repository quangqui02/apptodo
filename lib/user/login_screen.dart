import 'package:demoapp_todo/hometab.dart';
import 'package:demoapp_todo/hometodo.dart';
import 'package:demoapp_todo/user/register.dart';
import 'package:demoapp_todo/user/forget_pass.dart';
import 'package:demoapp_todo/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../error/message.dart';
import '../error/messageerror.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  bool show = false;
  void changeshow() {
    setState(() {
      show = !show;
    });
  }

  void login(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false))
        //errorSnackBar(context, 'Đăng Nhập Thành Công')
        .catchError((onError) => print(onError));
    //errorSnackBar(context, onError));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            Column(children: [
              SizedBox(
                height: 80,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/2.json', height: 190),
                    Image(
                      image: AssetImage('assets/todo.png'),
                      height: 150,
                      width: 130,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Đăng Nhập',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Container(
                  width: 300,
                  child: Material(
                    elevation: 8,
                    shadowColor: Colors.black87,
                    color: Color.fromARGB(0, 230, 227, 227),
                    borderRadius: BorderRadius.circular(20),
                    child: TextField(
                      onChanged: (value) {
                        // _email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.black),
                        // prefixIcon: Icon(
                        //   Icons.man,
                        //   size: 30,
                        //   color: Colors.red,
                        // )
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: Container(
                  width: 300,
                  child: Material(
                    elevation: 8,
                    shadowColor: Colors.black87,
                    color: Color.fromARGB(0, 250, 0, 0),
                    borderRadius: BorderRadius.circular(20),
                    child: TextField(
                      onChanged: (value) {
                        // _email = value;
                      },
                      controller: _password,
                      textAlignVertical: TextAlignVertical.bottom,
                      obscureText: show,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        hintText: 'Mật Khẩu',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        suffixIcon: InkWell(
                          onTap: changeshow,
                          child: show
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.black,
                                ),
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => ForgetPass());
                      },
                      child: Text(
                        'Quên Mật Khẩu?',
                        style: TextStyle(
                            color: Color.fromARGB(148, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: () {
                    signIn(_email.text, _password.text);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 180,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                      child: Text(
                        'Đăng Nhập',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ))),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn chưa có tài khoản?',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      child: Text(
                        'Đăng Ký Ngay',
                        style: TextStyle(
                            color: Color.fromARGB(255, 30, 255, 0),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                // Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Hometab())),
                showDialog(
                    context: context, builder: (context) => MessageTime()),
              });
    } on FirebaseAuthException catch (error) {
      print(error.code);
      switch (error.code) {
        // print(error.code);
        case "invalid-email":
          //errorMessage = "Your email address appears to be malformed.";
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Không Hợp Lệ',
                  ));

          break;
        case "unknown":
          //errorMessage = "Your email address appears to be malformed.";
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Nhập Đủ Thông Tin',
                  ));

          break;
        case "wrong-password":
          //errorMessage = "Your password is wrong.";
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Sai Mật Khẩu',
                  ));
          break;
        case "user-not-found":
          // errorMessage = "User with this email doesn't exist.";
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Không Tồn Tại',
                  ));
          break;
        case "user-disabled":
          // errorMessage = "User with this email has been disabled.";
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Vô Hiệu Hóa',
                  ));
          break;
          break;
        case "too-many-requests":
          // errorMessage = "Too many requests";
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Quá Nhiều Yêu Cầu',
                  ));
          break;
          break;
        case "operation-not-allowed":
          // errorMessage = "Signing in with Email and Password is not enabled.";
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Tài Khoản Không Kích Hoạt',
                  ));
          break;
          break;
        default:
          // errorMessage = "An undefined Error happened.";
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Lỗi Không Xác Định',
                  ));
          break;
      }
      // Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);
    }
  }
}
