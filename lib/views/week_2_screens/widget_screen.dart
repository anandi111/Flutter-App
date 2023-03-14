import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class WidgetScreen extends StatefulWidget {
  const WidgetScreen({Key? key}) : super(key: key);

  @override
  State<WidgetScreen> createState() => _WidgetScreenState();
}

class _WidgetScreenState extends State<WidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Widgets",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            MyButton(
                label: "Image",
                callback: () {
                  Navigator.pushNamed(context, "image_screen");
                }),
            MyButton(
                label: "Stack",
                callback: () {
                  Navigator.pushNamed(context, "stack_screen");
                }),
            MyButton(
                label: "ListView",
                callback: () {
                  Navigator.pushNamed(context, "listview_screen");
                }),
            MyButton(
                label: "GridView",
                callback: () {
                  Navigator.pushNamed(context, "gridview_screen");
                }),
            MyButton(
                label: "Slider",
                callback: () {
                  Navigator.pushNamed(context, "slider_screen");
                }),
            MyButton(
                label: "DropDown Button",
                callback: () {
                  Navigator.pushNamed(context, "dropdown_button_screen");
                }),
            MyButton(
                label: "PopupMenu Button",
                callback: () {
                  Navigator.pushNamed(context, "popupmenu_button_screen");
                }),
            MyButton(
                label: "Date Picker",
                callback: () {
                  Navigator.pushNamed(context, "date_picker_screen");
                }),
            MyButton(
                label: "Time Picker",
                callback: () {
                  Navigator.pushNamed(context, "time_picker_screen");
                }),
            MyButton(
                label: "Dialogs",
                callback: () {
                  Navigator.pushNamed(context, "dialog_screen");
                }),
            MyButton(
                label: "SnackBar",
                callback: () {
                  Navigator.pushNamed(context, "snackbar_screen");
                }),
          ],
        ),
      ),
    );
  }
}
