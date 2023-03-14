import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:training_app/helpers/file_operation_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/views/week_11_screens/file_operation/edit_file_screen.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key}) : super(key: key);

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "File Operation"),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("add_file_screen").then((value) => setState(() {}));
          },
          backgroundColor: Colors.lightGreen,
          child: const Icon(Icons.add)),
      body: FutureBuilder(
        future: FileOperationHelper.fileOperationHelper.getAllFilePath(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            List<String>? allFilePathList = snapshot.data as List<String>?;

            return ListView.builder(
              itemCount: allFilePathList!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onLongPress: () async {
                    print(allFilePathList[index]);
                    await OpenFilex.open(allFilePathList[index]);
                  },
                  onTap: () async {
                    String msg = await FileOperationHelper.fileOperationHelper
                        .readFile(fileName: allFilePathList[index].split("/").last.split(".").first);

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(allFilePathList[index].split("/").last.split(".").first),
                          content: SingleChildScrollView(child: Text(msg)),
                        );
                      },
                    );
                  },
                  title: Text(allFilePathList[index].split("/").last.split(".").first),
                  leading: const Icon(Icons.file_open_rounded, color: Colors.amber),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          String msg = await FileOperationHelper.fileOperationHelper
                              .readFile(fileName: allFilePathList[index].split("/").last.split(".").first);

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditFileScreen(
                                    fileName: allFilePathList[index].split("/").last.split(".").first,
                                    msg: msg,
                                    file: File(allFilePathList[index])),
                              )).then((value) => setState(() {}));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    height: 220,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          "Delete note",
                                          style:
                                              TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                                        ),
                                        const Text(
                                          "Delete 1 item?",
                                          style: TextStyle(fontSize: 20, color: Colors.black),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(50),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () async {
                                                  FileOperationHelper.fileOperationHelper
                                                      .deleteFile(filePath: allFilePathList[index]);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(50),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }).then((value) => setState(() {}));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
