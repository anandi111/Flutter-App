import 'package:flutter/material.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TabBar"),
          bottom: const TabBar(indicatorSize: TabBarIndicatorSize.label, tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
            ),
            Tab(
              icon: Icon(Icons.person),
              text: "User",
            ),
            Tab(
              icon: Icon(Icons.call),
              text: "Call",
            ),
          ]),
        ),
        body: TabBarView(children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.home,
                  size: 100,
                  color: Colors.teal,
                ),
                Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const Center(
            child: Icon(
              Icons.person,
              size: 100,
              color: Colors.teal,
            ),
          ),
          const Center(
            child: Icon(
              Icons.call,
              size: 100,
              color: Colors.teal,
            ),
          ),
        ]),
      ),
    );
  }
}
