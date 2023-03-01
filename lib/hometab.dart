import 'package:demoapp_todo/calendar.dart';
import 'package:demoapp_todo/hometodo.dart';
import 'package:demoapp_todo/todo/create.dart';
import 'package:demoapp_todo/todo/listcate.dart';
import 'package:demoapp_todo/user/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'todo/tab_listtodo.dart';

class Hometab extends StatefulWidget {
  const Hometab({super.key});

  @override
  State<Hometab> createState() => _HometabState();
}

class _HometabState extends State<Hometab> {
  final List<Widget> lsScreen = [
    HomePage(),
    TabTodo(),
    ListCate(),
    CalendarPage(),
  ];
  int currenttab = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),

      floatingActionButton: currenttab != 3
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.add,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Createpage(
                              timecreate: null,
                              cate: null,
                            )));
              },
            )
          : Container(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = HomePage();
                    currenttab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home_outlined,
                        color: currenttab == 0 ? Colors.blue : Colors.grey),
                    Text(
                      'Trang Chủ',
                      style: TextStyle(
                          color: currenttab == 0 ? Colors.blue : Colors.grey),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = TabTodo();
                    currenttab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.note_add_outlined,
                        color: currenttab == 1 ? Colors.blue : Colors.grey),
                    Text(
                      'Danh Sách',
                      style: TextStyle(
                          color: currenttab == 1 ? Colors.blue : Colors.grey),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = ListCate();
                    currenttab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.create_new_folder_outlined,
                        color: currenttab == 2 ? Colors.blue : Colors.grey),
                    Text(
                      'Danh Mục',
                      style: TextStyle(
                          color: currenttab == 2 ? Colors.blue : Colors.grey),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = CalendarPage();
                    currenttab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month_outlined,
                        color: currenttab == 3 ? Colors.blue : Colors.grey),
                    Text(
                      'Lịch',
                      style: TextStyle(
                          color: currenttab == 3 ? Colors.blue : Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
