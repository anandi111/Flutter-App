import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../helpers/db_helper.dart';
import '../../utils/appbar.dart';
import '../../utils/buttons.dart';
import '../../utils/textfield.dart';

class AddDataBaseScreen extends StatefulWidget {
  const AddDataBaseScreen({Key? key}) : super(key: key);

  @override
  State<AddDataBaseScreen> createState() => _AddDataBaseScreenState();
}

class _AddDataBaseScreenState extends State<AddDataBaseScreen> {
  final formKey = GlobalKey<FormState>();
  Uint8List? photo;
  String name = "";
  String email = "";
  int number = 0;
  String password = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Insert Data"),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    XFile? pickedImage =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedImage != null) {
                      photo = await pickedImage.readAsBytes();

                      print(photo);

                      setState(() {
                        image = pickedImage;
                      });
                    }
                  },
                  child: ClipOval(
                    child: (image != null)
                        ? Image.memory(
                            photo!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            color: Colors.grey,
                            child:
                                const Icon(Icons.person, color: Colors.white),
                          ),
                  ),
                ),
                MyTextField(
                    onSubmit: () {
                      setState(() {
                        name = nameController.text;
                      });
                    },
                    textInputType: TextInputType.name,
                    hintText: "Enter name",
                    validateType: "name",
                    controller: nameController),
                MyTextField(
                    onSubmit: () {
                      setState(() {
                        email = emailController.text;
                      });
                    },
                    textInputType: TextInputType.emailAddress,
                    hintText: "Enter email address",
                    validateType: "email",
                    controller: emailController),
                MyTextField(
                    onSubmit: () {
                      setState(() {
                        number = int.parse(numberController.text);
                      });
                    },
                    textInputType: TextInputType.number,
                    hintText: "Enter phone number",
                    validateType: "number",
                    controller: numberController),
                MyTextField(
                    onSubmit: () {
                      setState(() {
                        password = passwordController.text;
                      });
                    },
                    textInputType: TextInputType.name,
                    hintText: "Enter password",
                    validateType: "password",
                    controller: passwordController),
                MyButton(
                    label: "Insert",
                    callback: () async {
                      if (formKey.currentState!.validate()) {
                        if (image != null) {
                          await DBHelper.dbHelper.insertData(
                              id: int.parse(numberController.text),
                              photo: image!.path,
                              name: nameController.text,
                              email: emailController.text,
                              phoneNumber: int.parse(numberController.text),
                              password: passwordController.text);
                        } else {
                          await DBHelper.dbHelper.insertData(
                              id: int.parse(numberController.text),
                              photo: "no_image",
                              name: nameController.text,
                              email: emailController.text,
                              phoneNumber: int.parse(numberController.text),
                              password: passwordController.text);
                        }

                        Navigator.pop(context);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
