import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class FlutterIntroScreen extends StatefulWidget {
  const FlutterIntroScreen({Key? key}) : super(key: key);

  @override
  State<FlutterIntroScreen> createState() => _FlutterIntroScreenState();
}

class _FlutterIntroScreenState extends State<FlutterIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Flutter Intro"),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            FlutterLogo(
              size: 100,
            ),
            Text(
              "\n\nFlutter is an open source framework by Google for building beautiful, natively compiled, multi-platform applications from a single codebase.\n",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "May 11, 2022, Google I/O Edition: Flutter 3 release\n",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "With benefits like a single codebase for multiple platforms and a friendly developer experience, Flutter is a go-to solution for building high-quality mobile applications. We anticipate that web and desktop apps will follow suit now that Flutter is officially stable for web, Windows, macOS, and linux.",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
