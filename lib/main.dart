import 'package:flutter/material.dart';
import 'package:flutter_learn/page/imageandbutton.dart';
import 'package:flutter_learn/page/listview.dart';
import 'package:flutter_learn/page/users/main_login.dart';
import 'package:flutter_learn/page/webrtc/webrtc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "New App",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("My Flutter Learning",
                style: TextStyle(color: Colors.white)),
            backgroundColor: const Color.fromRGBO(19, 34, 87, 1.0),
            centerTitle: true,
          ),
          body: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MenuOption(widget: Home(), name: "Text, Image, Button"),
                SizedBox(height: 2.5),
                MenuOption(widget: ListViewPage(), name: "ListView"),
                SizedBox(height: 2.5),
                MenuOption(
                    widget: MainLoginScreen(), name: "Login and Register"),
                SizedBox(height: 2.5),
                MenuOption(widget: Webrtc(), name: "WebRTC")
              ]),
        ));
  }
}

class MenuOption extends StatelessWidget {
  final Widget widget;
  final String name;
  const MenuOption({super.key, required this.widget, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                side: const BorderSide(
                    width: 2.0, color: Color.fromRGBO(19, 34, 87, 1.0)),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => widget));
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            )));
  }
}
