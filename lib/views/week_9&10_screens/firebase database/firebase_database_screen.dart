import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_app/helpers/firestore_database_helper.dart';
import 'package:training_app/modals/todo.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/views/week_9&10_screens/firebase%20database/edit_data.dart';

class FireBaseDataBaseScreen extends StatefulWidget {
  const FireBaseDataBaseScreen({Key? key}) : super(key: key);

  @override
  State<FireBaseDataBaseScreen> createState() => _FireBaseDataBaseScreenState();
}

class _FireBaseDataBaseScreenState extends State<FireBaseDataBaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "FireBase DataBase"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("add_data_screen");
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FireStoreDataBaseHelper.fireStoreDataBaseHelper.readData(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
            );
          } else if (snapshot.hasData) {
            List<TODO> todoList = FireStoreDataBaseHelper.fireStoreDataBaseHelper.getData(data: snapshot.data!.docs);

            return Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(top: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Task: ${todoList[index].id}",
                                  style:
                                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditScreen(todo: todoList[index]),
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () async {
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
                                                  style: TextStyle(
                                                      fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
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
                                                          Response response = await FireStoreDataBaseHelper
                                                              .fireStoreDataBaseHelper
                                                              .deleteData(id: todoList[index].id);

                                                          if (response.code == 200) {
                                                            Fluttertoast.showToast(msg: response.message.toString());
                                                          } else {
                                                            Fluttertoast.showToast(msg: response.message.toString());
                                                          }
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
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Title: ${todoList[index].title}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Description: ${todoList[index].description}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Create Date: ${todoList[index].createDate}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Done Date: ${todoList[index].doneDate}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Status: ${todoList[index].status}"),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
