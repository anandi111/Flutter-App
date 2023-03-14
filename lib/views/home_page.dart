import 'package:flutter/material.dart';
import 'package:training_app/helpers/dynamic_link_service_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> getData() async {
    await DynamicLinkServiceHelper.dynamicLinkServiceHelper.initialLink(context);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Training Work",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            MyButton(
                label: "Week 1",
                callback: () {
                  Navigator.pushNamed(context, "week_1_page");
                }),
            MyButton(
                label: "Week 2",
                callback: () {
                  Navigator.pushNamed(context, "week_2_page");
                }),
            MyButton(
                label: "Week 3",
                callback: () {
                  Navigator.pushNamed(context, "week_3_page");
                }),
            MyButton(
                label: "Week 4",
                callback: () {
                  Navigator.pushNamed(context, "week_4_page");
                }),
            MyButton(
                label: "Week 5",
                callback: () {
                  Navigator.pushNamed(context, "week_5_page");
                }),
            MyButton(
                label: "Week 6",
                callback: () {
                  Navigator.of(context).pushNamed("week_6_page");
                }),
            MyButton(
                label: "Week 7",
                callback: () {
                  Navigator.of(context).pushNamed("week_7_page");
                }),
            MyButton(
                label: "Week 8",
                callback: () {
                  Navigator.of(context).pushNamed("week_8_page");
                }),
            MyButton(
                label: "Week 9 & 10",
                callback: () {
                  Navigator.of(context).pushNamed("week_9_page");
                }),
            MyButton(
                label: "Week 11",
                callback: () {
                  Navigator.of(context).pushNamed("week_11_page");
                }),
            MyButton(
                label: "Week 12",
                callback: () {
                  Navigator.of(context).pushNamed("week_12_page");
                }),
          ],
        ),
      ),
    );
  }
}
