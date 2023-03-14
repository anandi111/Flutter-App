import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/helpers/firebase_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/reso.dart';
import 'package:training_app/utils/textfield.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController pageController = PageController();
  int currentIndex = 0;
  List<String>? data = [];
  TextEditingController newPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    final prefs = await SharedPreferences.getInstance();

    data = prefs.getStringList('data') ?? ["dummy content", "dummy@gmail.com", "dummy date"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Welcome Page"),
      body: PageView(
        controller: pageController,
        onPageChanged: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Welcome!!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                    label: "LogOut",
                    callback: () async {
                      await FirebaseHelper.firebaseHelper.signOut();
                      await FirebaseHelper.firebaseHelper.signOutFromGoogle();
                      await FirebaseHelper.firebaseHelper.signOutFromFacebook();

                      final prefs = await SharedPreferences.getInstance();

                      prefs.remove("data");
                      prefs.remove("isWelcome");

                      Navigator.pushReplacementNamed(context, "login_page");
                    }),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "UserID: ${data!.first}",
                  style: const TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Email: ${data![1]}",
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Created: ${data!.last}",
                  style: const TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          // SingleChildScrollView(
          //   padding: const EdgeInsets.all(25),
          //   child: Form(
          //     key: formKey,
          //     child: Column(
          //       children: [
          //         MyTextField(
          //             hintText: "Enter new password",
          //             validateType: "password",
          //             textInputType: TextInputType.text,
          //             controller: newPasswordController,
          //             onSubmit: () {}),
          //         const SizedBox(
          //           height: 30,
          //         ),
          //         MyButton(
          //             label: "Reset Password",
          //             callback: () async {
          //               if (formKey.currentState!.validate()) {
          //                 await FirebaseHelper.firebaseHelper
          //                     .changePasswordWithOutLink(newPassword: newPasswordController.text);
          //                 currentIndex = 0;
          //                 pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.linear);
          //                 newPasswordController.clear();
          //                 setState(() {});
          //               }
          //             })
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: currentIndex,
        onTap: (val) {
          currentIndex = val;
          pageController.animateToPage(val, duration: const Duration(seconds: 1), curve: Curves.linear);
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(
                Icons.person,
              )),
          // BottomNavigationBarItem(
          //     label: "Settings",
          //     icon: Icon(
          //       Icons.settings,
          //     )),
        ],
      ),
    );
  }
}
