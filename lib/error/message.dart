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

  @override
  State<MessageTime> createState() => _EditTodoState();
}

class _EditTodoState extends State<MessageTime> {
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
