import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Page 2"),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(
                label: "Go to Page 3",
                callback: () {
                  Navigator.pushNamed(context, "page_3");
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
