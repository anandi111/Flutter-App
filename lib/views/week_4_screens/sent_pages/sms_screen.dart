import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';
import 'package:url_launcher/url_launcher.dart';

class SMSScreen extends StatefulWidget {
  const SMSScreen({Key? key}) : super(key: key);

  @override
  State<SMSScreen> createState() => _SMSScreenState();
}

class _SMSScreenState extends State<SMSScreen> {
  TextEditingController numberController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "SMS"),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              MyTextField(
                  hintText: "Enter phone number",
                  validateType: "number",
                  textInputType: TextInputType.number,
                  controller: numberController,
                  onSubmit: () {}),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                  hintText: "Enter message",
                  validateType: "message",
                  textInputType: TextInputType.name,
                  controller: msgController,
                  onSubmit: () {}),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  label: "SMS",
                  callback: () async {
                    if (formkey.currentState!.validate()) {
                      final Uri smsLaunchUri = await Uri(
                        scheme: 'sms',
                        path: numberController.text,
                        queryParameters: <String, String>{
                          'body': msgController.text
                        },
                      );
                      await launchUrl(smsLaunchUri);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}
