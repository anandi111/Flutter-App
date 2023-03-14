import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/textfield.dart';
import 'package:training_app/views/week_5_screens/login_load_screen.dart';
import 'package:training_app/views/week_9&10_screens/authentication/welcome_page.dart';

import '../../../helpers/firebase_helper.dart';
import '../../../utils/buttons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool absorbSignIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Sign In"),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyTextField(
                    hintText: "Enter Name",
                    validateType: "name",
                    textInputType: TextInputType.text,
                    controller: nameController,
                    onSubmit: () {}),
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
                  height: 20,
                ),
                MyTextField(
                    hintText: "Enter Password",
                    validateType: "password",
                    textInputType: TextInputType.text,
                    controller: passController,
                    onSubmit: () {}),
                const SizedBox(
                  height: 40,
                ),
                AbsorbPointer(
                  absorbing: absorbSignIn,
                  child: MyButton(
                      label: "Sign Up",
                      callback: () async {
                        if (formKey.currentState!.validate()) {
                          User? user = await FirebaseHelper.firebaseHelper
                              .signUp(email: emailController.text, password: passController.text);

                          if (user != null) {
                            setState(() {
                              absorbSignIn = true;
                            });

                            final prefs = await SharedPreferences.getInstance();

                            await prefs.setBool('isWelcome', true);
                            await prefs.setStringList(
                                'data', <String>[user.uid, user.email.toString(), DateTime.now().toString()]);

                            Navigator.of(context).pushReplacementNamed("welcome_page");
                          }
                        }
                      }),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                    label: "Login",
                    callback: () {
                      Navigator.of(context).pushReplacementNamed("login_page");
                    }),
                const SizedBox(
                  height: 50,
                ),
                MyButton(
                    label: "Sign In With Google 🔒",
                    callback: () async {
                      UserCredential? userCredential = await FirebaseHelper.firebaseHelper.signInWithGoogle();

                      if (userCredential != null) {
                        final prefs = await SharedPreferences.getInstance();

                        await prefs.setBool('isWelcome', true);

                        await prefs.setStringList('data', <String>[
                          userCredential.user!.uid,
                          userCredential.user!.email.toString(),
                          DateTime.now().toString()
                        ]);

                        Navigator.of(context).pushReplacementNamed("welcome_page");
                      }
                    }),
                MyButton(
                    label: "Sign In With Facebook 🔒",
                    callback: () async {
                      UserCredential? userCredential = await FirebaseHelper.firebaseHelper.signInWithFacebook();

                      if (userCredential != null) {
                        final prefs = await SharedPreferences.getInstance();

                        await prefs.setBool('isWelcome', true);

                        await prefs.setStringList('data', <String>[
                          userCredential.user!.uid,
                          userCredential.user!.email.toString(),
                          DateTime.now().toString()
                        ]);

                        Navigator.of(context).pushReplacementNamed("welcome_page");
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
