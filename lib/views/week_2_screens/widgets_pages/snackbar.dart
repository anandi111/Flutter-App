import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class SnackBarScreen extends StatefulWidget {
  const SnackBarScreen({Key? key}) : super(key: key);

  @override
  State<SnackBarScreen> createState() => _SnackBarScreenState();
}

class _SnackBarScreenState extends State<SnackBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "SnackBar"),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            MyButton(
                label: "Show SnackBar",
                callback: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("This is snackbar")));
                }),
            MyButton(
                label: "Show Multiline Upper SnackBar",
                callback: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.transparent,
                      content: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 80,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  "Snackbar",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "This is snackbar",
                                ),
                              ],
                            ),
                          )
                        ],
                      )));
                }),
          ],
        ),
      ),
    );
  }
}
