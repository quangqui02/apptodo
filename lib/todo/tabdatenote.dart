import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'datenote.dart';
import 'datenotetrue.dart';

class TabDateNote extends StatefulWidget {
  TabDateNote({Key? key, required this.timenote}) : super(key: key);
  String? timenote;
  @override
  State<TabDateNote> createState() => _TabDateNoteState();
}

class _TabDateNoteState extends State<TabDateNote>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _controller = TabController(length: 2, vsync: this);
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            // automaticallyImplyLeading: true,
            foregroundColor: Colors.black,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            title: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_sharp,
                      size: 25,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: size.width * 0.1,
                ),
                Text(
                  'Danh Sách',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                height: size.height * 0.05,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ngày: ' + this.widget.timenote!,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 50,
              //   child: DropdownButton<String>(
              //     isExpanded: true,
              //     value: catagories,
              //     icon: Icon(
              //       Icons.filter_alt,
              //       color: Colors.black,
              //     ),
              //     items: list.map((e) {
              //       return DropdownMenuItem(
              //         value: e,
              //         child: Center(
              //           child: Text(
              //             '$e',
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         catagories = value;
              //       });
              //     },
              //     hint: Center(
              //       child: const Text(
              //         'Hãy lọc ghi chú theo...',
              //         style: TextStyle(color: Colors.black, fontSize: 15),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 4,
              ),
              Container(
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  indicator: TabIndicator(color: Colors.black, radius: 4),
                  controller: _controller,
                  tabs: <Tab>[
                    Tab(
                      child: Container(
                        width: 140,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(31, 160, 160, 160),
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/notetime.png'),
                              width: 35,
                              height: 35,
                            ),
                            Text(
                              'Ghi Chú',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        width: 140,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(31, 160, 160, 160),
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/list.png'),
                              width: 35,
                              height: 35,
                            ),
                            Text(
                              'Hoàn Thành',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 1 - 222,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    DateNoteF(
                      timenote: this.widget.timenote,
                    ),
                    DateNoteT(
                      timenote: this.widget.timenote,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabIndicator extends Decoration {
  final Color color;
  double radius;
  TabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onchanged]) {
    return _CircleBoxPainter(color: color, radius: radius);
  }
}

class _CircleBoxPainter extends BoxPainter {
  final Color color;
  double radius;
  _CircleBoxPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
