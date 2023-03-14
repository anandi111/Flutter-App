import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class DropDownButtonScreen extends StatefulWidget {
  const DropDownButtonScreen({Key? key}) : super(key: key);

  @override
  State<DropDownButtonScreen> createState() => _DropDownButtonScreenState();
}

class _DropDownButtonScreenState extends State<DropDownButtonScreen> {
  List numberList = [
    "One",
    "Two",
    "Three",
    "Four",
    "Fifth",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
  ];
  String value = "One";
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "DropDown Button"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigo),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                    value: value,
                    isExpanded: true,
                    hint: const Text("     Select from here"),
                    borderRadius: BorderRadius.circular(50),
                    icon: const Icon(Icons.arrow_circle_down_sharp),
                    underline: Container(),
                    style: const TextStyle(
                        color: Colors.white, //Font color
                        fontSize: 20 //font size on dropdown button
                        ),
                    items: numberList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        value = val.toString();
                      });
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
