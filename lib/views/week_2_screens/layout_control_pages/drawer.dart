import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Drawer"),
      drawer: Drawer(
        backgroundColor: CupertinoColors.darkBackgroundGray,
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey),
              child: const Center(
                  child: Text(
                "A",
                style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              )),
            ),
            const SizedBox(
              height: 50,
            ),
            const ListTile(
              tileColor: CupertinoColors.darkBackgroundGray,
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                "Profile Details",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () {},
              tileColor: CupertinoColors.darkBackgroundGray,
              leading: const Icon(
                Icons.all_out,
                color: Colors.white,
              ),
              title: const Text(
                "All Categories",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () {},
              tileColor: CupertinoColors.darkBackgroundGray,
              leading: const Icon(
                Icons.electrical_services,
                color: Colors.white,
              ),
              title: const Text(
                "Electronics",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () {},
              tileColor: CupertinoColors.darkBackgroundGray,
              leading: const Icon(
                Icons.home_mini_sharp,
                color: Colors.white,
              ),
              title: const Text(
                "Home Applience",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () {},
              tileColor: CupertinoColors.darkBackgroundGray,
              leading: const Icon(
                Icons.currency_lira_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Fashion",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              onTap: () {},
              tileColor: CupertinoColors.darkBackgroundGray,
              leading: const Icon(
                Icons.book_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Books",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("Welcome!!",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
