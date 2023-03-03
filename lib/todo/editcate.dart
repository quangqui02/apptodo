import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/error/message.dart';
import 'package:demoapp_todo/object/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'catetodo.dart';

class EditCate extends StatefulWidget {
  EditCate({
    Key? key,
    required this.cate,
  }) : super(key: key);

  Cate? cate;

  @override
  State<EditCate> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditCate> {
  Cate? cate;
  TextEditingController namecate = TextEditingController();
  final CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  Future<void> updatenamecate(uid_cate, name) {
    return category
        .doc(uid_cate)
        .update({'name': name})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updatecateicon(uid_cate, icon) {
    return category
        .doc(uid_cate)
        .update({'icon': icon})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  String? iconimg;
  List<String> listicon = <String>[
    'family.png',
    'love.png',
    'canhan.png',
    'working.png',
    'banbe.png',
    'ythuc.png'
  ];

  String? noidungcate;

  @override
  void initState() {
    // TODO: implement initState
    iconimg = this.widget.cate!.icon;
    namecate.text = this.widget.cate!.name.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ListView(children: [
          Stack(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 30, top: 100),
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.45,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const Center(
                          child: Text(
                            'Chỉnh Sửa',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            width: size.width * 0.7,
                            height: size.height * 0.12,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: namecate,
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
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            // isDense: tr,
                            // elevation: 20,
                            itemHeight: 100,
                            iconSize: 20,
                            value: iconimg,
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
                                iconimg = value;
                              });
                            },
                            hint: iconimg == null
                                ? Center(
                                    child: const Text(
                                      'Chọn Icon',
                                    ),
                                  )
                                : Center(
                                    child: Image(
                                      image: AssetImage(
                                        'assets/' + '$iconimg',
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                    onPressed: () async {
                                      await updatecateicon(
                                          this.widget.cate!.id, iconimg);
                                      await updatenamecate(
                                          this.widget.cate!.id, namecate.text);
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) => MessageTime());
                                    },
                                    child: const Text(
                                      'Thay Đổi',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                              ),
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
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          )
        ]));
  }
}
