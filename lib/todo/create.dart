//  import 'dart:html';

// import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/error/messageerror.dart';
import 'package:demoapp_todo/hometodo.dart';
import 'package:demoapp_todo/loading.dart';
import 'package:demoapp_todo/object/category.dart';
import 'package:demoapp_todo/object/todo_provider.dart';
import 'package:demoapp_todo/todo/catetodo.dart';
import 'package:demoapp_todo/todo/listcate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
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
    required this.cate,
  }) : super(key: key);
  String? timecreate;
  Cate? cate;

  @override
  State<Createpage> createState() => _CreatepageState();
}

class _CreatepageState extends State<Createpage> {
  var userRef = FirebaseFirestore.instance.collection("category");

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

  // Future<dynamic> getuser() async {
  //   final img = FirebaseFirestore.instance.collection('listtodo').doc().id;
  // }

  _navigator(BuildContext context) async {
    dynamic result =
        await showDialog(context: context, builder: (context) => CateTodo());
    // dynamic result=await Navigator.push(context,MaterialPageRoute(builder: (context) => CateTodo(),));
    if (result != null) {
      setState(() {
        this.widget.cate = result;
      });
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

  postimg(imgid) async {
    DateTime timeimage = DateTime.now();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child(_user);
    Reference referenceImageToUpload = referenceDirImages.child(imgid);
    try {
      await referenceImageToUpload.putFile(File(image!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
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
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      this.widget.cate == null
                          ? Image(
                              image: AssetImage('assets/catetodo.png'),
                              width: 40,
                              height: 40,
                            )
                          : Image(
                              image: AssetImage('assets/' +
                                  this.widget.cate!.icon.toString()),
                              width: 40,
                              height: 40,
                            ),
                      this.widget.cate == null
                          ? Text(
                              'Chọn Danh Mục',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          : Text(
                              this.widget.cate!.name.toString(),
                              style: TextStyle(
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
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.085,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  _showDatePicker();
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image: AssetImage('assets/lich.png'),
                        width: 40,
                        height: 40,
                      ),
                      Text(
                        startcontent!.substring(0, 10),
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            // _image == null
            //     ? Text(
            //         '',
            //         style: TextStyle(color: Colors.black, fontSize: 15),
            //       )
            //     : Image.file(
            //         _image!,
            //         width: MediaQuery.of(context).size.width * 0.7,
            //         height: MediaQuery.of(context).size.height * 0.3,
            //       ),
            // SizedBox(
            //   height: 5,
            // ),
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
                    // if (catagories == null) {
                    //   catagories = 'Riêng Tư';
                    // }
                    // if (image != null) {
                    //   postimg();
                    //   noimg = true;
                    // }
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

                    // final img = await FirebaseFirestore.instance
                    //     .collection('listtodo')
                    //     .doc()
                    //     .id;
                    // postimg(img);
                    if (todocontent.text.isNotEmpty &&
                        this.widget.cate!.id != null) {
                      await TodoProvider().createlisttodo(
                          todocontent.text.toString(),
                          createcontent.toString(),
                          this.widget.cate!.id.toString(),
                          // img.toString(),
                          startcontent.toString(),
                          uid_user.toString());
                      Navigator.pop(context);
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) => MessageTime());
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => MessageErrorTime(
                                text: 'Nhập Đủ Thông Tin',
                              ));
                    }
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
