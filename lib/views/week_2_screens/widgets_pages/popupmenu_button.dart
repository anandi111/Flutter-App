import 'package:flutter/material.dart';

class PopupMenuButtonScreen extends StatefulWidget {
  const PopupMenuButtonScreen({Key? key}) : super(key: key);

  @override
  State<PopupMenuButtonScreen> createState() => _PopupMenuButtonScreenState();
}

// ignore: constant_identifier_names
enum Data { One, Two, Three, Four, Five }

class _PopupMenuButtonScreenState extends State<PopupMenuButtonScreen> {
  List numberList = ["One", "Two", "Three", "Four", "Five"];
  String intialValue = "One";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PopupMenu Button"),
        actions: [
          PopupMenuButton(
            onSelected: (Data val) {
              setState(() {
                print(val.name);
                intialValue = val.name;
              });
            },
            itemBuilder: (context) => Data.values
                .map((e) => PopupMenuItem<Data>(
                      value: e,
                      child: Text(e.name),
                    ))
                .toList(),
          )
        ],
      ),
      body: Center(
          child: Text(
        intialValue,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      )),
    );
  }
}
