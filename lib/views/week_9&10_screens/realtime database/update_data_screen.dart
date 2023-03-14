import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_app/helpers/cloud_firestore.dart';
import 'package:training_app/helpers/realtime_database_helper.dart';
import 'package:training_app/modals/employee.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';
import '../../week_2_screens/property_pages/inbuilt_properties_screen.dart';

class UpdateDataScreen extends StatefulWidget {
  Employee employee;
  String url;
  UpdateDataScreen({Key? key, required this.employee, required this.url}) : super(key: key);

  @override
  State<UpdateDataScreen> createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
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
    nameController.text = widget.employee.name;
    emailController.text = widget.employee.email;
    numberController.text = widget.employee.number;
    designationController.text = widget.employee.designation;
    salaryController.text = widget.employee.salary.toString();
    gender = Gender.values.byName(widget.employee.gender);
    path = widget.url;
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
                      : Image.network(
                          path!,
                          height: 100,
                          width: 100,
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
                  label: "Edit Data",
                  callback: () async {
                    if (formKey.currentState!.validate()) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: SizedBox(
                                height: 200, width: 200, child: const Center(child: CircularProgressIndicator())),
                          );
                        },
                      );

                      if (xFile != null) {
                        await CloudFireStoreHelper.cloudFireStoreHelper
                            .addFile(file: File(xFile!.path), fileName: fileName);

                        path = await CloudFireStoreHelper.cloudFireStoreHelper.displayFile(fileName: fileName);
                      }

                      await RealTimeDataBaseHelper.realTimeDataBase.update(
                          employee: Employee(
                            id: widget.employee.id,
                            name: nameController.text,
                            email: emailController.text,
                            number: numberController.text,
                            designation: designationController.text,
                            salary: int.parse(salaryController.text),
                            gender: gender.name,
                          ),
                          path: path!);

                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
