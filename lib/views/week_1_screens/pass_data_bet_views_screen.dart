import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/views/week_1_screens/get_data_bet_views_screen.dart';

class PassDataScreen extends StatefulWidget {
  const PassDataScreen({Key? key}) : super(key: key);

  @override
  State<PassDataScreen> createState() => _PassDataScreenState();
}

class _PassDataScreenState extends State<PassDataScreen> {
  final formKey = GlobalKey<FormState>();
  XFile? image;
  String firstName = "";
  String lastName = "";
  String email = "";
  int phoneNumber = 0;
  bool isPicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Pass Data"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // Pick an image
                      image =
                          await picker.pickImage(source: ImageSource.gallery);

                      setState(() {
                        isPicked = true;
                      });
                    },
                    icon: (isPicked == false)
                        ? const Icon(Icons.person, color: Colors.blue)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(File(image!.path))),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please fill it first...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      firstName = val.toString();
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter First Name",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please fill it first...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      lastName = val.toString();
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Last Name",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp("[ ]")),
                    FilteringTextInputFormatter.allow(
                        RegExp("[a-zá-ú0-9.,-_@]")),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please fill it first...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      email = val.toString();
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Mail Id",
                  ),
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please fill it first...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      phoneNumber = int.parse(val.toString());
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Phone Number",
                  ),
                ),
                MyButton(
                    label: "Save",
                    callback: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (phoneNumber.toString().length == 10) {
                          if (email.contains("@") && email.contains(".com")) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CatchDataScreen(
                                      image: image,
                                      firstName: firstName,
                                      lastName: lastName,
                                      email: email,
                                      phoneNumber: phoneNumber),
                                ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        "Please enter correct email address..")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      "phone number must have 10 digits.")));
                        }
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
