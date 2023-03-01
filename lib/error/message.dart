import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MessageTime extends StatefulWidget {
  MessageTime({super.key});
  // EditTodo(
  //     {Key? key,
  //     required this.status,
  //     required this.content,
  //     required this.uid,
  //     required this.category,
  //     required this.img,
  //     required this.start,
  //     required this.create})
  //     : super(key: key);
  // bool status;
  // String text;
  // String uid;
  // String category;
  // // String img;
  // String start;
  // String create;

  @override
  State<MessageTime> createState() => _EditTodoState();
}

class _EditTodoState extends State<MessageTime> {
  // final _user = FirebaseAuth.instance.currentUser!.uid;
  // TextEditingController updatecontent = TextEditingController();
  // static DateTime _dateTime = DateTime.now();
  // String _picture = 'todo.png';
  // final imagepicker = ImagePicker();
  // DateTime _date = DateTime.now();
  // String imageUrl = '';
  // String img = '';
  // File? _image;
  // String updateList = '';
  // String uid_todo = '';
  // List<String> list = <String>['Gia Đình', 'Công Việc', 'Riêng Tư'];
  // String? catagories;
  // bool stick = false;
  // String? starttime;
  @override
  void initState() {
    setState(() {
      poptime();
      setState(() {});
    });
    super.initState();
  }

  poptime() {
    setState(() {
      if (seconds > 0) {
        seconds--;
      }
      if (seconds == 0) {
        Navigator.pop(context);
      }
    });
  }

  int seconds = 5;
  // Timer? timer;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Color.fromARGB(0, 255, 255, 255),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 200, left: 50),
          child: Container(
            width: 250,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Lottie.asset('assets/stick.json', height: 100),
                  Container(
                    width: 100,
                    child: Text(
                      "Thành Công",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        'Đóng',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ))
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120, left: 100),
          child: Lottie.asset('assets/nofixanh.json', height: 150),
        ),
      ]),
    );
  }
}
