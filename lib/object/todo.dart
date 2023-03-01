import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String? uid;
  String? content;
  String? content_create_time;
  String? category;
  String? img;
  String? startcontent;
  String? uid_user;
  bool? status;

  Todo({
    this.uid,
    this.content,
    this.content_create_time,
    this.category,
    this.img,
    this.startcontent,
    this.uid_user,
    this.status,
  });

  factory Todo.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Todo(
        uid: data["uid"],
        content: data["content"],
        content_create_time: data["content-create-time"],
        category: data["category"],
        img: data["img"],
        startcontent: data["startcontent"],
        status: data["status"],
        uid_user: data["uid_user"]);
  }
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        uid: json["uid"],
        content: json["content"],
        content_create_time: json["content-create-time"],
        category: json["category"],
        img: json["img"],
        startcontent: json["startcontent"],
        status: json["status"],
        uid_user: json["uid_user"]);
  }
  Map<String, dynamic> toMap() => {
        'uid': uid,
        'content': content,
        'content-create-time': content_create_time,
        'category': category,
        'img': img,
        'startcontent': startcontent,
        'uid_user': uid_user,
        'status': status,
      };
}
