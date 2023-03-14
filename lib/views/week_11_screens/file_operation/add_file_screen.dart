import 'package:flutter/material.dart';
import 'package:training_app/helpers/file_operation_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';

class AddFileScreen extends StatefulWidget {
  const AddFileScreen({Key? key}) : super(key: key);

  @override
  State<AddFileScreen> createState() => _AddFileScreenState();
}

class _AddFileScreenState extends State<AddFileScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Add File"),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                MyTextField(
                    hintText: "Enter Title",
                    validateType: "fileName",
                    textInputType: TextInputType.text,
                    controller: titleController,
                    onSubmit: () {}),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: msgController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter Massage",
                  ),
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please fill it first...";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                MyButton(
                    label: "Save",
                    callback: () async {
                      if (formKey.currentState!.validate()) {
                        await FileOperationHelper.fileOperationHelper
                            .saveFile(fileName: titleController.text, msg: msgController.text);

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
