import 'package:flutter/material.dart';
import 'package:flutter_learn/page/addform.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/player.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List", style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(19, 34, 87, 1.0),
          centerTitle: true,
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: playerList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: playerList[index].position.color),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 2.5, vertical: 5),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${playerList[index].position.title}  ${playerList[index].name}",
                          style: GoogleFonts.oswald(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          playerList[index].number.toString(),
                          style: GoogleFonts.oswald(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: IconButton(
                icon: const Icon(Icons.add, size: 40, color: Colors.blueAccent),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const AddForm()));
                }),
          )
        ]));
  }
}
