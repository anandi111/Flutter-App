import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class IconDensityScreen extends StatefulWidget {
  const IconDensityScreen({Key? key}) : super(key: key);

  @override
  State<IconDensityScreen> createState() => _IconDensityScreenState();
}

class _IconDensityScreenState extends State<IconDensityScreen> {
  List iconList = [
    {
      "name": "0.75x",
      "path": "assets/0.75x/burger_king.png",
    },
    {
      "name": "1x",
      "path": "assets/burger_king.png",
    },
    {
      "name": "1.5x",
      "path": "assets/1.5x/burger_king.png",
    },
    {
      "name": "2x",
      "path": "assets/2x/burger_king.png",
    },
    {
      "name": "3x",
      "path": "assets/3x/burger_king.png",
    },
    {
      "name": "4x",
      "path": "assets/4x/burger_king.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Different DPI"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Divider(
              color: Colors.white,
            ),
            const Text(
              "Real Device Icon",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset("assets/burger_king.png"),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              color: Colors.white,
            ),
            const Text(
              "All Icon",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: iconList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${iconList[index]["name"]}"),
                    Image.asset(iconList[index]["path"]),
                    const Divider(
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
