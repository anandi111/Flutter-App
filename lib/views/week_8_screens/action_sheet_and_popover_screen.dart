import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:popover/popover.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class ActionSheetANDPopoverScreen extends StatefulWidget {
  const ActionSheetANDPopoverScreen({Key? key}) : super(key: key);

  @override
  State<ActionSheetANDPopoverScreen> createState() => _ActionSheetANDPopoverScreenState();
}

class _ActionSheetANDPopoverScreenState extends State<ActionSheetANDPopoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Action Sheet & Popover"),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyPopOver1Button(),
            const MyPopOver2Button(),
            MyButton(
                label: "Android Action Sheet",
                callback: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 400,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Android Action Sheet",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(msg: "Android Action Sheet Item ${index + 1} Pressed");
                                    },
                                    title: Center(
                                        child: Text("Item ${index + 1}",
                                            style: const TextStyle(
                                                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600))),
                                  );
                                },
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              title: const Center(
                                  child: Text("Cancel",
                                      style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.w600))),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
            Material(
              child: MyButton(
                  label: "IOS Action Sheet",
                  callback: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          title: const Text("Ios Action Sheet"),
                          actions: [1, 2, 3, 4, 5]
                              .map((e) => CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(msg: "IOS Action Sheet Item $e Pressed");
                                  },
                                  child: Text("Item $e")))
                              .toList(),
                          cancelButton: CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPopOver1Button extends StatefulWidget {
  const MyPopOver1Button({Key? key}) : super(key: key);

  @override
  State<MyPopOver1Button> createState() => _MyPopOver1ButtonState();
}

class _MyPopOver1ButtonState extends State<MyPopOver1Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: MyButton(
          label: "Popover 1",
          callback: () {
            showPopover(
              context: context,
              bodyBuilder: (context) => const ListItems1(),
              onPop: () => print('Popover was popped!'),
              direction: PopoverDirection.right,
              width: 70,
              height: 160,
              arrowHeight: 15,
              arrowWidth: 30,
            );
          }),
    );
  }
}

class MyPopOver2Button extends StatefulWidget {
  const MyPopOver2Button({Key? key}) : super(key: key);

  @override
  State<MyPopOver2Button> createState() => _MyPopOver2ButtonState();
}

class _MyPopOver2ButtonState extends State<MyPopOver2Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: MyButton(
          label: "Popover 2",
          callback: () {
            showPopover(
              context: context,
              bodyBuilder: (context) => const ListItems2(),
              onPop: () => print('Popover was popped!'),
              direction: PopoverDirection.bottom,
              width: 200,
              height: 300,
              arrowHeight: 15,
              arrowWidth: 30,
            );
          }),
    );
  }
}

class ListItems1 extends StatefulWidget {
  const ListItems1({Key? key}) : super(key: key);

  @override
  State<ListItems1> createState() => _ListItems1State();
}

class _ListItems1State extends State<ListItems1> {
  List iconList = [Icons.home, Icons.login, Icons.person, Icons.shopping_cart, Icons.notification_add];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.builder(
          itemBuilder: (context, index) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  if (index == 0) {
                    Fluttertoast.showToast(msg: "Home Button Pressed");
                  } else if (index == 1) {
                    Fluttertoast.showToast(msg: "Login Button Pressed");
                  } else if (index == 2) {
                    Fluttertoast.showToast(msg: "User Detail Button Pressed");
                  } else if (index == 3) {
                    Fluttertoast.showToast(msg: "Shopping Cart Button Pressed");
                  } else {
                    Fluttertoast.showToast(msg: "Notification Button Pressed");
                  }
                },
                child: Container(
                    child: Icon(
                  iconList[index],
                  color: Colors.black,
                )),
              ),
              const Divider(),
            ],
          ),
          itemCount: iconList.length,
        ),
      ),
    );
  }
}

class ListItems2 extends StatefulWidget {
  const ListItems2({Key? key}) : super(key: key);

  @override
  State<ListItems2> createState() => _ListItems2State();
}

class _ListItems2State extends State<ListItems2> {
  List colorList = [Colors.teal[500], Colors.teal[400], Colors.teal[300], Colors.teal[200], Colors.teal[100]];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.builder(
          itemCount: colorList.length,
          itemBuilder: (context, index) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)..pop();
                  Fluttertoast.showToast(msg: "Popover Item ${index + 1} Pressed");
                },
                child: Container(
                  height: 50,
                  color: colorList[index],
                  child: Center(
                      child: Text(
                    "Item ${index + 1}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
