import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_app/helpers/cloud_firestore.dart';
import 'package:training_app/helpers/realtime_database_helper.dart';
import 'package:training_app/modals/employee.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';
import '../../week_2_screens/property_pages/inbuilt_properties_screen.dart';

class RealTimeDataBaseScreen extends StatefulWidget {
  const RealTimeDataBaseScreen({Key? key}) : super(key: key);

  @override
  State<RealTimeDataBaseScreen> createState() => _RealTimeDataBaseScreenState();
}

class _RealTimeDataBaseScreenState extends State<RealTimeDataBaseScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  Gender gender = Gender.Male;
  final formKey = GlobalKey<FormState>();
  XFile? xFile;
  ImagePicker imagePicker = ImagePicker();
  String fileName = "";
  String? path = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "RealTime DataBase"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    setState(() {
                      xFile = pickedFile;
                      fileName = pickedFile.name.split(".").first;
                    });
                  }
                },
                child: ClipOval(
                  child: (xFile != null)
                      ? Image.file(
                          File(xFile!.path),
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  hintText: "Enter Name",
                  validateType: "name",
                  textInputType: TextInputType.text,
                  controller: nameController,
                  onSubmit: () {}),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  hintText: "Enter Email",
                  validateType: "email",
                  textInputType: TextInputType.emailAddress,
                  controller: emailController,
                  onSubmit: () {}),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  hintText: "Enter Mobile no.",
                  validateType: "number",
                  textInputType: TextInputType.number,
                  controller: numberController,
                  onSubmit: () {}),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  hintText: "Enter Designation",
                  validateType: "designation",
                  textInputType: TextInputType.text,
                  controller: designationController,
                  onSubmit: () {}),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  hintText: "Enter Salary",
                  validateType: "salary",
                  textInputType: TextInputType.number,
                  controller: salaryController,
                  onSubmit: () {}),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Gender",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              RadioListTile(
                value: Gender.Male,
                groupValue: gender,
                onChanged: (val) {
                  setState(() {
                    gender = Gender.Male;
                  });
                },
                title: const Text("Male"),
              ),
              RadioListTile(
                value: Gender.Female,
                groupValue: gender,
                onChanged: (val) {
                  setState(() {
                    gender = Gender.Female;
                  });
                },
                title: const Text("Female"),
              ),
              RadioListTile(
                value: Gender.Other,
                groupValue: gender,
                onChanged: (val) {
                  setState(() {
                    gender = Gender.Other;
                  });
                },
                title: const Text("Other"),
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  label: "Add Data",
                  callback: () async {
                    if (formKey.currentState!.validate()) {
                      if (xFile != null) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content:
                                  SizedBox(height: 200, width: 200, child: Center(child: CircularProgressIndicator())),
                            );
                          },
                        );

                        await CloudFireStoreHelper.cloudFireStoreHelper
                            .addFile(file: File(xFile!.path), fileName: fileName);

                        path = await CloudFireStoreHelper.cloudFireStoreHelper.displayFile(fileName: fileName);

                        RealTimeDataBaseHelper.realTimeDataBase.writeByPush(
                            employee: Employee(
                                id: "1",
                                name: nameController.text,
                                email: emailController.text,
                                number: numberController.text,
                                designation: designationController.text,
                                salary: int.parse(salaryController.text),
                                gender: gender.name),
                            path: path!);

                        Navigator.pop(context);
                        Navigator.of(context).pushReplacementNamed("read_data_screen");
                      } else {
                        Fluttertoast.showToast(
                            msg: "Picture is not provided..", gravity: ToastGravity.TOP, textColor: Colors.red);
                      }
                    }
                  }),
              MyButton(
                  label: "View Data",
                  callback: () {
                    Navigator.pushNamed(context, "read_data_screen");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
