import 'package:demoapp_todo/todo/create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'todo/tabdatenote.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  String? time;
  void _onDayselected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      print(today);
      time = day.toString();
    });
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Row(
          children: [
            SizedBox(
              width: 125,
            ),
            Text(
              'Lịch',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            )
          ],
        ),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: TableCalendar(
            locale: 'en_US',
            rowHeight: 43,
            calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedTextStyle:
                    TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                defaultTextStyle: TextStyle(color: Colors.black),
                weekendTextStyle:
                    TextStyle(color: Color.fromARGB(255, 255, 0, 0))),
            headerStyle: HeaderStyle(
                formatButtonShowsNext: false,
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
                formatButtonTextStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(fontSize: 20, color: Colors.black)),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            firstDay: DateTime.utc(2010, 10, 16),
            focusedDay: today,
            lastDay: DateTime.utc(2030, 3, 14),
            onDaySelected: _onDayselected,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 86, right: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius: 2)],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (time == null) {
                            time = DateTime.now().toString();
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabDateNote(
                                        timenote: time!.substring(0, 10),
                                      )));
                        });
                      },
                      child: Row(children: [
                        Image(
                          image: AssetImage('assets/datenote.png'),
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Ghi Chú',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ]),
                    )),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 2)],
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Createpage(
                                    timecreate: time,
                                    cate: null,
                                  )));
                    },
                    icon: Icon(
                      Icons.add,
                      size: 35,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
