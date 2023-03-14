import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Page 1"),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(
                label: "Go to Page 2",
                callback: () {
                  Navigator.pushNamed(context, "page_2");
                }),
            MyButton(
                label: "Go Back",
                callback: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
