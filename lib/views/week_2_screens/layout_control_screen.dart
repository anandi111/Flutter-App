import 'package:flutter/material.dart';
import '../../utils/appbar.dart';
import '../../utils/buttons.dart';

class LayoutControlScreen extends StatefulWidget {
  const LayoutControlScreen({Key? key}) : super(key: key);

  @override
  State<LayoutControlScreen> createState() => _LayoutControlScreenState();
}

class _LayoutControlScreenState extends State<LayoutControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Layout & Control",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            MyButton(
                label: "TabBar",
                callback: () {
                  Navigator.pushNamed(context, "tabbar_screen");
                }),
            MyButton(
                label: "Drawer",
                callback: () {
                  Navigator.pushNamed(context, "drawer_screen");
                }),
            MyButton(
                label: "Bottom Navigation Bar",
                callback: () {
                  Navigator.pushNamed(context, "bottom_navigationbar_screen");
                }),
            MyButton(
                label: "Custom UI",
                callback: () {
                  Navigator.pushNamed(context, "custom_screen");
                })
          ],
        ),
      ),
    );
    ;
  }
}
