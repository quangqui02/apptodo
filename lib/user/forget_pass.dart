import 'package:demoapp_todo/error/messageerror.dart';
import 'package:demoapp_todo/object/todo_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(0, 255, 255, 255),
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.only(top: 150, left: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            width: 320,
            height: 280,
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Quên Mật Khẩu',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 250,
                child: Text(
                  'Vui Lòng Nhập Email Để Có Thể Lấy Lại Mật Khẩu, Sau Đó Xác Nhận Mật Khẩu Thông Qua Email.',
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 107, 104, 104)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 55,
                child: Container(
                  width: 280,
                  child: Material(
                    elevation: 8,
                    shadowColor: Colors.black87,
                    color: Color.fromARGB(0, 250, 0, 0),
                    borderRadius: BorderRadius.circular(20),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        hintText: 'Nhập Email',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Hủy',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                        onPressed: () {
                          if (_email.text.isNotEmpty) {
                            TodoProvider().forgetpass(_email.text);
                            Navigator.pop(context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => MessageErrorTime(
                                      text: 'Nhập Đủ Thông Tin',
                                    ));
                          }
                        },
                        child: Text(
                          'Gửi',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              )
            ]),
          ),
        )
      ]),
    );
  }

  void signUp(String email) async {
    try {
      if (_email.text.isNotEmpty) {
        TodoProvider().forgetpass(_email.text);
        Navigator.pop(context);
      } else {
        showDialog(
            context: context,
            builder: (context) => MessageErrorTime(
                  text: 'Nhập Đủ Thông Tin',
                ));
      }
    } on FirebaseAuthException catch (error) {
      print(error);
      print(error.code);
      switch (error.code) {
        case "invalid-email":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Không Hợp Lệ',
                  ));
          break;
        case "unknown":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Nhập Đủ Thông Tin',
                  ));
          break;
        case "email-already-in-use":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Đã Đươc Sử Dụng',
                  ));
          break;
        case "user-not-found":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Không Tồn Tại',
                  ));
          break;
        case "user-disabled":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Email Vô Hiệu Hóa',
                  ));
          break;
        case "too-many-requests":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Quá Nhiều Yêu Cầu',
                  ));
          break;
        case "operation-not-allowed":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Tài Khoản Không Kích Hoạt',
                  ));
          break;
        case "weak-password":
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Mật Khẩu Trên 6 Ký Tự',
                  ));
          break;
        default:
          showDialog(
              context: context,
              builder: (context) => MessageErrorTime(
                    text: 'Lỗi Không Xác Định',
                  ));
          break;
      }
    }
  }
}
