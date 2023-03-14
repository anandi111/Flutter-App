import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:share_plus/share_plus.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/utils/textfield.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  TextEditingController msgController = TextEditingController();
  List<String> attechments = [];
  List<XFile> xFileList = [];
  FlutterShareMe flutterShareMe = FlutterShareMe();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Share"),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyTextField(
                  hintText: "Enter your msg",
                  validateType: "msg",
                  textInputType: TextInputType.text,
                  controller: msgController,
                  onSubmit: () {}),
              const SizedBox(
                height: 50,
              ),
              (attechments.length == 0)
                  ? Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "No Attechments",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    )
                  : Container(
                      height: 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: attechments.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: () {
                              setState(() {
                                xFileList.removeAt(index);
                                attechments.removeAt(index);
                              });
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey),
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: (attechments[index].split(".").last == "jpg" ||
                                      attechments[index].split(".").last == "jpeg" ||
                                      attechments[index].split(".").last == "png")
                                  ? Image.file(
                                      File(attechments[index]),
                                      fit: BoxFit.fill,
                                    )
                                  : Text(attechments[index].split(".").last.toString()),
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  label: "Take Files",
                  callback: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                    );

                    if (result != null) {
                      setState(() {
                        for (int i = 0; i < result.files.length; i++) {
                          xFileList.clear();
                          attechments.clear();

                          xFileList.add(XFile(result.files[i].path as String));

                          attechments.add(result.files[i].path as String);
                        }
                      });
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  label: "Share with default intent",
                  callback: () {
                    if (msgController.text.isEmpty && xFileList.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "Enter something for sharing...",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    } else {
                      if (xFileList.isEmpty) {
                        Share.share(msgController.text);
                      } else {
                        Share.shareXFiles(text: msgController.text, xFileList);
                      }
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () async {
                        if (attechments.isEmpty) {
                          await flutterShareMe.shareToWhatsApp(msg: msgController.text);
                        } else {
                          await flutterShareMe.shareToWhatsApp(msg: msgController.text, imagePath: attechments.first);
                        }
                      },
                      iconSize: 50,
                      icon: const Icon(
                        Icons.whatsapp,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () async {
                        if (msgController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("When you are share content into facebook massage is required..",
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          await flutterShareMe.shareToFacebook(
                              msg: msgController.text,
                              url:
                                  "https://images.unsplash.com/photo-1595164788351-968f153c2b86?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80");
                        }
                      },
                      iconSize: 50,
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      )),
                  InkWell(
                    onTap: () async {
                      if (attechments.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("When you are share content into instagram file is required..",
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        await flutterShareMe.shareToInstagram(filePath: attechments.first);
                      }
                    },
                    child: Image.network("https://cdn-icons-png.flaticon.com/512/3621/3621435.png",
                        height: 60, width: 60, fit: BoxFit.fill),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
