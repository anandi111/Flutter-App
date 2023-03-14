import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/api_helper.dart';
import 'package:training_app/modals/random_user.dart';
import 'package:training_app/utils/appbar.dart';

class PullToRefreshScreen extends StatefulWidget {
  const PullToRefreshScreen({Key? key}) : super(key: key);

  @override
  State<PullToRefreshScreen> createState() => _PullToRefreshScreenState();
}

class _PullToRefreshScreenState extends State<PullToRefreshScreen> {
  List<RandomUser>? comments = [];
  int counter = 2;
  bool isLoadingPage = true;

  getData() async {
    List<RandomUser>? data = await APIHelper.apiHelper.fetchRandomUserData(pageId: 1);

    comments = data;

    isLoadingPage = false;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  _getMoreData() async {
    comments!.clear();

    List<RandomUser>? data = await APIHelper.apiHelper.fetchRandomUserData(pageId: counter);
    print(data);

    data!.map((e) => comments!.add(e)).toList();

    counter++;

    print(counter);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Pull to Refresh"),
      body: RefreshIndicator(
        color: Colors.amber,
        onRefresh: () {
          return _getMoreData();
        },
        child: (comments!.isEmpty)
            ? const Center(
                child: CupertinoActivityIndicator(
                color: Colors.amber,
                radius: 20,
              ))
            : ListView.builder(
                itemExtent: 80,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(comments![index].name),
                    subtitle: Text(comments![index].email),
                    leading: ClipOval(child: Image.network(comments![index].photo, height: 50, width: 50)),
                  );
                },
                itemCount: comments!.length,
              ),
      ),
    );
  }
}
