import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

import '../../utils/buttons.dart';

class SentCallSMSEmailScreen extends StatefulWidget {
  const SentCallSMSEmailScreen({Key? key}) : super(key: key);

  @override
  State<SentCallSMSEmailScreen> createState() => _SentCallSMSEmailScreenState();
}

class _SentCallSMSEmailScreenState extends State<SentCallSMSEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Sent"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
                label: "Call",
                callback: () {
                  Navigator.pushNamed(context, "call_screen");
                }),
            MyButton(
                label: "SMS",
                callback: () {
                  Navigator.pushNamed(context, "sms_screen");
                }),
            MyButton(
                label: "Email",
                callback: () {
                  Navigator.pushNamed(context, "email_screen");
                }),
          ],
        ),
      ),
    );
  }
}
