import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Page 4"),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
