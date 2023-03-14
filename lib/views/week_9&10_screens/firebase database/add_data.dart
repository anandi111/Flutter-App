import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_app/helpers/firestore_database_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';

import '../../../modals/todo.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

enum Status { Done, Pending }

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController doneDateController = TextEditingController();
  DateTime? andDateTime = DateTime.now();
  DateTime selectedAndDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  Status status = Status.Pending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Add Data"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              MyTextField(
                  hintText: "Task Title",
                  validateType: "title",
                  textInputType: TextInputType.text,
                  controller: titleController,
                  onSubmit: () {}),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  hintText: "Task Description",
                  validateType: "description",
                  textInputType: TextInputType.text,
                  controller: descriptionController,
                  onSubmit: () {}),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: doneDateController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please fill it first...";
                  } else {
                    return null;
                  }
                },
                onTap: () async {
                  andDateTime = await showDatePicker(
                    context: context,
                    initialDate: selectedAndDate,
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2030),
                  );

                  if (andDateTime != null) {
                    setState(() {
                      selectedAndDate = andDateTime!;
                      doneDateController.text = "${andDateTime!.day}-${andDateTime!.month}-${andDateTime!.year}";
                    });
                  }

                  print(andDateTime);
                },
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText: "Done Date",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Status",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              RadioListTile(
                  value: Status.Done,
                  groupValue: status,
                  onChanged: (val) {
                    setState(() {
                      status = Status.Done;
                    });
                  },
                  title: const Text("Done")),
              RadioListTile(
                  value: Status.Pending,
                  groupValue: status,
                  onChanged: (val) {
                    setState(() {
                      setState(() {
                        status = Status.Pending;
                      });
                    });
                  },
                  title: const Text("Pending")),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  label: "Add Data",
                  callback: () async {
                    if (formKey.currentState!.validate()) {
                      Response response = await FireStoreDataBaseHelper.fireStoreDataBaseHelper.addData(
                          todo: TODO(
                              id: "1",
                              title: titleController.text,
                              description: descriptionController.text,
                              createDate: "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                              doneDate: doneDateController.text,
                              status: status.name));

                      if (response.code == 200) {
                        Fluttertoast.showToast(msg: response.message.toString());
                      } else {
                        Fluttertoast.showToast(msg: response.message.toString());
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
