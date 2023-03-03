import 'package:demoapp_todo/object/cate_provider.dart';
import 'package:demoapp_todo/object/category.dart';
import 'package:demoapp_todo/todo/create.dart';
import 'package:demoapp_todo/todo/createcate.dart';
import 'package:demoapp_todo/todo/editcate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lottie/lottie.dart';

import '../error/message.dart';
import '../loading.dart';
import '../object/todo.dart';
import '../object/todo_provider.dart';

class ListCate extends StatefulWidget {
  ListCate({super.key});

  @override
  State<ListCate> createState() => _ListCateState();
}

class _ListCateState extends State<ListCate> {
  TextEditingController name_cate = TextEditingController();
  final _auth = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Row(
          children: [
            SizedBox(
              width: size.width * 0.27,
            ),
            const Text(
              'Danh Mục',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(children: [
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            height: size.height * 0.69,
            child: StreamBuilder(
                stream: CateProvider().Catetodo(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Loading();
                  }
                  List<Cate>? cates = snapshot.data;
                  return ListView.builder(
                      itemCount: cates!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (context) =>
                                      {deletecate(context, cates[index].id)},
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
                                    showDialog(
                                        context: context,
                                        builder: (context) => EditCate(
                                              cate: cates[index],
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
                              height: size.height * 0.1,
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/' + cates[index].icon!),
                                      width: 60,
                                      height: 60,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      cates[index].name!,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            ));
                      });
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  width: size.width * 0.45,
                  height: size.height * 0.065,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 2)],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateCate()));
                    },
                    child: Row(children: const [
                      Image(
                        image: AssetImage('assets/cateadd.png'),
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Danh Mục',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ]),
                  )),
            ),
          ),
        ]),
      ),
    );
  }

  deletecate(BuildContext context, id) {
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
                      child: const Text(
                        'Bạn Có Muốn Xóa Danh Mục?',
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
                                child: const Text(
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
                                  await CateProvider().delelecate(id);
                                  Navigator.pop(context);
                                },
                                child: const Text(
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
