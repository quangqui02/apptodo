import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/error/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditTodo extends StatefulWidget {
  EditTodo({
    Key? key,
    required this.content,
    required this.uid,
    required this.category,
    required this.start,
  }) : super(key: key);
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
  String content;
  String uid;
  String category;
  // String img;
  String start;
  // String create;

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
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
    super.initState();
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

  Future<void> updatecategory(uid_todo, String dm) {
    return todo
        .doc(uid_todo)
        .update({'category': dm})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateimg(uid_todo, String anh) {
    return todo
        .doc(uid_todo)
        .update({'img': anh})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
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
                      height: _image == null ? 400 : 570,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              'Chỉnh Sửa',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
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
                                            borderSide: BorderSide(
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
                                      style: TextStyle(color: Colors.black),
                                      maxLines: 5,
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: catagories,
                                items: list.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Center(
                                        child:
                                            // catagories != null
                                            //     ? Text(
                                            //         catagories!,
                                            //         textAlign: TextAlign.center,
                                            //       )
                                            //     :
                                            Text(
                                      '$e',
                                      textAlign: TextAlign.center,
                                    )),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    catagories = value;
                                  });
                                },
                                hint: Center(
                                  child: const Text(
                                    'Danh Mục',
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextButton(
                                      onPressed: () async {
                                        final image =
                                            await imagepicker.getImage(
                                                source: ImageSource.camera);
                                        setState(() {
                                          _image = File(image!.path);
                                        });
                                        DateTime timeimage = DateTime.now();
                                        Reference referenceRoot =
                                            FirebaseStorage.instance.ref();
                                        Reference referenceDirImages =
                                            referenceRoot.child(_user);
                                        Reference referenceImageToUpload =
                                            referenceDirImages
                                                .child(timeimage.toString());
                                        try {
                                          await referenceImageToUpload
                                              .putFile(File(image!.path));
                                          imageUrl =
                                              await referenceImageToUpload
                                                  .getDownloadURL();
                                        } catch (error) {}
                                        img = imageUrl.toString();
                                      },
                                      child: Image(
                                        image: AssetImage('assets/camera.png'),
                                        width: 50,
                                        height: 40,
                                      )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 50,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextButton(
                                    onPressed: () {
                                      _showDatePicker();
                                    },
                                    child: Row(children: [
                                      Image(
                                        image: AssetImage('assets/lich.png'),
                                        width: 40,
                                        height: 40,
                                      ),
                                      Text(
                                        startcontent,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.blue),
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          _image == null
                              ? Text(
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
                          SizedBox(
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

                                        if (img != '') {
                                          updateimg(this.widget.uid, img);
                                        }
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
                                      child: Text(
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
                                    child: Text(
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
                    colorScheme: ColorScheme.light(
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
