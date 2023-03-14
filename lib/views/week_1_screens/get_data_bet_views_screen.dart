import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_app/utils/buttons.dart';

import '../../utils/appbar.dart';

class CatchDataScreen extends StatefulWidget {
  CatchDataScreen(
      {Key? key,
      required this.image,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber})
      : super(key: key);
  dynamic image;
  String firstName;
  String lastName;
  String email;
  int phoneNumber;

  @override
  State<CatchDataScreen> createState() => _CatchDataScreenState();
}

class _CatchDataScreenState extends State<CatchDataScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  int count = 0;
  int currentPhoneNumber = 0;

  @override
  void initState() {
    firstNameController.text = widget.firstName;
    lastNameController.text = widget.lastName;
    emailController.text = widget.email;
    phoneNumberController.text = widget.phoneNumber.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Catch Data"),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
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
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        widget.image = await _picker.pickImage(
                            source: ImageSource.gallery);

                        count = 1;

                        setState(() {});
                      },
                      icon: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: (widget.image == null)
                              ? const Icon(Icons.person, color: Colors.blue)
                              : Image.file(File(widget.image.path))),
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.name,
                    controller: firstNameController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please fill it first...";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      setState(() {
                        widget.firstName = val.toString();
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter First Name",
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.name,
                    controller: lastNameController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please fill it first...";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      setState(() {
                        widget.lastName = val.toString();
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Last Name",
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp("[ ]")),
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-zá-ú0-9.,-_@]")),
                      LengthLimitingTextInputFormatter(50),
                    ],
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please fill it first...";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      setState(() {
                        widget.email = val.toString();
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Mail Id",
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      LengthLimitingTextInputFormatter(50),
                    ],
                    keyboardType: TextInputType.number,
                    controller: phoneNumberController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please fill it first...";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      setState(() {
                        currentPhoneNumber = int.parse(val.toString());
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Phone Number",
                    ),
                  ),
                  MyButton(
                      label: "Edit",
                      callback: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
