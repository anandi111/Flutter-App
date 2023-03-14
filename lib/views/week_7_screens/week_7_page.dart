import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/views/week_7_screens/in_app_purchase_screen.dart';
import 'package:training_app/views/week_7_screens/in_app_screen.dart';

class Week7Page extends StatefulWidget {
  const Week7Page({Key? key}) : super(key: key);

  @override
  State<Week7Page> createState() => _Week7PageState();
}

class _Week7PageState extends State<Week7Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Week 7 Page"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
                label: "Custom Camera",
                callback: () {
                  Navigator.pushNamed(context, "custom_camera_screen");
                }),
            MyButton(
                label: "Pull to Refresh",
                callback: () {
                  Navigator.pushNamed(context, "pull_to_refresh_screen");
                }),
            MyButton(
                label: "In App Purchase",
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InAppPurchaseScreen(),
                      ));
                  // Navigator.pushNamed(context, "in_app_purchase_screen");
                }),
            MyButton(
                label: "In App Purchase Demo",
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InAppScreen(),
                      ));
                  // Navigator.pushNamed(context, "in_app_purchase_screen");
                }),
            MyButton(
                label: "Payment Gateways",
                callback: () {
                  Navigator.pushNamed(context, "payment_gateway_screen");
                }),
            // MyButton(
            //     label: "Stripe Payment Gateways",
            //     callback: () {
            //       Navigator.pushNamed(context, "stripe_payment_gateway_screen");
            //     }),
          ],
        ),
      ),
    );
  }
}
