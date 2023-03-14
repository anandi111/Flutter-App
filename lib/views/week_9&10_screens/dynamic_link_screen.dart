import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_app/helpers/dynamic_link_service_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class DynamicLinkScreen extends StatefulWidget {
  const DynamicLinkScreen({Key? key}) : super(key: key);

  @override
  State<DynamicLinkScreen> createState() => _DynamicLinkScreenState();
}

class _DynamicLinkScreenState extends State<DynamicLinkScreen> {
  String? link;
  String? pageLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Dynamic Link"),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            MyButton(
                label: "Get Link",
                callback: () async {
                  link = await DynamicLinkServiceHelper.dynamicLinkServiceHelper.createLink();
                  setState(() {});
                }),
            if (link != null) ...{
              Text(link.toString()),
              const SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: link)).then((_) {
                      Fluttertoast.showToast(msg: "Link copy to clipboard..");
                    });
                  },
                  icon: const Icon(Icons.copy_rounded))
            },
            const SizedBox(
              height: 20,
            ),
            MyButton(
                label: "Get Page Link",
                callback: () async {
                  pageLink = await DynamicLinkServiceHelper.dynamicLinkServiceHelper.createPageLink();
                  setState(() {});
                }),
            if (pageLink != null) ...{
              Text(pageLink.toString()),
              const SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: pageLink)).then((_) {
                      Fluttertoast.showToast(msg: "Link copy to clipboard..");
                    });
                  },
                  icon: const Icon(Icons.copy_rounded))
            }
          ],
        ),
      ),
    );
  }
}
