import 'package:cloud_firestore/cloud_firestore.dart';

class Cate {
  String? id;
  String? name;
  String? uid_user;

  Cate({
    this.id,
    this.name,
    this.uid_user
  });



  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'uid_user': uid_user,
        
      };
  factory Cate.fromJson(Map<String, dynamic> json) {
    return Cate(
      id: json["id"],
      name: json["name"],
        uid_user: json["uid_user"],
    );
  }
  factory Cate.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Cate(
      id: data["id"],
      name: data["name"],
       uid_user: data["uid_user"],
    );
  }
}
