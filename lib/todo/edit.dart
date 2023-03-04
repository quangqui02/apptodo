import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/error/message.dart';
import 'package:demoapp_todo/object/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'catetodo.dart';

class EditTodo extends StatefulWidget {
  EditTodo({
    Key? key,
    required this.content,
    required this.uid,
    required this.start,
    required this.category,
  }) : super(key: key);

  String content;
  String uid;
  String category;

  String start;

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  Cate? cate;
  final _user = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController updatecontent = TextEditingController();
  static DateTime _dateTime = DateTime.now();
  String startcontent = DateFormat('yyyy-MM-dd').format(_dateTime);
  String _picture = 'todo.png';
  final imagepicker = ImagePicker();
  DateTime _date = DateTime.now();
  String imageUrl = '';
  String img = '';
  File? _image;
  String updateList = '';
  String uid_todo = '';
  List<String> list = <String>['Gia Đình', 'Công Việc', 'Riêng Tư'];
  String? catagories;
  bool stick = false;
  String? starttime;
  @override
  void initState() {
    starttime = this.widget.start;
    updatecontent.text = this.widget.content;
    catagories = this.widget.category;
    if (this.widget.start != _dateTime.toString().substring(0, 10)) {
      startcontent = this.widget.start;
    }
    getcate();
    super.initState();
  }

  Future<dynamic> getcate() async {
    FirebaseFirestore.instance
        .collection('category')
        .doc(catagories)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          namecate = snapshot.data()!['name'];
          iconcate = snapshot.data()!['icon'];
        });
      }
    });
  }

  Future<void> updatetodo(uid_todo) {
    return todo
        .doc(uid_todo)
        .update({'content': updateList})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updatetime(uid_todo, String time) {
    return todo
        .doc(uid_todo)
        .update({'startcontent': time})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updatestatus(uid_todo, bool tt) {
    return todo
        .doc(uid_todo)
        .update({'status': !tt})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updatecategory(uid_todo, dm) {
    return todo
        .doc(uid_todo)
        .update({'category': dm})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // Future<void> updateimg(uid_todo, String anh) {
  //   return todo
  //       .doc(uid_todo)
  //       .update({'img': anh})
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }

  String? iconcate;
  String? namecate;
  _navigator(BuildContext context) async {
    dynamic result =
        await showDialog(context: context, builder: (context) => CateTodo());
    if (result != null) {
      setState(() {
        cate = result;
        catagories = cate!.id;
        iconcate = cate!.icon;
        namecate = cate!.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ListView(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30, top: 100),
                  child: Container(
                      width: 300,
                      height: 400,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Center(
                            child: Text(
                              'Chỉnh Sửa',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10)),
                                width: 250,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: updatecontent,
                                      decoration: InputDecoration(
                                        filled: true,
                                        border: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        hintText:
                                            'Hãy nhập nội dung cần ghi chú',
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      maxLines: 5,
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height:
                                  MediaQuery.of(context).size.height * 0.068,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    iconcate == null
                                        ? const Image(
                                            image: AssetImage(
                                                'assets/catetodo.png'),
                                            width: 40,
                                            height: 40,
                                          )
                                        : Image(
                                            image: AssetImage('assets/' +
                                                iconcate.toString()),
                                            width: 40,
                                            height: 40,
                                          ),
                                    namecate == null
                                        ? const Text(
                                            'Chọn Danh Mục',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )
                                        : Text(
                                            namecate.toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                  ],
                                ),
                                onPressed: () {
                                  _navigator(context);
                                },
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: size.height * 0.07,
                            width: size.width * 0.7,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {
                                _showDatePicker();
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Image(
                                      image: AssetImage('assets/lich.png'),
                                      width: 40,
                                      height: 40,
                                    ),
                                    Text(
                                      startcontent,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.blue),
                                    ),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _image == null
                              ? const Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )
                              : Image.file(
                                  _image!,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextButton(
                                      onPressed: () {
                                        updateList = updatecontent.text;

                                        // if (imageUrl != '') {
                                        //   updateimg(this.widget.uid, imageUrl);
                                        // }
                                        if (updateList != '') {
                                          updatetodo(this.widget.uid);
                                        }
                                        if (catagories != null) {
                                          updatecategory(
                                              this.widget.uid, catagories!);
                                        }
                                        if (starttime != startcontent) {
                                          updatetime(
                                              this.widget.uid, startcontent);
                                        }

                                        Navigator.pop(context);
                                        updatecontent.clear();
                                        // errorSnackBar(
                                        //   context,
                                        //   'Thay Đổi Ghi Chú Thành Công',
                                        // );
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                MessageTime());
                                      },
                                      child: const Text(
                                        'Thay Đổi',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )),
                                ),
                              ),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Hủy',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                              )
                            ],
                          )
                        ],
                      )),
                )
              ],
            ),
          ],
        ));
  }

  final CollectionReference todo =
      FirebaseFirestore.instance.collection('listtodo');

  void _showDatePicker() {
    showDatePicker(
            builder: (context, child) {
              return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        onSurface: Color.fromARGB(255, 0, 0, 0),
                        onBackground: Colors.white),
                  ),
                  child: child!);
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2040))
        .then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
          startcontent = _dateTime.toString().substring(0, 10);
          // dateTimeText = _dateTime(date);
        });
      }
    });
  }
}
