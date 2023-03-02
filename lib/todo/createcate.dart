import 'package:demoapp_todo/error/messageerror.dart';
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

class CreateCate extends StatefulWidget {
  CreateCate({super.key});

  @override
  State<CreateCate> createState() => _CreateCateState();
}

class _CreateCateState extends State<CreateCate> {
  List<String> listicon = <String>[
    'family.png',
    'love.png',
    'canhan.png',
    'working.png',
    'banbe.png',
    'ythuc.png'
  ];
  TextEditingController name_cate = TextEditingController();
  final _auth = FirebaseAuth.instance.currentUser!;
  String? icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Row(
          children: [
            SizedBox(
              width: size.width * 0.1,
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
                  maxLength: 20,
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
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      // isDense: tr,
                      // elevation: 20,
                      itemHeight: 100,
                      iconSize: 20,
                      value: icon,
                      items: listicon.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/' + '$e',
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          icon = value;
                        });
                      },
                      hint: Center(
                        child: const Text(
                          'Chọn Icon',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
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
                          icon.toString(),
                        );
                        setState(() {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => MessageTime());
                        });
                        name_cate.clear();
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => MessageErrorTime(
                                  text: 'Vui Lòng Nhập Tên Danh Mục',
                                ));
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
        ]),
      ),
    );
  }
}
