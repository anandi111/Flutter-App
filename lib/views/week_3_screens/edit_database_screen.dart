import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../helpers/db_helper.dart';
import '../../utils/appbar.dart';
import '../../utils/buttons.dart';
import '../../utils/textfield.dart';

class EditDataBaseScreen extends StatefulWidget {
  EditDataBaseScreen(
      {Key? key,
      required this.name,
      required this.email,
      required this.number,
      required this.password,
      this.photo})
      : super(key: key);
  String name;
  String email;
  int number;
  String password;
  String? photo;

  @override
  State<EditDataBaseScreen> createState() => _EditDataBaseScreenState();
}

class _EditDataBaseScreenState extends State<EditDataBaseScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;
  String? imagePath;

  @override
  initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    numberController.text = widget.number.toString();
    passwordController.text = widget.password;
    imagePath = widget.photo;
  }

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
                      setState(() {
                        image = pickedImage;
                        imagePath = pickedImage.path;
                      });
                    }
                  },
                  child: ClipOval(
                    child: (imagePath != "no_image")
                        ? Image.file(
                            File(imagePath!),
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
                    onSubmit: () {},
                    textInputType: TextInputType.name,
                    hintText: "Enter name",
                    validateType: "name",
                    controller: nameController),
                MyTextField(
                    onSubmit: () {},
                    textInputType: TextInputType.emailAddress,
                    hintText: "Enter email address",
                    validateType: "email",
                    controller: emailController),
                MyTextField(
                    onSubmit: () {},
                    textInputType: TextInputType.number,
                    hintText: "Enter phone number",
                    validateType: "number",
                    controller: numberController),
                MyTextField(
                    onSubmit: () {},
                    textInputType: TextInputType.name,
                    hintText: "Enter password",
                    validateType: "password",
                    controller: passwordController),
                MyButton(
                    label: "Update",
                    callback: () {
                      if (formKey.currentState!.validate()) {
                        DBHelper.dbHelper.updateData(
                            id: int.parse(numberController.text),
                            photo: imagePath!,
                            name: nameController.text,
                            email: emailController.text,
                            phoneNumber: int.parse(numberController.text),
                            password: passwordController.text);
                        print("Updation done..");

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
