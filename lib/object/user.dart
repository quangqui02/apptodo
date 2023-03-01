import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  String? id;
  String? name;
  String? email;
  String? password;

  Users({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  // factory Users.fromMap(map) {
  //   return Users(
  //       id: map['id'],
  //       name: map['name'],
  //       email: map['email'],
  //       password: map['password']);
  // }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json["id"],
      email: json["email"],
      password: json["password"],
      name: json["name"],
    );
  }
  factory Users.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Users(
      id: data["id"],
      email: data["email"],
      password: data["password"],
      name: data["name"],
    );
  }
}
