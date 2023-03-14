import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({Key? key}) : super(key: key);

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Dialogs"),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
                label: "Android Style Dialog",
                callback: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Exit"),
                            content: const Text("are you sure to exit?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Exit",
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                          ));
                }),
            MyButton(
                label: "IOS Style Dialog",
                callback: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: const Text("Exit"),
                            content: const Text("are you sure to exit?"),
                            actions: [
                              CupertinoButton(
                                  child: const Text("Cancel",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              CupertinoButton(
                                  child: const Text(
                                    "Ok",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }),
                            ],
                          ));
                })
          ],
        ),
      ),
    );
  }
}
