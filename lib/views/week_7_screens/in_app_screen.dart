import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class InAppScreen extends StatefulWidget {
  const InAppScreen({Key? key}) : super(key: key);

  @override
  State<InAppScreen> createState() => _InAppScreenState();
}

class _InAppScreenState extends State<InAppScreen> {
  int? coin = 0;

  initCoin() async {
    final prefs = await SharedPreferences.getInstance();

    coin = prefs.getInt('coin')!;
    setState(() {});
  }

  @override
  void initState() {
    initCoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: "In App Purchase"),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                coin.toString() + "🪙",
                style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50,
              ),
              MyButton(
                  label: "Get Coins",
                  callback: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => BottomSheet(
                        onClosing: () {},
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                          height: 300,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.asset("assets/t.png", width: 70, height: 70),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Training App",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const Divider(),
                              const Text("This is a test order, you will not be charged."),
                              const Text("Test Card, always approves",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  final prefs = await SharedPreferences.getInstance();

                                  await prefs.setInt('coin', coin! + 10);

                                  coin = prefs.getInt('coin')!;
                                  setState(() {});

                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blue,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "\$10 for 10 Coin",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
