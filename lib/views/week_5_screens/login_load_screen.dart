import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/helpers/firebase_helper.dart';
import 'package:training_app/views/week_5_screens/user_detail_shown_screen.dart';

class LoginLoadScreen extends StatefulWidget {
  final bool isFacebook;
  const LoginLoadScreen({Key? key, required this.isFacebook}) : super(key: key);

  @override
  State<LoginLoadScreen> createState() => _LoginLoadScreenState();
}

class _LoginLoadScreenState extends State<LoginLoadScreen> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  redirect() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isFacebook', widget.isFacebook);

    UserCredential? userCredential = (widget.isFacebook == true)
        ? await FirebaseHelper.firebaseHelper.signInWithFacebook()
        : await FirebaseHelper.firebaseHelper.signInWithGoogle();

    print(userCredential);
    print(userCredential);
    print(userCredential);
    print(userCredential);

    if (userCredential == null) {
      Navigator.of(context).pushNamed("social_media_login_screen");
    } else {
      Future.delayed(const Duration(seconds: 4)).then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailShownScreen(
                  name: userCredential.user!.displayName!,
                  photo: userCredential.user!.photoURL!,
                  email: userCredential.user!.email!),
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Lottie.network("https://assets7.lottiefiles.com/packages/lf20_WMjfa4.json"),
            ),
          ),
          const Text(
            "Loading.......",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
