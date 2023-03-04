import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/error/message.dart';
import 'package:demoapp_todo/todo/createcate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../loading.dart';
import '../object/cate_provider.dart';
import '../object/category.dart';
import 'create.dart';

class CateTodo extends StatefulWidget {
  @override
  State<CateTodo> createState() => _CateTodoState();
}

class _CateTodoState extends State<CateTodo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Color.fromARGB(0, 255, 255, 255),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 35, top: 70),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              height: size.height * 0.6,
              width: size.width * 0.8,
              child: Column(
                children: [
                  Container(
                    width: size.width * 1,
                    height: size.height * 0.06,
                    color: Colors.black12,
                    child: Center(
                      child: Text(
                        'Chọn Danh Mục',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height * 0.4,
                    width: size.width * 0.75,
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
                                return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Image(
                                              image: AssetImage('assets/' +
                                                  cates[index].icon!),
                                              width: 50,
                                              height: 50,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              cates[index].name!,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                      onPressed: () {
                                        Navigator.pop(context, cates[index]);
                                      },
                                    ));
                              });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: size.width * 0.32,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                  image: AssetImage('assets/close.png'),
                                  width: 40,
                                  height: 40,
                                ),
                                Text(
                                  'Hủy',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                      Container(
                          width: size.width * 0.32,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                  image: AssetImage('assets/addcate.png'),
                                  width: 40,
                                  height: 40,
                                ),
                                Text(
                                  'Thêm',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateCate()));
                            },
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
