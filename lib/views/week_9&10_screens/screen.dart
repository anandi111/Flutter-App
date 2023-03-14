import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class Screen extends StatefulWidget {
  String title;
  Screen({Key? key, required this.title}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
      ),
    );
  }
}
