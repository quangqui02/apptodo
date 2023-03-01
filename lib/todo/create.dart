//  import 'dart:html';

// import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/error/messageerror.dart';
import 'package:demoapp_todo/loading.dart';
import 'package:demoapp_todo/object/todo_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:text_area/text_area.dart';

import '../error/message.dart';

class Createpage extends StatefulWidget {
  Createpage({
    Key? key,
    required this.timecreate,
  }) : super(key: key);
  String? timecreate;
  @override
  State<Createpage> createState() => _CreatepageState();
}

class _CreatepageState extends State<Createpage> {
  var userRef = FirebaseFirestore.instance.collection("category");

// Retrieve all documents from the collection
  Future catelist() async {
    userRef.get().then((QuerySnapshot querySnapshot) {
      // let userList = [];
      querySnapshot.docs.forEach((doc) {
        //  userList.push(doc.data());
      });
      // let userList = [];
      // // Loop through each document and add it to the list
      // querySnapshot.forEach(doc => {
      //     userList.push(doc.data());
      // });
      // // Now do something with the list
    });
  }

  static DateTime _dateTime = DateTime.now();

  List<String> list = <String>['Gia Đình', 'Công Việc', 'Riêng Tư'];
  String? catagories;
  TextEditingController todocontent = TextEditingController();
  bool status = false;
  String img = '';
  DateTime createcontent = DateTime.now();
  DateTime timeimage = DateTime.now();
  final _user = FirebaseAuth.instance.currentUser!.uid;
  String imageUrl = '';
  String uid_user = '';
  File? _image;
  final imagepicker = ImagePicker();
  bool noimg = false;
  final _auth = FirebaseAuth.instance.currentUser!;
  String? startcontent;
  void initState() {
    super.initState();
    uid_user = _auth.uid;
    if (this.widget.timecreate != null) {
      startcontent = this.widget.timecreate!.substring(0, 10);
    } else {
      startcontent = DateTime.now().toString().substring(0, 10);
    }
  }

  PickedFile? image;
  getimg() async {
    image = await imagepicker.getImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image!.path);
      });
    }
  }

  postimg() async {
    DateTime timeimage = DateTime.now();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child(_user);
    Reference referenceImageToUpload =
        referenceDirImages.child(timeimage.toString());
    try {
      await referenceImageToUpload.putFile(File(image!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      // img = imageUrl.toString();
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(184, 255, 255, 255),
        title: Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Text(
              'Tạo Ghi Chú',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(children: [
            Lottie.asset('assets/note.json', height: 150),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 210),
              child: Text(
                'Ghi Chú',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: todocontent,
                        decoration: InputDecoration(
                          filled: true,
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Hãy nhập nội dung cần ghi chú',
                          hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        style: TextStyle(color: Colors.black),
                        maxLines: 5,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.068,
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
                      child: Text(
                        '$e',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    catagories = value;
                  });
                },
                hint: Center(
                  child: const Text(
                    'Hãy Lưu Nó Vào....',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.068,
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () async {
                          getimg();
                          // final image = await imagepicker.getImage(
                          //     source: ImageSource.camera);
                          // if (image != null) {
                          //   setState(() {
                          //     _image = File(image!.path);
                          //   });
                          // }
                          // DateTime timeimage = DateTime.now();
                          // Reference referenceRoot =
                          //     FirebaseStorage.instance.ref();
                          // Reference referenceDirImages =
                          //     referenceRoot.child(_user);
                          // Reference referenceImageToUpload =
                          //     referenceDirImages.child(timeimage.toString());
                          // try {
                          //   await referenceImageToUpload
                          //       .putFile(File(image!.path));
                          //   imageUrl =
                          //       await referenceImageToUpload.getDownloadURL();
                          //   img = imageUrl.toString();
                          // } catch (error) {}
                        },
                        child: Image(
                          image: AssetImage('assets/camera.png'),
                          // width: MediaQuery.of(context).size.width*0.1,
                          height: MediaQuery.of(context).size.height * 0.05,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 190,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        _showDatePicker();
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                              image: AssetImage('assets/lich.png'),
                              width: 40,
                              height: 40,
                            ),
                            Text(
                              startcontent!.substring(0, 10),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _image == null
                ? Text(
                    '',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  )
                : Image.file(
                    _image!,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () async {
                    if (startcontent == '') {
                      startcontent = DateFormat('yyyy-MM-dd').format(_dateTime);
                    }
                    if (catagories == null) {
                      catagories = 'Riêng Tư';
                    }
                    if (image != null) {
                      postimg();
                      noimg = true;
                    }
                    // if (noimg == true) {
                    //   if (imageUrl == '') {
                    //     setState(() {
                    //       showDialog(
                    //           context: context,
                    //           builder: (context) => MessageErrorTime(
                    //                 text: 'Xin Hãy Đợi 3 Giây',
                    //               ));
                    //     });
                    //   } else {
                    //     if (todocontent.text.isNotEmpty) {
                    //       await TodoProvider().createlisttodo(
                    //         todocontent.text.toString(),
                    //         createcontent.toString(),
                    //         catagories.toString(),
                    //         imageUrl.toString(),
                    //         startcontent.toString(),
                    //         uid_user.toString(),
                    //       );
                    //       Navigator.pop(context);
                    //       setState(() {
                    //         showDialog(
                    //             context: context,
                    //             builder: (context) => MessageTime());
                    //       });
                    //     }
                    //   }
                    // } else {
                    if (todocontent.text.isNotEmpty) {
                      await TodoProvider().createlisttodo(
                        todocontent.text.toString(),
                        createcontent.toString(),
                        catagories.toString(),
                        imageUrl.toString(),
                        startcontent.toString(),
                        uid_user.toString(),
                      );
                      Navigator.pop(context);
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) => MessageTime());
                      });
                    }
                    // }

                    // errorSnackBar(
                    //   context,
                    //   'Thêm Ghi Chú Thành Công',
                    // );
                  },
                  child: Text(
                    'Tạo Ghi Chú',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            ),
          ]),
        ],
      ),
    );
  }

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
          startcontent = DateFormat('yyyy-MM-dd').format(_dateTime);
          // dateTimeText = _dateTime(date);
        });
      }
    });
  }
}
