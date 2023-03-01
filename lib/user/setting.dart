import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_light_button/dark_light_button.dart';
import 'package:demoapp_todo/user/changepass.dart';
import 'package:demoapp_todo/user/login_screen.dart';
import 'package:demoapp_todo/object/todo_provider.dart';
import 'package:demoapp_todo/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _user = FirebaseAuth.instance.currentUser!.email;

  String name = '';
  Future<dynamic> getuser() async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['name'];
        });
      }
    });
  }

  void initState() {
    super.initState();
    getuser();
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomePage()));
  }
  // void signout() async {
  //   try {
  //     await user.signOut();
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => WelcomePage()),
  //         (route) => false);
  //   } catch (e) {
  //     // errorSnackBar(context, "có lỗi xảy ra");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
        child: Column(children: [
      Center(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
            ),
            child: Image(
              image: AssetImage('assets/todo.png'),
              width: 150,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Lottie.asset('assets/baomat.json', height: 220),
          ),
        ]),
      ),
      Center(
        child: Text(
          'Xin Chào',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      Center(
        child: Text(
          name,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        color: Color.fromARGB(68, 204, 203, 199),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 200, top: 10),
              child: Text(
                'Tài Khoản',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  // Icon(
                  //   Icons.lock_outline_rounded,
                  //   size: 20,
                  // ),
                  Image(
                    image: AssetImage('assets/lockup.png'),
                    width: 25,
                    height: 25,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Đổi Mật Khẩu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePass()));
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Image(
                    image: AssetImage('assets/dangxuat.png'),
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Đăng Xuất',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                logout(context);
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Image(
                    image: AssetImage('assets/vohieuhoa.png'),
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Xóa Tài Khoản',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              onPressed: () => deleteUserTodo(context),
            ),
          ],
        ),
      ),
    ]));
  }

  deleteUserTodo(BuildContext context) {
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
                    child: Text(
                      'Bạn Có Muốn Xóa Tài Khoản?',
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
                              child: Text(
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
                                await TodoProvider().deleleuser(user.uid);
                                // await TodoProvider().deleteuseraccount(user.email!,user.uid);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomePage()),
                                    (route) => false);
                              },
                              child: Text(
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
      },
    );
  }
}
