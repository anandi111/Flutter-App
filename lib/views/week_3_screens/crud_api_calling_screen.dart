import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/api_helper.dart';
import 'package:training_app/modals/userlist_model.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/views/week_3_screens/crud_api_calling_pages/add_edit_user_screen.dart';
import '../../modals/user.dart';

class CRUDAPICallingScreen extends StatefulWidget {
  const CRUDAPICallingScreen({Key? key}) : super(key: key);

  @override
  State<CRUDAPICallingScreen> createState() => _CRUDAPICallingScreenState();
}

class _CRUDAPICallingScreenState extends State<CRUDAPICallingScreen> {
  deleteBottomSheet({required int id}) {
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
                    color: Colors.grey.withOpacity(0.2), offset: const Offset(4, 2), spreadRadius: 7, blurRadius: 10)
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
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
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          await APIHelper.apiHelper.deleteUserData(id: id);

                          setState(() {});

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
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
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
  }

  int valllue = 0;

  getUser() async {
    List<User>? userListModel = await APIHelper.apiHelper.fetchUserData();
    valllue = valllue + 1;

    print(valllue);
    log(valllue.toString());
    debugPrint('movieTitle: $valllue');

    updateUI();
    return userListModel;
  }

  updateUI() {
    // if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "CRUD API Calling"),
      floatingActionButton: FloatingActionButton(
        heroTag: 1,
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditUserScreen(
                    user: User(isAdd: true, userId: 0, name: "", email: "", profilePic: "", createDate: "")),
              ));

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return getUser();
        },
        child: FutureBuilder(
          future: getUser(),
          builder: (context, AsyncSnapshot snapshot) {
            // print(snapshot.data?.status.toString());
            if (snapshot.hasError) {
              return Center(
                  child: Text(snapshot.error.toString(),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)));
            } else if (snapshot.hasData) {
              List<User>? userList = snapshot.data as List<User>?;

              return ListView.builder(
                itemCount: userList!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      User? user = await APIHelper.apiHelper.fetchSingleUserData(id: userList[index].userId);

                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Center(child: Text("Details")),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: (user!.profilePic != "")
                                        ? Image.network(
                                            user.profilePic,
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            height: 150,
                                            width: 150,
                                            color: Colors.grey,
                                            child: const Icon(Icons.person, color: Colors.white),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text("Name: ${user.name}"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text("Email: ${user.email}"),
                                ],
                              ),
                            );
                          });
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: (userList[index].profilePic != "")
                            ? Image.network(userList[index].profilePic)
                            : Container(
                                color: Colors.grey,
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    title: Text(userList[index].name),
                    subtitle: Text(userList[index].email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditUserScreen(
                                        user: User(
                                            isAdd: false,
                                            userId: userList[index].userId,
                                            name: userList[index].name,
                                            email: userList[index].email,
                                            profilePic: userList[index].profilePic,
                                            createDate: userList[index].createDate)),
                                  )).then((value) => setState(() {}));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                        IconButton(
                            onPressed: () async {
                              await deleteBottomSheet(id: userList[index].userId);
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
            } else {
              return const Center(child: CircularProgressIndicator());
            }

            return const Center(
              child: CircularProgressIndicator(),
            );

            // switch (snapshot.connectionState) {
            //   case ConnectionState.waiting:
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   case ConnectionState.done:
            //   default:
            //     if (snapshot.hasError) {
            //       return Center(
            //           child: Text(snapshot.error.toString(),
            //               style: const TextStyle(
            //                   fontSize: 18, fontWeight: FontWeight.w600)));
            //     } else if (snapshot.hasData) {
            //       List<User>? userList = snapshot.data as List<User>?;
            //
            //       return ListView.builder(
            //         itemCount: userList!.length,
            //         itemBuilder: (context, index) {
            //           return ListTile(
            //             onTap: () async {
            //               User? user = await APIHelper.apiHelper
            //                   .fetchSingleUserData(id: userList[index].userId);
            //
            //               showDialog(
            //                   context: context,
            //                   builder: (context) {
            //                     return AlertDialog(
            //                       title: const Center(child: Text("Details")),
            //                       content: Column(
            //                         mainAxisSize: MainAxisSize.min,
            //                         children: [
            //                           ClipRRect(
            //                             borderRadius: BorderRadius.circular(80),
            //                             child: (user!.profilePic != "")
            //                                 ? Image.network(
            //                                     user.profilePic,
            //                                     height: 150,
            //                                     width: 150,
            //                                     fit: BoxFit.cover,
            //                                   )
            //                                 : Container(
            //                                     height: 150,
            //                                     width: 150,
            //                                     color: Colors.grey,
            //                                     child: const Icon(Icons.person,
            //                                         color: Colors.white),
            //                                   ),
            //                           ),
            //                           const SizedBox(
            //                             height: 20,
            //                           ),
            //                           Text("Name: ${user.name}"),
            //                           const SizedBox(
            //                             height: 20,
            //                           ),
            //                           Text("Email: ${user.email}"),
            //                         ],
            //                       ),
            //                     );
            //                   });
            //             },
            //             leading: ClipRRect(
            //               borderRadius: BorderRadius.circular(50),
            //               child: SizedBox(
            //                 height: 50,
            //                 width: 50,
            //                 child: (userList[index].profilePic != "")
            //                     ? Image.network(userList[index].profilePic)
            //                     : Container(
            //                         color: Colors.grey,
            //                         child: const Icon(
            //                           Icons.person,
            //                           color: Colors.white,
            //                         ),
            //                       ),
            //               ),
            //             ),
            //             title: Text(userList[index].name),
            //             subtitle: Text(userList[index].email),
            //             trailing: Row(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 IconButton(
            //                     onPressed: () {
            //                       Navigator.pushNamed(
            //                               context, "add_edit_user_screen",
            //                               arguments: User(
            //                                   isAdd: false,
            //                                   userId: userList[index].userId,
            //                                   name: userList[index].name,
            //                                   email: userList[index].email,
            //                                   profilePic:
            //                                       userList[index].profilePic,
            //                                   createDate:
            //                                       userList[index].createDate))
            //                           .then((value) => setState(() {}));
            //                     },
            //                     icon: const Icon(
            //                       Icons.edit,
            //                       color: Colors.blue,
            //                     )),
            //                 IconButton(
            //                     onPressed: () async {
            //                       await deleteBottomSheet(
            //                           id: userList[index].userId);
            //                     },
            //                     icon: const Icon(
            //                       Icons.delete,
            //                       color: Colors.red,
            //                     )),
            //               ],
            //             ),
            //           );
            //         },
            //       );
            //     } else {
            //       return const Center(
            //           child: Text("No Data in Table",
            //               style: TextStyle(
            //                   fontSize: 18, fontWeight: FontWeight.w600)));
            //     }
            // }
          },
        ),
      ),
    );
  }
}
