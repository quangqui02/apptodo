import 'package:demoapp_todo/todo/listnote.dart';
import 'package:demoapp_todo/todo/listtodo_true.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabTodo extends StatefulWidget {
  @override
  State<TabTodo> createState() => _TabtodoState();
}

class _TabtodoState extends State<TabTodo> with TickerProviderStateMixin {
  String? catagories;
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
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            title: Row(
              children: [
                SizedBox(
                  width: size.width * 0.25,
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
              SizedBox(
                height: 5,
              ),
              // Container(
              //   // width: 320,
              //   height: 50,
              //   // decoration: BoxDecoration(
              //   //     border: Border.all(color: Colors.black),
              //   //     borderRadius: BorderRadius.circular(10)),
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
              //     // icon: Icon(Icons.category_outlined),
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
                  labelPadding: EdgeInsets.only(left: 10, right: 10),
                  indicator: TabIndicator(color: Colors.black, radius: 4),
                  controller: _controller,
                  tabs: <Tab>[
                    Tab(
                      child: Container(
                        width: 150,
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
                        width: 150,
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
                height: MediaQuery.of(context).size.height * 1 - 250,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    TodoPage(
                      cate: catagories,
                    ),
                    TodoPageTrue(
                      cate: catagories,
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
