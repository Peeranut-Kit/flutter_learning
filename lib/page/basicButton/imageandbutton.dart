import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(19, 34, 87, 1.0),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                color: Colors.black12,
                //margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: const Text(
                  "Image",
                  style: TextStyle(fontSize: 30, letterSpacing: 2),
                )),
            const SizedBox(height: 10), // create fixed box to seperate children
            Image.network(
              //Image.asset() if want to import from internal folder
              "https://images.pexels.com/photos/9754/mountains-clouds-forest-fog.jpg",
              //width: 150,
              //height: 100
            ),
            const TextDisplayed(),
          ],
        ),
      ),
    );
  }
}

class TextDisplayed extends StatefulWidget {
  const TextDisplayed({super.key});

  @override
  State<TextDisplayed> createState() => _TextDisplayedState();
}

class _TextDisplayedState extends State<TextDisplayed> {
  var text = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(text,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.green),
            onPressed: () {
              setState(() {
                text = "TextButton clicked.";
              });
            },
            child: const Text("Text",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          FilledButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueGrey),
            onPressed: () {
              setState(() {
                text = "FilledButton clicked.";
              });
            },
            child: const Text("Filled",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                // side = เส้นขอบ
                side: const BorderSide(color: Colors.red, width: 2)),
            onPressed: () {
              setState(() {
                text = "OutlinedButton clicked.";
              });
            },
            child: const Text("Outlined",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 5),
            onPressed: () {
              setState(() {
                text = "ElevatedButton clicked.";
              });
            },
            child: const Text("Elevated",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          )
        ],
      )
    ]);
  }
}
