import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../helpers/api_helper.dart';
import '../../modals/random_user.dart';

class LazyLoadingScreen extends StatefulWidget {
  @override
  _LazyLoadingScreenState createState() => _LazyLoadingScreenState();
}

class _LazyLoadingScreenState extends State<LazyLoadingScreen> {
  List<RandomUser>? comments = [];
  int counter = 2;
  bool isLoadingPage = false;
  final ScrollController _scrollController = ScrollController();

  getData() async {
    List<RandomUser>? data = await APIHelper.apiHelper.fetchRandomUserData(pageId: 1);

    comments = data;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      // print(_scrollController.position.pixels);

      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // print(_scrollController.position.maxScrollExtent);

        _getMoreData();
      }
    });
  }

  _getMoreData() async {
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
      appBar: AppBar(
        title: const Text("Lazy Loading"),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemExtent: 80,
        itemBuilder: (context, index) {
          if (index == comments!.length) {
            return const CupertinoActivityIndicator();
          }
          return ListTile(
            title: Text(comments![index].name),
            subtitle: Text(comments![index].email),
            leading: ClipOval(child: Image.network(comments![index].photo, height: 50, width: 50)),
          );
        },
        itemCount: comments!.length + 1,
      ),
    );
  }
}

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/api_helper.dart';
import 'package:training_app/modals/random_user.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class LazyLoadingScreen extends StatefulWidget {
  const LazyLoadingScreen({Key? key}) : super(key: key);

  @override
  State<LazyLoadingScreen> createState() => _LazyLoadingScreenState();
}

class _LazyLoadingScreenState extends State<LazyLoadingScreen> {
  List<RandomUser>? comments = [];
  int counter = 2;
  bool isLoadingPage = false;
  ScrollController scrollController = ScrollController();

  getData() async {
    List<RandomUser>? data =
        await APIHelper.apiHelper.fetchRandomUserData(pageId: 1);

    comments = data;

    setState(() {});
  }

  initState() {
    super.initState();

    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("Mounted: ${mounted}")));
        // print(Stream.value("ok")); //value convert into stream.
        getData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: "Lazy Loading"),
        body: LazyLoadScrollView(
            child: ListView(
              controller: scrollController,
              children: [
                Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: comments!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(comments![index].name),
                          subtitle: Text(comments![index].email),
                          leading: ClipOval(
                              child: Image.network(comments![index].photo,
                                  height: 50, width: 50)),
                        );
                      },
                    ),
                    (isLoadingPage)
                        ? const CupertinoActivityIndicator(
                            color: Colors.tealAccent,
                            radius: 20,
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
            onEndOfPage: () async {
              setState(() {
                isLoadingPage = true;
              });

              List<RandomUser>? data = await APIHelper.apiHelper
                  .fetchRandomUserData(pageId: counter);

              data!.map((e) => comments!.add(e)).toList();

              counter++;

              print(counter);

              setState(() {
                isLoadingPage = false;
              });
            }));
  }
}

*/
/*RefreshIndicator(
                child: Container(
                  height: 700,
                  child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, index) => Container(
                      height: 10,
                      child: Text(index.toString()),
                    ),
                  ),
                ),
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 3));
                }),*/ /*

*/
/*Container(
              height: 500,
              child: StreamBuilder(
                stream:
                    Stream.fromFuture(APIHelper.apiHelper.fetchCommentData()),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  List<Comment>? commentList = snapshot.data as List<Comment>?;

                  return ListView.builder(
                    itemCount: commentList!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(commentList[index].name),
                        subtitle: Text(commentList[index].email),
                      );
                    },
                  );
                },
              ),
            ),*/
