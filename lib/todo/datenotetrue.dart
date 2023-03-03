import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/loading.dart';
import 'package:demoapp_todo/object/todo.dart';
import 'package:demoapp_todo/object/todo_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'detail.dart';
import 'edit.dart';

class DateNoteT extends StatefulWidget {
  DateNoteT({Key? key, required this.timenote}) : super(key: key);
  String? timenote;

  @override
  State<DateNoteT> createState() => _DateNoteTState();
}

class _DateNoteTState extends State<DateNoteT> {
  TextEditingController updatecontent = TextEditingController();

  final CollectionReference todo =
      FirebaseFirestore.instance.collection('listtodo');
  // String? urlimg;
  // final _user = FirebaseAuth.instance.currentUser!.uid;
  // void getdownurl(uid, imgurl) async {
  //   final storageRef = FirebaseStorage.instance.ref();
  //   final imageRef = storageRef.child('$_user/$imgurl');

  //   imageRef.getDownloadURL().then((url) => {urlimg = url});
  // }

  String updateList = '';
  String uid_todo = '';
  Future<void> updatetodo(uid_todo) {
    return todo
        .doc(uid_todo)
        .update({'content': updateList})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  String? namecate = '';

  Future<dynamic> getcate(uid) async {
    await FirebaseFirestore.instance
        .collection('category')
        .doc("$uid")
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          namecate = snapshot.data()!['name'];
        });
      }
    });
  }

  final accid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<List<Todo>>(
            stream: TodoProvider().listtododatenotT(this.widget.timenote),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Loading();
              }
              List<Todo>? todos = snapshot.data;
              return Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: size.height * 1 - 230,
                    child: ListView.builder(
                        itemCount: todos!.length,
                        itemBuilder: (BuildContext context, int index) {
                          // getdownurl(todos[index].uid, todos[index].img);
                          return Slidable(
                              key: Key(todos[index].content!),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) =>
                                        {deletetodo(context, todos[index].uid)},
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
                                                start:
                                                    todos[index].startcontent!,
                                                uid: todos[index].uid!,
                                                content: todos[index].content!,
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
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    leading: Image(
                                        image: AssetImage('assets/todo.png')),
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
                                    subtitle: Text(
                                      todos[index].startcontent!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    trailing: IconButton(
                                        icon: Icon(
                                          Icons.more_vert_rounded,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          // getcate(todos[index].category);
                                          // getdownurl(todos[index].uid,
                                          // todos[index].img);
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
                                        }),
                                  )));
                        }),
                  ),
                ],
              );
            }),
      ),
    );
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
}

// class DetailTodo extends StatefulWidget {
//   DetailTodo(
//       {Key? key,
//       required this.status,
//       required this.content,
//       required this.uid,
//       required this.category,
//       required this.img,
//       required this.start,
//       required this.create})
//       : super(key: key);
//   bool status;
//   String content;
//   String uid;
//   String category;
//   String img;
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

//   bool chang = true;
//   bool stick = false;
//   @override
//   void initState() {
//     stick = this.widget.status;
//     super.initState();
//   }

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
//                     width: 300,
//                     height: 420,
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
//                           child: Container(
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: size.width * 0.35,
//                                   height: size.height * 0.2,
//                                   decoration: BoxDecoration(
//                                       color: Color.fromARGB(255, 119, 116, 116),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Center(
//                                     child: SingleChildScrollView(
//                                       child: Text(
//                                         '${this.widget.content}',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: 20,
//                                             color: Color.fromARGB(
//                                                 255, 255, 255, 255)),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Container(
//                                   width: size.width * 0.38,
//                                   height: size.height * 0.2,
//                                   child: this.widget.img == ''
//                                       ? Image(
//                                           image: AssetImage('assets/todo.png'))
//                                       : Image.network(
//                                           '${this.widget.img}',
//                                           width: 70,
//                                           height: 70,
//                                         ),
//                                 )
//                               ],
//                             ),
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
//                                 'Danh Mục:',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 '${this.widget.category}',
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
//                                     // print(stick);
//                                     // stick = !stick;
//                                     // print(stick);
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
