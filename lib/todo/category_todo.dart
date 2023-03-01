import 'package:demoapp_todo/object/cate_provider.dart';
import 'package:demoapp_todo/object/category.dart';
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

class CategoryPage extends StatefulWidget {
  CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
            Text(
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
          Container(
              child: Column(
            children: [
              Center(
                  child: Lottie.asset('assets/cate.json',
                      height: size.height * 0.2)),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width * 0.8,
                height: size.height * 0.1,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: name_cate,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Nhập Danh Mục...',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
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
                      if (name_cate.text.isNotEmpty) {
                        await CateProvider().createcategory(
                          name_cate.text.toString(),
                          _auth.uid.toString(),
                        );
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (context) => MessageTime());
                        });
                        name_cate.clear();
                      }
                    },
                    child: Text(
                      'Tạo Danh Mục',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
            ],
          )),
          SizedBox(
            height: size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 65),
            child: Container(
              height: size.height * 0.05,
              width: size.width * 0.7,
              child: Text(
                'Tất cả Danh Mục',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            // decoration: BoxDecoration(color: Colors.grey),
            height: size.height * 0.4 - 63,
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
                                  onPressed: (context) => {},
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
                                  onPressed: (context) => {},
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
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  title: Center(
                                    child: Text(
                                      cates[index].name!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )));
                      });
                }),
          ),
        ]),
      ),
    );
  }
}
