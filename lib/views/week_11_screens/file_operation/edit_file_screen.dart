import 'dart:io';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/file_operation_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';

class EditFileScreen extends StatefulWidget {
  String fileName;
  String msg;
  File file;
  EditFileScreen({Key? key, required this.fileName, required this.msg, required this.file}) : super(key: key);

  @override
  State<EditFileScreen> createState() => _EditFileScreenState();
}

class _EditFileScreenState extends State<EditFileScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.fileName;
    msgController.text = widget.msg;
    super.initState();
  }

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
                    onSubmit: () async {}),
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
                    label: "Edit",
                    callback: () async {
                      if (formKey.currentState!.validate()) {
                        if (widget.fileName != titleController.text) {
                          print(widget.file.path);
                          await FileOperationHelper.fileOperationHelper
                              .renameFile(oldFile: widget.file, newFileName: titleController.text);
                        }

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
