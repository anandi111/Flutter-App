import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';
import 'package:url_launcher/url_launcher.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  TextEditingController numberController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Call"),
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
              MyButton(
                  label: "Call",
                  callback: () async {
                    if (formkey.currentState!.validate()) {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: numberController.text,
                      );
                      await launchUrl(launchUri);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
