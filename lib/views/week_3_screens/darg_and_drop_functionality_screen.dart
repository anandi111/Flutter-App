import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/reso.dart';

class DargAndDropScreen extends StatefulWidget {
  const DargAndDropScreen({Key? key}) : super(key: key);

  @override
  State<DargAndDropScreen> createState() => _DargAndDropScreenState();
}

class _DargAndDropScreenState extends State<DargAndDropScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                        "assets/Images/BG${Random().nextInt(3)}.jpg"))),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 90,
                  width: double.infinity,
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      List.generate(
                          Global.vegeDataList.length,
                          (index) =>
                              Global.vegeDataList[index].isDragged = false);
                      List.generate(
                          Global.vegeTargetDataList.length,
                          (index) => Global
                              .vegeTargetDataList[index].isDragged = false);
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: CupertinoColors.darkBackgroundGray
                              .withOpacity(0.5)),
                      child: const Icon(
                        Icons.restart_alt,
                        size: 45,
                        color: Colors.tealAccent,
                      ),
                    ),
                  ),
                ),
              ),
              const Text("Let's Play Game!!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: Global.vegeDataList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          child: Row(
                            children: [
                              (Global.vegeDataList[index].isDragged == false)
                                  ? Draggable(
                                      data: Global.vegeDataList[index].imageKey,
                                      feedback: SizedBox(
                                        height: 140,
                                        width: 140,
                                        child: Image.asset(
                                          Global.vegeDataList[index].image,
                                        ),
                                      ),
                                      childWhenDragging: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.asset(
                                            Global.vegeDataList[index].image,
                                            color:
                                                Colors.brown.withOpacity(0.5)),
                                      ),
                                      onDragCompleted: () {
                                        setState(() {
                                          Global.vegeDataList[index].isDragged =
                                              true;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Yeah, you done very well!!"),
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          width: 300,
                                        ));
                                      },
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.asset(
                                            Global.vegeDataList[index].image),
                                      ),
                                    )
                                  : Container(
                                      height: 150,
                                      width: 150,
                                      child: Center(
                                        child: Text("Yeh!!",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Global
                                                    .vegeDataList[index].color,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                              const Spacer(),
                              DragTarget(
                                onWillAccept: (data) =>
                                    data ==
                                    Global.vegeTargetDataList[index].imageKey,
                                onAccept: (val) {
                                  setState(() {
                                    Global.vegeTargetDataList[index].isDragged =
                                        true;
                                  });
                                },
                                builder:
                                    (context, candidateData, rejectedData) {
                                  return (Global.vegeTargetDataList[index]
                                              .isDragged ==
                                          false)
                                      ? DottedBorder(
                                          dashPattern: const [9, 6, 6, 6],
                                          color: Colors.black,
                                          strokeWidth: 3,
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.brown.withOpacity(0.6),
                                            ),
                                            child: Center(
                                              child: Text(
                                                Global.vegeTargetDataList[index]
                                                    .imageKey,
                                                style: TextStyle(
                                                    color: Global
                                                        .vegeTargetDataList[
                                                            index]
                                                        .color,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        )
                                      : DottedBorder(
                                          dashPattern: const [9, 6, 6, 6],
                                          color: Colors.black,
                                          strokeWidth: 3,
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.brown.withOpacity(0.9),
                                            ),
                                            child: Image.asset(Global
                                                .vegeTargetDataList[index]
                                                .image),
                                          ),
                                        );
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
