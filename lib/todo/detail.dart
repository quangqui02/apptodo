import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailTodo extends StatefulWidget {
  DetailTodo(
      {Key? key,
      required this.status,
      required this.content,
      required this.uid,
      // required this.category,
      // required this.img,
      required this.start,
      required this.create})
      : super(key: key);
  bool status;
  String content;
  String uid;
  // String category;
  // String img;
  String start;
  String create;
  @override
  State<DetailTodo> createState() => _DetailTodoState();
}

class _DetailTodoState extends State<DetailTodo> {
  void en() {
    print(stick);
    stick = !stick;
    print(stick);
    setState(() {});
  }

  bool chang = true;

  bool stick = false;
  @override
  void initState() {
    stick = this.widget.status;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 30, top: 80),
                child: Container(
                    width: 300,
                    height: 420,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            'Thông Tin',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * 0.72,
                                  height: size.height * 0.2,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 119, 116, 116),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        '${this.widget.content}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                'Ngày tạo:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${this.widget.create.toString().substring(0, 11)}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                'Ngày ghi chú:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${this.widget.start}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                'Trạng Thái',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    // print(stick);
                                    // stick = !stick;
                                    // print(stick);
                                    setState(() {
                                      if (chang == true) {
                                        chang = false;
                                        updatestatus(this.widget.uid,
                                            this.widget.status);
                                        en();
                                        setState(() {});
                                      }
                                    });
                                  },
                                  child: stick
                                      ? Row(children: [
                                          (Text(
                                            'Đã Hoàn Thành',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          Icon(
                                            Icons.check_circle_outlined,
                                            color: Colors.green,
                                          )
                                        ])
                                      : Row(
                                          children: [
                                            (Text(
                                              'Chưa Hoàn Thành',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Icon(
                                              Icons.circle_outlined,
                                              color: Colors.green,
                                            )
                                          ],
                                        ))
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
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
                                  'Ok',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white),
                                ))),
                      ],
                    )))
          ],
        ));
  }

  final CollectionReference todo =
      FirebaseFirestore.instance.collection('listtodo');
  Future<void> updatestatus(uid_todo, bool tt) {
    return todo
        .doc(uid_todo)
        .update({'status': !tt})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
