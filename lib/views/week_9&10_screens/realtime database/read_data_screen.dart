import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/realtime_database_helper.dart';
import 'package:training_app/modals/employee.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/views/week_9&10_screens/realtime%20database/update_data_screen.dart';

class ReadDataScreen extends StatefulWidget {
  const ReadDataScreen({Key? key}) : super(key: key);

  @override
  State<ReadDataScreen> createState() => _ReadDataScreenState();
}

class _ReadDataScreenState extends State<ReadDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Read Data"),
      body: FirebaseAnimatedList(
        query: RealTimeDataBaseHelper.realTimeDataBase.read(),
        defaultChild: const Center(child: CircularProgressIndicator()),
        itemBuilder: (context, snapshot, animation, index) {
          Map data = snapshot.value as Map;
          Employee employee = Employee(
              id: data["id"],
              name: data["name"],
              email: data["email"],
              number: data["number"],
              designation: data["designation"],
              salary: data["salary"],
              gender: data["gender"]);

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipOval(
                            child: Image.network(
                          "${data["path"]}",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        )),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateDataScreen(employee: employee, url: data["path"]),
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
                                                    await RealTimeDataBaseHelper.realTimeDataBase
                                                        .delete(id: employee.id);
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
                    Row(
                      children: [
                        const Icon(Icons.done),
                        Text(
                          "   ${employee.id}",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.person),
                        Text("   ${employee.name}"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.mail),
                        Text("   ${employee.email}"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.phone),
                        Text("   ${employee.number}"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.shopping_bag),
                        const Spacer(),
                        SizedBox(
                            width: 310,
                            child: Text(
                              employee.designation,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.start,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.currency_rupee),
                        Text("   ${employee.salary}"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.transgender),
                        Text("   ${employee.gender}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
