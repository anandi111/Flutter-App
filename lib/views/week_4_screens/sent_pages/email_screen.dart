import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';

import '../../../helpers/firebase_helper.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  List<String> attechments = [];
  var formkey = GlobalKey<FormState>();
  bool? isSent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Email"),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              MyTextField(
                  hintText: "Enter email address",
                  validateType: "email",
                  textInputType: TextInputType.emailAddress,
                  controller: emailController,
                  onSubmit: () {}),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                  hintText: "Enter subject",
                  validateType: "subject",
                  textInputType: TextInputType.name,
                  controller: subjectController,
                  onSubmit: () {}),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter message",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
                controller: msgController,
              ),
              const SizedBox(
                height: 30,
              ),
              (attechments.isEmpty)
                  ? Container(
                      height: 100,
                      width: 350,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                          child: Text(
                        "No Attechments",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                    )
                  : SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: attechments.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: (attechments[index].split(".").last == "jpg" ||
                                    attechments[index].split(".").last == "jpeg" ||
                                    attechments[index].split(".").last == "png")
                                ? GestureDetector(
                                    onLongPress: () {
                                      setState(() {
                                        attechments.remove(attechments[index]);
                                      });
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Image.file(
                                          File(attechments[index]),
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )),
                                  )
                                : GestureDetector(
                                    onLongPress: () {
                                      setState(() {
                                        attechments.remove(attechments[index]);
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey,
                                      ),
                                      child: Center(
                                        child: Text(attechments[index].split(".").last),
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  label: "Attechments",
                  callback: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
                    print(result);

                    if (result != null) {
                      setState(() {
                        for (int i = 0; i < result.files.length; i++) {
                          attechments.add(result.files[i].path as String);
                        }
                      });
                    }
                  }),
              MyButton(
                  label: "Mail",
                  callback: () async {
                    if (formkey.currentState!.validate()) {
                      ///flutter email sender....
                      Email email = Email(
                        body: msgController.text,
                        subject: subjectController.text,
                        recipients: [emailController.text],
                        attachmentPaths: attechments as List<String>?,
                        isHTML: false,
                      );
                      print(email.recipients);
                      await FlutterEmailSender.send(email);
                    }
                  }),
              MyButton(
                  label: "Mail using App",
                  callback: () async {
                    if (formkey.currentState!.validate()) {
                      ///using mailer....
                      UserCredential? user = await FirebaseHelper.firebaseHelper.signInWithGoogle();

                      String? acessTocken = user!.credential!.accessToken;
                      String? email = user.user!.email;

                      final smtpServer = gmailSaslXoauth2(email!, acessTocken!);

                      final message = Message()
                        ..from = const Address("anandi99796@gmail.com", 'anand')
                        ..recipients.add(emailController.text)
                        ..subject = subjectController.text
                        ..text = msgController.text
                        ..attachments = attechments
                            .map(
                              (e) => FileAttachment(File(e)),
                            )
                            .toList();

                      setState(() {
                        isSent = true;
                      });

                      final sendReport = await send(message, smtpServer).then((value) {
                        setState(() {
                          isSent = null;
                        });

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text("Mail sent sucessfully...")));
                      });
                    }
                  }),
              (isSent == true) ? const CircularProgressIndicator() : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
