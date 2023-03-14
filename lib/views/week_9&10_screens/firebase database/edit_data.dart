import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';
import 'package:training_app/views/week_9&10_screens/firebase%20database/add_data.dart';
import '../../../helpers/firestore_database_helper.dart';
import '../../../modals/todo.dart';

class EditScreen extends StatefulWidget {
  TODO todo;
  EditScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController doneDateController = TextEditingController();
  DateTime? andDateTime = DateTime.now();
  DateTime selectedAndDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  Status status = Status.Pending;

  @override
  void initState() {
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description;
    doneDateController.text = widget.todo.doneDate;
    selectedAndDate = DateTime(int.parse(widget.todo.doneDate.split("-").last),
        int.parse(widget.todo.doneDate.split("-")[1]), int.parse(widget.todo.doneDate.split("-").first));
    status = Status.values.byName(widget.todo.status);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Edit Data"),
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
                  label: "Edit Data",
                  callback: () async {
                    if (formKey.currentState!.validate()) {
                      Response response = await FireStoreDataBaseHelper.fireStoreDataBaseHelper.updateData(
                          todo: TODO(
                              id: widget.todo.id,
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
