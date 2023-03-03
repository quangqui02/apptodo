import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/calendar.dart';
import 'package:demoapp_todo/loading.dart';
import 'package:demoapp_todo/object/category.dart';
import 'package:demoapp_todo/todo/detail.dart';
import 'package:demoapp_todo/user/login_screen.dart';
import 'package:demoapp_todo/main.dart';
import 'package:demoapp_todo/object/todo_provider.dart';
import 'package:demoapp_todo/user/setting.dart';
import 'package:demoapp_todo/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'object/todo.dart';
import 'todo/edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static DateTime _dateTime = DateTime.now();
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
  final accid = FirebaseAuth.instance.currentUser?.uid;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController updatecontent = TextEditingController();
  final CollectionReference todo =
      FirebaseFirestore.instance.collection('listtodo');

  // String? namecate = '';
  // Future<dynamic> getcate(uid) async {
  //   await FirebaseFirestore.instance
  //       .collection('category')
  //       .doc("$uid")
  //       .get()
  //       .then((snapshot) async {
  //     if (snapshot.exists) {
  //       setState(() {
  //         namecate = snapshot.data()!['name'];
  //       });
  //     }
  //   });
  // }

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
        .update({'stratcontent': time})
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
        .update({'categody': dm})
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

  // Future<List<ToDo>> list1() async {
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('listtodo')
  //       .where('uid-uesr', isEqualTo: _auth.uid)
  //       .get();
  //   final data1 = snapshot.docs.map((e) => Todo.fromSnapshot(e)).toList();
  //   return data1;
  // }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference _listtodo =
      FirebaseFirestore.instance.collection('user');
  String? urlimg;
  // void getdownurl(uid, imgurl) async {
  //   final storageRef = FirebaseStorage.instance.ref();
  //   final imageRef = storageRef.child('$_user/$imgurl');
  //   imageRef.getDownloadURL().then((url) => {urlimg = url});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
          title: Row(
            children: [
              SizedBox(
                width: size.width * 0.1,
              ),
              Text(
                'Ghi Chú',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ],
          ),
        ),
        drawer: SettingPage(),
        body: SafeArea(
          child: Container(
            width: size.width * 1,
            height: size.height * 1,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('assets/day.png'),
                          width: 60,
                          height: 60,
                        ),
                        Text(
                          'Công Việc Hôm Nay',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  // decoration: BoxDecoration(color: Colors.grey),
                  height: size.height * 0.4 - 63,
                  child: StreamBuilder(
                      stream: TodoProvider().listTododayfalse(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Loading();
                        }
                        List<Todo>? todos = snapshot.data;

                        return ListView.builder(
                            itemCount: todos!.length,
                            itemBuilder: (BuildContext context, int index) {
                              // getcate(todos[index].category);

                              return Slidable(
                                  key: Key(todos[index].content!),
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) => {
                                          deletetodo(context, todos[index].uid)
                                        },
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        flex: 1,
                                        onPressed: (context) => {
                                          updatecontent.text =
                                              todos[index].content!,
                                          uid_todo = todos[index].uid!,
                                          showDialog(
                                              context: context,
                                              builder: (context) => EditTodo(
                                                    start: todos[index]
                                                        .startcontent!,
                                                    uid: todos[index].uid!,
                                                    content:
                                                        todos[index].content!,
                                                    category:
                                                        todos[index].category!,
                                                  ))
                                        },
                                        backgroundColor: Color(0xFF7BC043),
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit_calendar_outlined,
                                        label: 'Chỉnh Sửa',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      leading: IconButton(
                                        icon: (todos[index].status!
                                            ? Icon(
                                                Icons.check_circle_outlined,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.circle_outlined,
                                                color: Colors.green,
                                              )),
                                        onPressed: () {
                                          setState(() {
                                            uid_todo = todos[index].uid!;
                                            updatestatus(
                                                uid_todo, todos[index].status!);
                                          });
                                        },
                                      ),
                                      title: todos[index].content!.length >= 15
                                          ? Text(
                                              todos[index]
                                                      .content!
                                                      .substring(0, 15) +
                                                  '...',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              todos[index].content!,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          // getcate(todos[index].category);
                                          // getdownurl(todos[index].uid,
                                          //     todos[index].img);
                                          // if (namecate != '') {
                                          showDialog(
                                              context: context,
                                              builder: (context) => DetailTodo(
                                                  status: todos[index].status!,
                                                  content:
                                                      todos[index].content!,
                                                  uid: todos[index].uid!,
                                                  // category: namecate!,
                                                  // img: urlimg!,
                                                  start: todos[index]
                                                      .startcontent!,
                                                  create: todos[index]
                                                      .content_create_time!));
                                          // }
                                        },
                                        icon: Icon(
                                          Icons.more_vert_rounded,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ));
                            });
                      }),
                ),
                SizedBox(
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/ok.png'),
                          width: 60,
                          height: 60,
                        ),
                        Text(
                          'Đã Hoàn Thành',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: size.height * 0.4 - 15,
                  child: StreamBuilder(
                      stream: TodoProvider().listTododaytrue(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Loading();
                        }
                        List<Todo>? todos = snapshot.data;
                        return ListView.builder(
                            itemCount: todos!.length,
                            itemBuilder: (BuildContext context, int index) {
                              // getcate(todos[index].category);

                              return Slidable(
                                  key: Key(todos[index].content!),
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) => {
                                          deletetodo(context, todos[index].uid)
                                        },
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        flex: 1,
                                        onPressed: (context) => {
                                          updatecontent.text =
                                              todos[index].content!,
                                          uid_todo = todos[index].uid!,
                                          showDialog(
                                              context: context,
                                              builder: (context) => EditTodo(
                                                    start: todos[index]
                                                        .startcontent!,
                                                    uid: todos[index].uid!,
                                                    content:
                                                        todos[index].content!,
                                                    category:
                                                        todos[index].category!,
                                                  ))
                                        },
                                        backgroundColor: Color(0xFF7BC043),
                                        foregroundColor: Colors.white,
                                        icon: Icons.archive,
                                        label: 'Chỉnh Sửa',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      leading: IconButton(
                                        icon: (todos[index].status!
                                            ? Icon(
                                                Icons.check_circle_outlined,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.circle_outlined,
                                                color: Colors.green,
                                              )),
                                        onPressed: () {
                                          setState(() {
                                            uid_todo = todos[index].uid!;
                                            updatestatus(
                                                uid_todo, todos[index].status!);
                                          });
                                        },
                                      ),
                                      title: todos[index].content!.length >= 15
                                          ? Text(
                                              todos[index]
                                                      .content!
                                                      .substring(0, 15) +
                                                  '...',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              todos[index].content!,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            // getcate(todos[index].category);
                                            // getdownurl(todos[index].uid,
                                            // todos[index].img);
                                            // if (namecate != null) {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    DetailTodo(
                                                        status: todos[index]
                                                            .status!,
                                                        content: todos[index]
                                                            .content!,
                                                        uid: todos[index].uid!,
                                                        // category: namecate!,
                                                        // img: urlimg!,
                                                        start: todos[index]
                                                            .startcontent!,
                                                        create: todos[index]
                                                            .content_create_time!));
                                            // }
                                          });

                                          // else {
                                          //   showDialog(
                                          //       context: context,
                                          //       builder: (context) => DetailTodo(
                                          //           status:
                                          //               todos[index].status!,
                                          //           content:
                                          //               todos[index].content!,
                                          //           uid: todos[index].uid!,
                                          //           category:
                                          //               todos[index].category!,
                                          //           img: todos[index].img!,
                                          //           start: todos[index]
                                          //               .startcontent!,
                                          //           create: todos[index]
                                          //               .content_create_time!));
                                          // }
                                        },
                                        icon: Icon(
                                          Icons.more_vert_rounded,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ));
                            });
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  deletetodo(BuildContext context, id) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //alignment: Alignment.center,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            actions: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        'Bạn Có Muốn Ghi Chú?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
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
                                onPressed: () async {
                                  await TodoProvider().removeTodo(id);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Đồng Ý',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                          ),
                        ]),
                  ],
                ),
              )
            ],
          );
        });
  }

  edittodo(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //alignment: Alignment.center,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          contentPadding: EdgeInsets.only(top: 10.0),
          actions: <Widget>[
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Container(
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
                        'Danh Mục',
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () async {
                          final image = await imagepicker.getImage(
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
                              referenceDirImages.child(timeimage.toString());
                          try {
                            await referenceImageToUpload
                                .putFile(File(image!.path));
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
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
                          _dateTime.toString().substring(0, 11),
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 150,
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
                        updateimg(uid_todo, img);
                      }
                      if (updateList != '') {
                        updatetodo(uid_todo);
                      }
                      if (catagories != null) {
                        updatecategory(uid_todo, catagories!);
                      }

                      Navigator.pop(context);
                      updatecontent.clear();
                      // errorSnackBar(
                      //   context,
                      //   'Thay Đổi Ghi Chú Thành Công',
                      // );
                    },
                    child: Text(
                      'Thay Đổi',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
            )
          ],
        );
      },
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
          // dateTimeText = _dateTime(date);
        });
      }
    });
  }
}

