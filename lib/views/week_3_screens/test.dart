import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

import '../../helpers/api_helper.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isTest = true;
  double testDouble = 10.5;
  int testInt = 10;
  String testString = "hello # world #";

  futureData() {
    String? name;

    // return Future.delayed(
    //   const Duration(seconds: 3),
    //   () => name = "Got Data",
    // );

    return Future.delayed(
      const Duration(seconds: 3),
      () => "",
    );

    // return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Test"),
      body: Column(
        children: [
          FutureBuilder(
            future: futureData(),
            initialData: "intialData",
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return const Text("None"); //when future has null data....
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Waiting"); // when future is coming...
              } else if (snapshot.connectionState == ConnectionState.active) {
                return const Text("Active");
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text("error"); //when have error...
                } else if (snapshot.hasData) {
                  return const Text("Data"); // when have data...
                } else {
                  return const Text("Nothing");
                }
              } else {
                return const Text("else");
              }
            },
          )

          // InkWell(
          //   onTap: () {
          //     testString = testString;
          //     print(testString.indexOf("d"));
          //   },
          //   child: Center(
          //     child: InteractiveViewer(
          //       maxScale: 3,
          //       child: Image.asset("assets/henry-be-lc7xcWebECc-unsplash.jpg"),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
