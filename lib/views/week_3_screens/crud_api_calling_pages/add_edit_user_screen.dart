import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_app/helpers/api_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';
import '../../../modals/user.dart';

class AddEditUserScreen extends StatefulWidget {
  User? user;
  AddEditUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  String imagePath = "";
  XFile? image;
  User? user;

  @override
  void initState() {
    user = widget.user as User;
    nameController.text = user!.name;
    emailController.text = user!.email;
    imagePath = user!.profilePic;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "User"),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  onTap: () async {
                    XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

                    if (pickedImage != null) {
                      setState(() {
                        imagePath = "";
                        image = pickedImage;
                      });
                    }
                    print(imagePath);
                    print(image);
                  },
                  child: (imagePath == "")
                      ? (image == null)
                          ? Container(
                              height: 150,
                              width: 150,
                              color: Colors.grey,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              ),
                            )
                          : Image.file(File(image!.path), height: 150, width: 150)
                      : Image.network(imagePath, height: 150, width: 150),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                  hintText: "Enter Name",
                  validateType: "name",
                  textInputType: TextInputType.name,
                  controller: nameController,
                  onSubmit: () {}),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  hintText: "Enter Email",
                  validateType: "email",
                  textInputType: TextInputType.emailAddress,
                  controller: emailController,
                  onSubmit: () {}),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  label: "Submit",
                  callback: () async {
                    if (formKey.currentState!.validate()) {
                      if (user!.isAdd == true) {
                        if (image != null) {
                          String? msg = await APIHelper.apiHelper.addUserWithProfilePic(
                            profilePic: image!.path,
                            name: nameController.text,
                            email: emailController.text,
                          );

                          if (msg == "Email already exits.") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Email already exist..")));
                          } else if (msg == "User add successfully.") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("User added sucessfully")));
                          }
                        } else {
                          await APIHelper.apiHelper.addUserWithOutProfilePic(
                            name: nameController.text,
                            email: emailController.text,
                          );
                        }
                      } else {
                        await APIHelper.apiHelper.editUserData(
                            user: User(
                                userId: user!.userId,
                                name: nameController.text,
                                email: emailController.text,
                                profilePic: user!.profilePic,
                                createDate: user!.createDate));

                        if (image != null) {
                          await APIHelper.apiHelper
                              .editUserProfilePicData(profilePic: image!.path, userId: user!.userId);
                        }
                      }

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
