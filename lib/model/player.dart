// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum Position {
  GK(title: "GK", color: Colors.pinkAccent),
  LB(title: "LB", color: Colors.blueGrey),
  CB(title: "CB", color: Colors.blueGrey),
  RB(title: "RB", color: Colors.blueGrey),
  DM(title: "DM", color: Colors.grey),
  CM(title: "CM", color: Colors.grey),
  AM(title: "AM", color: Colors.grey),
  LW(title: "LW", color: Color.fromARGB(221, 68, 55, 55)),
  RW(title: "RW", color: Color.fromARGB(221, 68, 55, 55)),
  ST(title: "ST", color: Color.fromARGB(221, 68, 55, 55));

  final String title;
  final Color color;
  const Position({required this.title, required this.color});
}

class Player {
  Player({required this.name, required this.number, required this.position});
  String name;
  int number;
  Position position;
}

List<Player> playerList = [
  Player(name: "Vicario", number: 1, position: Position.GK),
  Player(name: "Udogie", number: 38, position: Position.LB),
  Player(name: "Van Der Ven", number: 37, position: Position.CB),
  Player(name: "Romero", number: 17, position: Position.CB),
  Player(name: "Porro", number: 23, position: Position.RB),
  Player(name: "Bissouma", number: 8, position: Position.DM),
  Player(name: "Sarr", number: 29, position: Position.CM),
  Player(name: "Maddison", number: 10, position: Position.AM),
  Player(name: "Son", number: 7, position: Position.LW),
  Player(name: "Johnson", number: 22, position: Position.RW),
  Player(name: "Richarlison", number: 9, position: Position.ST),
];
