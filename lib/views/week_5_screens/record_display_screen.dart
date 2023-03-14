import 'package:flutter/material.dart';
import 'package:training_app/helpers/record_db_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/views/week_5_screens/record_screen.dart';

class RecordDisplayScreen extends StatefulWidget {
  const RecordDisplayScreen({Key? key}) : super(key: key);

  @override
  State<RecordDisplayScreen> createState() => _RecordDisplayScreenState();
}

class _RecordDisplayScreenState extends State<RecordDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Recording List"),
      body: FutureBuilder(
        future: RecordDBHelper.recordDBHelper.fetchAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> data = snapshot.data as List<Map<String, dynamic>>;

            return Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecordScreen(list: data, index: index),
                          ));
                        },
                        onLongPress: () async {
                          await RecordDBHelper.recordDBHelper.deleteData(path: data[index]["path"]);

                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        tileColor: Colors.indigo,
                        leading: const Icon(
                          Icons.mic,
                          size: 30,
                        ),
                        title: Text(data[index]["path"].toString().split("/").last.split(".").first),
                        subtitle: const Text("no artist"),
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
