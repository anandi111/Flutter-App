import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_app/utils/appbar.dart';

_ResponsiveScreenState? responsiveScreenState;

class ResponsiveScreen extends StatefulWidget {
  const ResponsiveScreen({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ResponsiveScreen> createState() {
    responsiveScreenState = _ResponsiveScreenState();
    print(responsiveScreenState);
    return responsiveScreenState!;
  }
}

class _ResponsiveScreenState extends State<ResponsiveScreen> {
  int count = 0;

  Future<void> setDefaultOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    setDefaultOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///you can also use Sizer package for it..
      appBar: MyAppBar(title: "Responsive"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.screen_rotation,
          color: Colors.white,
        ),
        onPressed: () async {
          // onTapByUniqe();
          if (count == 0) {
            await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
            setState(() {
              count = 1;
            });
          } else {
            await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
            setState(() {
              count = 0;
            });
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: OrientationBuilder(
          builder: (context, orientation) {
            return (MediaQuery.of(context).orientation == Orientation.portrait)
                ? Column(
                    children: [
                      CachedNetworkImage(
                          placeholder: (context, url) {
                            return const Padding(
                              padding: EdgeInsets.all(50),
                              child: CupertinoActivityIndicator(),
                            );
                          },
                          imageUrl:
                              "https://images.unsplash.com/photo-1519074598089-6436475c7f8f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=872&q=80"),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Indian culture is the heritage of social norms, ethical values, traditional customs, belief systems, political systems, artifacts and technologies that originated in or are associated with the ethno-linguistically diverse India. The term also applies beyond India to countries and cultures whose histories are strongly connected to India by immigration, colonisation, or influence, particularly in South Asia and Southeast Asia. India's languages, religions, dance, music, architecture, food and customs differ from place to place within the country.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                            imageUrl:
                                "https://images.unsplash.com/photo-1519074598089-6436475c7f8f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=872&q=80"),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Expanded(
                        child: Text(
                          "Indian culture is the heritage of social norms, ethical values, traditional customs, belief systems, political systems, artifacts and technologies that originated in or are associated with the ethno-linguistically diverse India. The term also applies beyond India to countries and cultures whose histories are strongly connected to India by immigration, colonisation, or influence, particularly in South Asia and Southeast Asia. India's languages, religions, dance, music, architecture, food and customs differ from place to place within the country.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
//
// onTapByUniqe() async {
//   if (responsiveScreenState!.count == 0) {
//     await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
//     responsiveScreenState!.setState(() {
//       responsiveScreenState!.count = 1;
//     });
//   } else {
//     await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     responsiveScreenState!.setState(() {
//       responsiveScreenState!.count = 0;
//     });
//   }
// }
