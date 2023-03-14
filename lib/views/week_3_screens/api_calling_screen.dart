import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/api_helper.dart';
import '../../modals/product.dart';

class ApiCallingScreen extends StatefulWidget {
  const ApiCallingScreen({Key? key}) : super(key: key);

  @override
  State<ApiCallingScreen> createState() => _ApiCallingScreenState();
}

class _ApiCallingScreenState extends State<ApiCallingScreen> {
  int count = 1;
  Color colorGreyBG = const Color(0xffeeeeee);
  Color colorDrawerGreyBG = const Color(0xff808080);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 3,
        title: const Text(
          "Product API Callling",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_double_arrow_left, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: APIHelper.apiHelper.fetchProductData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            );
          } else if (snapshot.hasData) {
            List<Product> productList = snapshot.data as List<Product>;
            return PageView(
              scrollDirection: Axis.vertical,
              children: productList
                  .map((e) => Column(
                        children: [
                          Container(
                            height: 435,
                            width: 400,
                            child: Stack(
                              children: [
                                Container(
                                    height: 430,
                                    width: 400,
                                    child: CachedNetworkImage(
                                      imageUrl: e.image,
                                      fit: BoxFit.contain,
                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    )),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    child: Container(
                                      height: 40,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: colorGreyBG,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 0.3, color: Colors.grey),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                count--;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.arrow_left,
                                              size: 25,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(count.toString()),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                count++;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.arrow_right,
                                              size: 25,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 345,
                            width: 400,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.withOpacity(0.15), spreadRadius: 10, blurRadius: 10)
                                ],
                                color: Colors.white),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text("${e.title}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Descriptions",
                                    style:
                                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: colorDrawerGreyBG),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(e.description,
                                      style: const TextStyle(color: Color(0xffd5d5d5), fontSize: 12, letterSpacing: 1)),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      const Text("Price",
                                          style: TextStyle(
                                              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16)),
                                      const Spacer(),
                                      Text("\$${e.price}",
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ))
                  .toList(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
