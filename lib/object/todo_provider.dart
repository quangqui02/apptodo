import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/object/todo.dart';

import 'package:demoapp_todo/object/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'dart:convert';

import '../user/login_screen.dart';

class TodoProvider {
  CollectionReference usercollection =
      FirebaseFirestore.instance.collection('user');

  FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future deleleuser(uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference userReference = firestore.collection("user").doc(uid);

    userReference.delete();

    CollectionReference todoReference = firestore.collection("listtodo");

    todoReference.where("uid_user", isEqualTo: uid).get().then((querySnapshot) {
      querySnapshot.docs.forEach((documentSnapshot) {
        documentSnapshot.reference.delete();
      });
    });

    FirebaseAuth.instance.currentUser!.delete();
  }

  CollectionReference todocollection =
      FirebaseFirestore.instance.collection('listtodo');

  final todocreate = FirebaseFirestore.instance.collection('listtodo').doc();
  Future createlisttodo(
    String content,
    String content_create_time,
    String category,
    // String img,
    String startcontent,
    String uid_user,
  ) async {
    return await todocollection.add({
      "content": content,
      "content-create-time": content_create_time,
      "category": category,
      // "img": img,
      "startcontent": startcontent,
      "uid_user": uid_user,
      "status": false,
    });
  }

  Future updatepass(uid, pass) async {
    await FirebaseAuth.instance.currentUser!.updatePassword(pass);
  }

  String? newpassw;
  Future forgetpass(email) async {
    FirebaseAuth.instance
        .sendPasswordResetEmail(
          email: email,
        )
        .then((result) {});
  }

  Future removeTodo(uid) async {
    await todocollection.doc(uid).delete();
  }

  final accid = FirebaseAuth.instance.currentUser?.uid;

  List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Todo(
          uid: e.id,
          uid_user: (e.data() as dynamic)['uid_user'],
          status: (e.data() as dynamic)['status'],
          content: (e.data() as dynamic)['content'],
          content_create_time: (e.data() as dynamic)['content-create-time'],
          startcontent: (e.data() as dynamic)['startcontent'],
          // img: (e.data() as dynamic)['img'],
          category: (e.data() as dynamic)['category'],
        );
      }).toList();
    } else {
      return null!;
    }
  }

  final username = FirebaseFirestore.instance.collection('user');

  List<Users> userfrom(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Users(
        id: e.id,
        email: (e.data() as dynamic)['email'],
        password: (e.data() as dynamic)['password'],
        name: (e.data() as dynamic)['name'],
      );
    }).toList();
  }

  DateTime _date = DateTime.now();

  Stream<List<Todo>> listTododayfalse() {
    String startcontent = DateFormat('yyyy-MM-dd').format(_date);
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .where('startcontent', isEqualTo: startcontent)
        .where('status', isEqualTo: false)
        .snapshots()
        .map(todoFromFirestore);
  }

  Stream<List<Todo>> listtododatenotT(timenote) {
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .where('startcontent', isEqualTo: timenote)
        .where('status', isEqualTo: true)
        .snapshots()
        .map(todoFromFirestore);
  }

  Stream<List<Todo>> listtododatenotF(timenote) {
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .where('startcontent', isEqualTo: timenote)
        .where('status', isEqualTo: false)
        .snapshots()
        .map(todoFromFirestore);
  }

  Stream<List<Todo>> listtododatecateF(timenote, cate) {
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .where('startcontent', isEqualTo: timenote)
        .where('category', isEqualTo: cate)
        .where('status', isEqualTo: false)
        .snapshots()
        .map(todoFromFirestore);
  }

  Stream<List<Todo>> listtododatecateT(timenote, cate) {
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .where('startcontent', isEqualTo: timenote)
        .where('category', isEqualTo: cate)
        .where('status', isEqualTo: true)
        .snapshots()
        .map(todoFromFirestore);
  }

  Stream<List<Todo>> listTododaytrue() {
    String startcontent = DateFormat('yyyy-MM-dd').format(_date);
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .where('startcontent', isEqualTo: startcontent)
        .where('status', isEqualTo: true)
        .snapshots()
        .map(todoFromFirestore);
  }

  Stream<List<Todo>> listTodotrue() {
    String startcontent = DateFormat('yyyy-MM-dd').format(_date);
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .where('status', isEqualTo: true)
        .snapshots()
        .map(todoFromFirestore);
  }

  Stream<List<Todo>> listTodocatefalse(cate) {
    String startcontent = DateFormat('yyyy-MM-dd').format(_date);
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .where('category', isEqualTo: cate)
        .where('status', isEqualTo: false)
        .snapshots()
        .map(todoFromFirestore);
  }

  Stream<List<Todo>> listTodocatetrue(cate) {
    String startcontent = DateFormat('yyyy-MM-dd').format(_date);
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .where('category', isEqualTo: cate)
        .where('status', isEqualTo: true)
        .snapshots()
        .map(todoFromFirestore);
  }

  Stream<List<Todo>> listTodofalse() {
    String startcontent = DateFormat('yyyy-MM-dd').format(_date);
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .where('status', isEqualTo: false)
        .snapshots()
        .map(todoFromFirestore);
  }

  Stream<List<Todo>> listTodoall() {
    return todocollection
        .where('uid_user', isEqualTo: accid)
        .snapshots()
        .map(todoFromFirestore);
  }
}
