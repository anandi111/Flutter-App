import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int currentIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: "Bottom Navigation Bar"),
        body: PageView(
          controller: pageController,
          onPageChanged: (val) {
            setState(() {
              currentIndex = val;
            });
          },
          children: const [
            Center(
              child: Text(
                "Home",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: Text(
                "User",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: Text(
                "Call",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (val) {
            setState(() {
              currentIndex = val;
              pageController.animateToPage(val,
                  duration: const Duration(microseconds: 800),
                  curve: Curves.easeIn);
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "call"),
          ],
        ));
  }
}
