import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class DartProScreen extends StatefulWidget {
  const DartProScreen({Key? key}) : super(key: key);

  @override
  State<DartProScreen> createState() => _DartProScreenState();
}

class _DartProScreenState extends State<DartProScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Dart Programing"),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            FlutterLogo(
              size: 100,
            ),
            Text(
              "\n\nDart is a client-optimized language for developing fast apps on any platform. Its goal is to offer the most productive programming language for multi-platform development, paired with a flexible execution runtime platform for app frameworks.\n",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Dart 2.18 is available now with Objective-C & Swift interoperability and improvements to networking, type inference, and async code performance.\n",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Dart also forms the foundation of Flutter. Dart provides the language and runtimes that power Flutter apps, but Dart also supports many core developer tasks like formatting, analyzing, and testing code.",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
