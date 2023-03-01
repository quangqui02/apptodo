import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/object/todo_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../error/message.dart';
import '../error/messageerror.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangPassState();
}

class _ChangPassState extends State<ChangePass> {
  TextEditingController _pass = TextEditingController();
  TextEditingController _newpass = TextEditingController();
  TextEditingController _renewpass = TextEditingController();
  bool show = false;
  void changeshow() {
    setState(() {
      show = !show;
    });
  }

  final user = FirebaseAuth.instance.currentUser!;

  final CollectionReference todo =
      FirebaseFirestore.instance.collection('user');
  Future<void> updateUser(uid, pass) {
    return todo
        .doc(uid)
        .update({'password': pass})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Text(
              'Đổi Mật Khẩu',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            )
          ],
        ),
      ),
      body: ListView(children: [
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
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
                    onChanged: (value) {},
                    obscureText: show,
                    controller: _pass,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      hintText: 'Mật Khẩu Hiện Tại',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
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
                    onChanged: (value) {},
                    obscureText: show,
                    controller: _newpass,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      hintText: 'Mật Khẩu Mới',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
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
                    onChanged: (value) {},
                    obscureText: show,
                    controller: _renewpass,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      hintText: 'Nhập Lại Mật Khẩu Mới',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200),
              child: Row(
                children: [
                  InkWell(
                    onTap: changeshow,
                    child: show
                        ? Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.check_box_outlined,
                            color: Colors.black,
                          ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.005,
                  ),
                  show
                      ? Text(
                          'Hiện Mật Khẩu',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        )
                      : Text(
                          'Ẩn Mật Khẩu',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  if (_pass.text.isNotEmpty &&
                      _newpass.text.isNotEmpty &&
                      _renewpass.text.isNotEmpty) {
                    if (_pass.text != _newpass.text) {
                      if (_newpass.text == _renewpass.text) {
                        TodoProvider().updatepass(user.uid, _newpass.text);
                        updateUser(user.uid, _newpass.text);
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => MessageTime());
                      } else if (_newpass.text != _renewpass.text) {
                        showDialog(
                            context: context,
                            builder: (context) => MessageErrorTime(
                                text: 'Nhập Lại Mật Khẩu Không Trùng'));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => MessageErrorTime(
                                text: 'Sai Mật Khẩu Hiện Tại'));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              MessageErrorTime(text: 'Trùng mật Khẩu Củ'));
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => MessageErrorTime(
                            text: 'Vui Lòng Nhập Đủ Thông Tin'));
                  }
                });
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
                  'Thay Đổi',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
