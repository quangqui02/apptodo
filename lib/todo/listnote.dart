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

class TodoPage extends StatefulWidget {
  TodoPage({Key? key, required this.cate}) : super(key: key);
  String? cate;
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  String _picture = 'todo.png';
  TextEditingController updatecontent = TextEditingController();
  final _user = FirebaseAuth.instance.currentUser!.uid;

  Future<String> getdownurl(uid, imgurl) async {
    String urlimg = '';
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('$_user/$imgurl');
    imageRef.getDownloadURL().then((url) => {urlimg = url});
    print(urlimg);
    return urlimg;
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
  // late bool ischecked;
  // void chang() {
  //   setState(() {
  //     ischecked = !ischecked;
  //   });
  // }

  final CollectionReference todo =
      FirebaseFirestore.instance.collection('listtodo');

  String updateList = '';
  String uid_todo = '';
  Future<void> updatetodo(uid_todo) {
    return todo
        .doc(uid_todo)
        .update({'content': updateList})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  final accid = FirebaseAuth.instance.currentUser?.uid;
  // FirebaseFirestore _db = FirebaseFirestore.instance;
  // Stream<List<Todo>> getTodo() {
  //   return _db
  //       .collection('listtodo')
  //       .where('uid_user', isEqualTo: accid)
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList());
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<List<Todo>>(
            stream: TodoProvider().listTodofalse(),
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
                    height: size.height * 1 - 255,
                    child: ListView.builder(
                        itemCount: todos!.length,
                        itemBuilder: (BuildContext context, int index) {
                          // getdownurl(todos[index].uid, todos[index].img);
                          // todos[index].img = urlimg;
                          // todos[index].img =
                          //     getdownurl(todos[index].uid, todos[index].img)
                          //         as String?;
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
                                      left: 20, right: 20, bottom: 5),
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

                                          showDialog(
                                              context: context,
                                              builder: (context) => DetailTodo(
                                                  status: todos[index].status!,
                                                  content:
                                                      todos[index].content!,
                                                  uid: todos[index].uid!,
                                                  // category: namecate!,
                                                  // img: todos[index].img!,
                                                  start: todos[index]
                                                      .startcontent!,
                                                  create: todos[index]
                                                      .content_create_time!));
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
