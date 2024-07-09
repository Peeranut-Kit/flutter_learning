import 'package:flutter/material.dart';
import 'package:flutter_learn/model/player.dart';
import 'package:flutter_learn/page/listview/listview.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _number = 0;
  Position _position = Position.CM;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Add Form",
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Add Form"),
              backgroundColor: Colors.green,
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(5),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 20,
                        decoration: const InputDecoration(
                            label: Text(
                          "name",
                          style: TextStyle(fontSize: 20),
                        )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Cannot submit empty name.";
                          }
                          return null;
                        },
                        onSaved: (value) => _name = value!,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 20,
                        decoration: const InputDecoration(
                            label: Text(
                          "number",
                          style: TextStyle(fontSize: 20),
                        )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please input number.";
                          }
                          return null;
                        },
                        onSaved: (value) => _number = int.parse(value!),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                          decoration: const InputDecoration(
                              label: Text(
                            "position",
                            style: TextStyle(fontSize: 20),
                          )),
                          items: Position.values.map((element) {
                            return DropdownMenuItem(
                              value: element,
                              child: Text(element.title),
                            );
                          }).toList(),
                          value: _position,
                          onChanged: (value) {
                            setState(() {
                              _position = value!;
                            });
                          }),
                      FilledButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey),
                        onPressed: () {
                          _formKey.currentState!.validate();
                          _formKey.currentState!.save();
                          playerList.add(Player(
                              name: _name,
                              number: _number,
                              position: _position));
                          _formKey.currentState!.reset();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const ListViewPage()));
                        },
                        child: const Text("Save",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )),
            )));
  }
}
