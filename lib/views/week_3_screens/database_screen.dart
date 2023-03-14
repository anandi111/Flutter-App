import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/db_helper.dart';
import 'package:training_app/modals/student.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/views/week_3_screens/edit_database_screen.dart';

class DataBaseScreen extends StatefulWidget {
  const DataBaseScreen({Key? key}) : super(key: key);

  @override
  State<DataBaseScreen> createState() => _DataBaseScreenState();
}

class _DataBaseScreenState extends State<DataBaseScreen> {
  var fetchData = DBHelper.dbHelper.fetchAllData();

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Database"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "add_database_screen").then((value) => setState(() {
                fetchData = DBHelper.dbHelper.fetchAllData();
              }));
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {
                fetchData = DBHelper.dbHelper.fetchAllData();
              }));
        },
        child: FutureBuilder(
          future: fetchData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child:
                    Text(snapshot.error.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              );
            } else if (snapshot.hasData) {
              List<Student> studentList = snapshot.data as List<Student>;
              print(studentList);
              return ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (context, index) => ListTile(
                  leading: ClipOval(
                    child: (studentList[index].photo == "no_image")
                        ? Container(
                            height: 50,
                            width: 50,
                            color: Colors.grey,
                            child: const Center(child: Icon(Icons.person)),
                          )
                        : Image.file(File(studentList[index].photo as String),
                            fit: BoxFit.cover, height: 50, width: 50),
                  ),
                  title: Text(studentList[index].name),
                  subtitle: Text(studentList[index].email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditDataBaseScreen(
                                      name: studentList[index].name,
                                      photo: studentList[index].photo,
                                      email: studentList[index].email,
                                      number: studentList[index].phoneNumber,
                                      password: studentList[index].password),
                                )).then((value) => setState(() {
                                  fetchData = DBHelper.dbHelper.fetchAllData();
                                }));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    height: 220,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            offset: const Offset(4, 2),
                                            spreadRadius: 7,
                                            blurRadius: 10)
                                      ],
                                      color: CupertinoColors.darkBackgroundGray,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          "Delete",
                                          style:
                                              TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                                        ),
                                        const Text(
                                          "Delete 1 item?",
                                          style: TextStyle(fontSize: 20, color: Colors.white),
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
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () async {
                                                  DBHelper.dbHelper.deleteData(id: studentList[index].id);

                                                  setState(() {
                                                    fetchData = DBHelper.dbHelper.fetchAllData();
                                                  });

                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
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
                                });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.tealAccent,
              ),
            );
          },
        ),
      ),
    );
  }
}
