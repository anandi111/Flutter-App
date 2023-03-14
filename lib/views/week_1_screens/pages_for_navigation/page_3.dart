import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Page 3"),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(
                label: "Push and Replacement to page 4 ",
                callback: () {
                  Navigator.pushReplacementNamed(context, "page_4");
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
