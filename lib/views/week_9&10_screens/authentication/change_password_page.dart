import 'package:flutter/material.dart';
import 'package:training_app/helpers/firebase_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Forgot Password"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Text(
                "Resent Link will be sent to your email!!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.green),
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  hintText: "Enter Email",
                  validateType: "email",
                  textInputType: TextInputType.emailAddress,
                  controller: emailController,
                  onSubmit: () {}),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  label: "Confirm Email",
                  callback: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseHelper.firebaseHelper
                          .changePasswordWithLink(email: emailController.text)
                          .then((value) => Navigator.pop(context));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
