import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class InbuiltProprtiesScreen extends StatefulWidget {
  const InbuiltProprtiesScreen({Key? key}) : super(key: key);

  @override
  State<InbuiltProprtiesScreen> createState() => _InbuiltProprtiesScreenState();
}

enum Gender { Male, Female, Other }

class _InbuiltProprtiesScreenState extends State<InbuiltProprtiesScreen> {
  //radio button variables..
  Gender _gender = Gender.Male;

  //checkbox variables...
  bool english = false;
  bool hindi = false;
  bool gujarati = false;

  //switch variables..
  bool switchVar = true;

  //toggle button variables...
  List<bool> toggleList = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Inbuilt Properties"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Column(
              children: [
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  "Radio",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.white,
                ),
                ListTile(
                  title: const Text('Male'),
                  leading: Radio(
                    activeColor: Colors.blue,
                    value: Gender.Male,
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = Gender.Male;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Female'),
                  leading: Radio(
                    value: Gender.Female,
                    activeColor: Colors.pink,
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = Gender.Female;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Other'),
                  leading: Radio(
                    value: Gender.Other,
                    activeColor: Colors.white,
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = Gender.Other;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  "Check Box",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.white,
                ),
                ListTile(
                  title: const Text('English'),
                  leading: Checkbox(
                      value: english,
                      onChanged: (value) {
                        setState(() {
                          english = value!;
                        });
                      }),
                ),
                ListTile(
                    title: const Text('Hindi'),
                    leading: Checkbox(
                        value: hindi,
                        onChanged: (value) {
                          setState(() {
                            hindi = value!;
                          });
                        })),
                ListTile(
                    title: const Text('Gujarati'),
                    leading: Checkbox(
                        value: gujarati,
                        onChanged: (value) {
                          setState(() {
                            gujarati = value!;
                          });
                        })),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  "Switch",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Switch(
                    activeColor: Colors.red,
                    value: switchVar,
                    onChanged: (value) {
                      setState(() {
                        switchVar = value;
                      });
                    }),
              ],
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  "Radio ListTile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.white,
                ),
                RadioListTile(
                  value: _gender,
                  groupValue: Gender.Male,
                  title: const Text("Male"),
                  onChanged: (val) {
                    setState(() {
                      _gender = Gender.Male;
                    });
                  },
                ),
                RadioListTile(
                    value: _gender,
                    groupValue: Gender.Female,
                    title: const Text("Female"),
                    onChanged: (val) {
                      setState(() {
                        _gender = Gender.Female;
                      });
                    }),
                RadioListTile(
                    value: _gender,
                    groupValue: Gender.Other,
                    title: const Text("Other"),
                    onChanged: (val) {
                      setState(() {
                        _gender = Gender.Other;
                      });
                    })
              ],
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  "CheckBox ListTile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.white,
                ),
                CheckboxListTile(
                    value: english,
                    activeColor: Colors.orange,
                    title: const Text("English"),
                    onChanged: (val) {
                      setState(() {
                        english = val!;
                      });
                    }),
                CheckboxListTile(
                    value: hindi,
                    activeColor: Colors.blue,
                    title: const Text("Hindi"),
                    onChanged: (val) {
                      setState(() {
                        hindi = val!;
                      });
                    }),
                CheckboxListTile(
                    value: gujarati,
                    activeColor: Colors.green,
                    title: const Text("Gujarati"),
                    onChanged: (val) {
                      setState(() {
                        gujarati = val!;
                      });
                    }),
              ],
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  "Toggle Buttons",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.white,
                ),
                ToggleButtons(
                    selectedColor: Colors.indigo,
                    onPressed: (val) {
                      setState(() {
                        toggleList[val] = !toggleList[val];
                      });
                    },
                    isSelected: toggleList,
                    children: const [
                      Text(" English "),
                      Text(" Hindi "),
                      Text(" Gujarati "),
                    ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