// class DetailTodo extends StatefulWidget {
//   DetailTodo(
//       {Key? key,
//       required this.status,
//       required this.content,
//       required this.uid,
//       // required this.category,
//       // required this.img,
//       required this.start,
//       required this.create})
//       : super(key: key);
//   bool status;
//   String content;
//   String uid;
//   // String category;
//   // String img;
//   String start;
//   String create;
//   @override
//   State<DetailTodo> createState() => _DetailTodoState();
// }

// class _DetailTodoState extends State<DetailTodo> {
//   void en() {
//     print(stick);
//     stick = !stick;
//     print(stick);
//     setState(() {});
//   }

//   bool stick = false;
//   @override
//   void initState() {
//     stick = this.widget.status;
//     super.initState();
//   }

//   bool chang = true;
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Material(
//         color: Color.fromARGB(0, 255, 255, 255),
//         child: Stack(
//           children: [
//             Padding(
//                 padding: const EdgeInsets.only(left: 30, top: 80),
//                 child: Container(
//                     width: size.width * 0.85,
//                     height: size.height * 0.6,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                     ),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Center(
//                           child: Text(
//                             'Thông Tin',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 25),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: size.width * 0.35,
//                                 height: size.height * 0.2,
//                                 decoration: BoxDecoration(
//                                     color: Color.fromARGB(255, 119, 116, 116),
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Center(
//                                   child: SingleChildScrollView(
//                                     child: Text(
//                                       '${this.widget.content}',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Color.fromARGB(
//                                               255, 255, 255, 255)),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // Container(
//                               //     width: size.width * 0.4,
//                               //     height: size.height * 0.2,
//                               //     child: Container(
//                               //       child: this.widget.img == ''
//                               //           ? Image(
//                               //               image:
//                               //                   AssetImage('assets/todo.png'),
//                               //             )
//                               //           : Image.network(
//                               //               '${this.widget.img}',
//                               //             ),
//                               //     )),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         // Padding(
//                         //   padding: const EdgeInsets.only(left: 20),
//                         //   child: Row(
//                         //     children: [
//                         //       Text(
//                         //         'Danh Mục:',
//                         //         style: TextStyle(
//                         //           color: Colors.black,
//                         //           fontSize: 15,
//                         //         ),
//                         //       ),
//                         //       SizedBox(
//                         //         width: 10,
//                         //       ),
//                         //       Text(
//                         //         '${this.widget.category}',
//                         //         style: TextStyle(
//                         //             color: Colors.black,
//                         //             fontSize: 20,
//                         //             fontWeight: FontWeight.bold),
//                         //       )
//                         //     ],
//                         //   ),
//                         // ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Row(
//                             children: [
//                               Text(
//                                 'Ngày tạo:',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 '${this.widget.create.toString().substring(0, 11)}',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Row(
//                             children: [
//                               Text(
//                                 'Ngày ghi chú:',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 '${this.widget.start}',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Row(
//                             children: [
//                               Text(
//                                 'Trạng Thái',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               TextButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       if (chang == true) {
//                                         chang = false;
//                                         updatestatus(this.widget.uid,
//                                             this.widget.status);
//                                         en();
//                                         setState(() {});
//                                       }
//                                     });
//                                   },
//                                   child: stick
//                                       ? Row(children: [
//                                           (Text(
//                                             'Đã Hoàn Thành',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold),
//                                           )),
//                                           Icon(
//                                             Icons.check_circle_outlined,
//                                             color: Colors.green,
//                                           )
//                                         ])
//                                       : Row(
//                                           children: [
//                                             (Text(
//                                               'Chưa Hoàn Thành',
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.bold),
//                                             )),
//                                             Icon(
//                                               Icons.circle_outlined,
//                                               color: Colors.green,
//                                             )
//                                           ],
//                                         ))
//                             ],
//                           ),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                                 alignment: Alignment.center,
//                                 width: 180,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: Colors.blue),
//                                 child: Text(
//                                   'Ok',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 25,
//                                       color: Colors.white),
//                                 ))),
//                       ],
//                     )))
//           ],
//         ));
//   }

//   final CollectionReference todo =
//       FirebaseFirestore.instance.collection('listtodo');
//   Future<void> updatestatus(uid_todo, bool tt) {
//     return todo
//         .doc(uid_todo)
//         .update({'status': !tt})
//         .then((value) => print("User Updated"))
//         .catchError((error) => print("Failed to update user: $error"));
//   }
// }
