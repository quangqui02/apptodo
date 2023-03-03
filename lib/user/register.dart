import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/hometodo.dart';
import 'package:demoapp_todo/user/login_screen.dart';
import 'package:demoapp_todo/object/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lottie/lottie.dart';

import '../error/message.dart';
import '../error/messageerror.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
  String? errorMessage;
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    Users userModel = Users();
    userModel.email = user!.email;
    userModel.id = user.uid;
    userModel.name = _name.text;
    userModel.password = _password.text;
    await firebaseFirestore
        .collection("user")
        .doc(user.uid)
        .set(userModel.toMap());
  }

  bool show = false;
  void changeshow() {
    setState(() {
      show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width * 1,
        height: size.height * 1,
        color: Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            Column(children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/2.json', height: size.height * 0.24),
                    Image(
                      image: AssetImage('assets/todo.png'),
                      height: size.height * 0.25,
                      width: size.width * 0.35,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Đăng Ký',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
                child: Container(
                  width: size.width * 0.8,
                  child: Material(
                    elevation: 8,
                    shadowColor: Colors.black87,
                    color: Color.fromARGB(0, 230, 227, 227),
                    borderRadius: BorderRadius.circular(20),
                    child: TextFormField(
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return ("Vui Lòng Nhập Email");
                      //   }
                      //   // reg expression for email validation
                      //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      //       .hasMatch(value)) {
                      //     return ("Vui Lòng Nhập Email Hợp Lệ");
                      //   }
                      //   return null;
                      // },
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {},
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
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                height: size.height * 0.08,
                child: Container(
                  width: size.width * 0.8,
                  child: Material(
                    elevation: 8,
                    shadowColor: Colors.black87,
                    color: Color.fromARGB(0, 230, 227, 227),
                    borderRadius: BorderRadius.circular(20),
                    child: TextFormField(
                      // validator: (value) {
                      //   RegExp regex = new RegExp(r'^.{6,}$');
                      //   if (value!.isEmpty) {
                      //     return ("Password is required for login");
                      //   }
                      //   if (!regex.hasMatch(value)) {
                      //     return ("Enter Valid Password(Min. 6 Character)");
                      //   }
                      // },
                      obscureText: show,
                      controller: _password,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        hintText: 'Mật Khẩu',
                        hintStyle: TextStyle(color: Colors.black),
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
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                height: size.height * 0.08,
                child: Container(
                  width: size.width * 0.8,
                  child: Material(
                    elevation: 8,
                    shadowColor: Colors.black87,
                    color: Color.fromARGB(0, 250, 0, 0),
                    borderRadius: BorderRadius.circular(20),
                    child: TextField(
                      controller: _name,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        hintText: 'Tên Của Bạn',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextButton(
                onPressed: () async {
                  signUp(_email.text, _password.text);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width * 0.5,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Text(
                    'Đăng Ký',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn đã có tài khoản?',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Đăng Nhập Ngay',
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

  void signUp1(String email, String password) async {
    try {
      if (_email.text.isNotEmpty &&
          _password.text.isNotEmpty &&
          _name.text.isNotEmpty) {
        final newUser = _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => postDetailsToFirestore());
        if (newUser != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          showDialog(context: context, builder: (context) => MessageTime());
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => MessageErrorTime(
                  text: 'Nhập Đủ Thông Tin',
                ));
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Không Hợp Lệ',
                  ));
          break;
        case "unknown":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Nhập Đủ Thông Tin',
                  ));
          break;
        case "wrong-password":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Sai Mật Khẩu',
                  ));
          break;
        case "user-not-found":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Không Tồn Tại',
                  ));
          break;
        case "user-disabled":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Vô Hiệu Hóa',
                  ));
          break;
        case "too-many-requests":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Quá Nhiều Yêu Cầu',
                  ));
          break;
        case "operation-not-allowed":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Tài Khoản Không Kích Hoạt',
                  ));
          break;
        case "weak-password":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Mật Khẩu Trên 6 Ký Tự',
                  ));
          break;
        default:
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Lỗi Không Xác Định',
                  ));
          break;
      }
      print(error.code);
    }
  }

  void signUp(String email, String password) async {
    try {
      if (_email.text.isNotEmpty &&
          _password.text.isNotEmpty &&
          _name.text.isNotEmpty) {
        if (_name.text.length <= 20) {
          await _auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) => {
                    postDetailsToFirestore(),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage())),
                    showDialog(
                        context: context, builder: (context) => MessageTime()),
                  });
        } else {
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Tên Không Được Quá 20 Ký Tự',
                  ));
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => MessageErrorTime(
                  text: 'Nhập Đủ Thông Tin',
                ));
      }
    } on FirebaseAuthException catch (error) {
      print(error.code);
      switch (error.code) {
        case "invalid-email":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Không Hợp Lệ',
                  ));
          break;
        case "unknown":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Nhập Đủ Thông Tin',
                  ));
          break;
        case "email-already-in-use":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Đã Đươc Sử Dụng',
                  ));
          break;
        case "user-not-found":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Không Tồn Tại',
                  ));
          break;
        case "user-disabled":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Vô Hiệu Hóa',
                  ));
          break;
        case "too-many-requests":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Quá Nhiều Yêu Cầu',
                  ));
          break;
        case "operation-not-allowed":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Tài Khoản Không Kích Hoạt',
                  ));
          break;
        case "weak-password":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Mật Khẩu Trên 6 Ký Tự',
                  ));
          break;
        default:
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Lỗi Không Xác Định',
                  ));
          break;
      }
    }
  }
}
