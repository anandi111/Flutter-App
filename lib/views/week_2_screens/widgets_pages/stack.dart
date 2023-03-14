import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class StackScreen extends StatefulWidget {
  const StackScreen({Key? key}) : super(key: key);

  @override
  State<StackScreen> createState() => _StackScreenState();
}

class _StackScreenState extends State<StackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Stack"),
      body: Material(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff8e93b3),
              alignment: Alignment.bottomCenter,
              child: const Text(
                "Element setted in 0th position\n     This define stack size." +
                    "\n\n",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xff150428),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(100)),
              ),
              alignment: Alignment.bottomCenter,
              child: const Text(
                "Element setted in 1st position\n\n",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xff8541b0),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(100)),
              ),
              alignment: Alignment.bottomCenter,
              child: const Text(
                "Element setted in 2nd position\n\n",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xffd96f9f),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(100)),
              ),
              alignment: Alignment.bottomCenter,
              child: const Text(
                "Element setted in 3rd position\n\n",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
