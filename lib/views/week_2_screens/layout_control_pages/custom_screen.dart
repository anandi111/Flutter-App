import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/modals/food.dart';
import 'package:training_app/modals/icon_item.dart';
import 'package:training_app/modals/order_item.dart';
import 'package:training_app/utils/appbar.dart';

class CustomScreen extends StatefulWidget {
  const CustomScreen({Key? key}) : super(key: key);

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  List tabItemList = ["All", "Biryani", "Dosa", "Sushi", "Pizza", "DalMukhani"];

  List<BottomNavigationBarItem> bottomNavBarItemList = [
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.bag),
      label: "Order",
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.gobackward),
      label: "Go Out",
    ),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.projective), label: "Pro"),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.heart_slash), label: "Nutrition"),
    const BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Donate"),
  ];

  int currentIndex = 0;

  List<OrderItem> orderList = [
    OrderItem(
        foodName: "Salad",
        foodPic: "assets/salad.png",
        orderTime: "30 mins",
        offPersentage: 30,
        isLabel: true),
    OrderItem(
        foodName: "Salad Dihs",
        foodPic: "assets/salad_1.png",
        orderTime: "30-35 mins",
        offPersentage: 20),
    OrderItem(
        foodName: "Avo SaladDish",
        foodPic: "assets/salad_5.png",
        orderTime: "40 mins",
        offPersentage: 30,
        isLabel: true),
    OrderItem(
        foodName: "Damo",
        foodPic: "assets/salad_4.png",
        orderTime: "20 mins",
        offPersentage: 10,
        isLabel: true),
    OrderItem(
        foodName: "Thinkoda Shup",
        foodPic: "assets/salad_3.png",
        orderTime: "25 mins",
        offPersentage: 30),
    OrderItem(
        foodName: "Niv Salad",
        foodPic: "assets/salad_2.png",
        orderTime: "20-30 mins",
        offPersentage: 30),
  ];

  List<IconItem> iconList = [
    IconItem(
        iconName: Icons.bookmark_add_outlined,
        iconColor: Colors.indigo,
        iconBGColor: Colors.blue.withOpacity(0.3),
        labelText: "Saved Places"),
    IconItem(
        iconName: Icons.ac_unit,
        iconColor: Colors.red,
        iconBGColor: Colors.redAccent.withOpacity(0.3),
        labelText: "PRO Partner"),
    IconItem(
        iconName: Icons.percent,
        iconColor: Colors.purple,
        iconBGColor: Colors.purpleAccent.withOpacity(0.3),
        labelText: "Great Offer"),
    IconItem(
        iconName: Icons.star_border,
        iconColor: Colors.brown,
        iconBGColor: Colors.amber.withOpacity(0.3),
        labelText: "Top Rated"),
    IconItem(
        iconName: Icons.diamond_outlined,
        iconColor: Colors.teal,
        iconBGColor: Colors.tealAccent.withOpacity(0.3),
        labelText: "Premium Pickes"),
  ];

  List<Food> foodList = [
    Food(
        foodname: "Avacado",
        foodPhoto: "assets/salad.png",
        price: 12.5,
        rating: 5.0,
        isTopRated: true,
        isFrequentlyOrdered: true,
        isPro: true,
        offerPersentage: 15),
    Food(
        foodname: "Mix Fruit",
        foodPhoto: "assets/salad_1.png",
        price: 10.0,
        rating: 4.5,
        isFrequentlyOrdered: true,
        offerPersentage: 15),
    Food(
      foodname: "Veggies Salad",
      foodPhoto: "assets/salad_2.png",
      price: 15,
      rating: 3.5,
    ),
    Food(
        foodname: "All in one",
        foodPhoto: "assets/salad_3.png",
        price: 16.5,
        rating: 5.0,
        isTopRated: true,
        isPro: true,
        offerPersentage: 15),
  ];

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabItemList.length,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: PageView(
          controller: pageController,
          onPageChanged: (val) {
            setState(() {
              currentIndex = val;
            });
          },
          children: [
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.pin_drop_rounded,
                                color: Colors.red),
                            const Text(
                              "Golf Course Road",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const Spacer(),
                            ClipOval(
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  height: 35,
                                  width: 35,
                                  "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80"),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "Restaurant name, cuisin or a dish ",
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.red),
                              suffixIcon: const Icon(CupertinoIcons.text_quote,
                                  color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  )),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.5))),
                        )
                      ],
                    ),
                  ),
                  TabBar(
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(fontSize: 17),
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle: const TextStyle(fontSize: 16),
                      isScrollable: true,
                      tabs: tabItemList
                          .map((e) => Tab(
                                text: e,
                                // child:
                                //     Text(e, style: TextStyle(color: Colors.black)),
                              ))
                          .toList()),
                  Expanded(
                    child: TabBarView(children: [
                      ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20, bottom: 20),
                            child: Row(
                              children: const [
                                Text(
                                  "Order again",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Text(
                                  "see again",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: orderList.length,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1 / 2.3,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10),
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                  orderList[index].foodPic,
                                                  height: 80,
                                                  width: 80,
                                                  fit: BoxFit.cover),
                                            ),
                                            (orderList[index].isLabel == true)
                                                ? Container(
                                                    color: Colors.red,
                                                    child: const Text(
                                                      "Pro",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 88,
                                              child: Text(
                                                orderList[index].foodName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Container(
                                              width: 88,
                                              child: Text(
                                                orderList[index]
                                                    .orderTime
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Container(
                                              width: 88,
                                              child: Text(
                                                "${orderList[index].offPersentage}% off",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              child: ListView.builder(
                                itemCount: iconList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: 90,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color:
                                                  iconList[index].iconBGColor,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Icon(
                                                iconList[index].iconName,
                                                color:
                                                    iconList[index].iconColor,
                                                size: 35),
                                          ),
                                          const Spacer(),
                                          Text(
                                            iconList[index]
                                                .labelText
                                                .replaceAll(" ", "\n"),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                "assets/salad_1.png",
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Based on what you like",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "Avacado Salad Dish",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Text(
                                "see all",
                                style: TextStyle(color: Colors.red),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: foodList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 1.5,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Image.asset(
                                              foodList[index].foodPhoto,
                                              height: 200,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              height: 200,
                                              width: 200,
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (foodList[index]
                                                          .isTopRated ==
                                                      true) ...[
                                                    Container(
                                                      color: Colors.blue,
                                                      child: const Text(
                                                          " ★ Top Rated",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                  ] else if (foodList[index]
                                                          .isFrequentlyOrdered ==
                                                      true) ...[
                                                    Container(
                                                      color: Colors.red,
                                                      child: const Text(
                                                          " ♡ Frequently Ordered",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                  ],
                                                  Spacer(),
                                                  (foodList[index]
                                                              .offerPersentage !=
                                                          null)
                                                      ? Container(
                                                          color: Colors.blue,
                                                          child: Text(
                                                              "${foodList[index].offerPersentage} % off"),
                                                        )
                                                      : Container(),
                                                  Row(
                                                    children: [
                                                      (foodList[index].isPro ==
                                                              true)
                                                          ? Container(
                                                              color:
                                                                  Colors.orange,
                                                              child: const Text(
                                                                  "Pro",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                            )
                                                          : Container(),
                                                      Spacer(),
                                                      Container(
                                                        color: Colors.amber,
                                                        child: Text(
                                                            "${foodList[index].rating} ★",
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          foodList[index].foodname,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "\$ ${foodList[index].price.toString()}",
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                      const Center(
                        child: Text(
                          "Biryani",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Dosa",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Sushi",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Pizza",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Dal Makhani",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
            const Center(
              child: Text("Go out",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            const Center(
              child: Text("Pro",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            const Center(
              child: Text("Nutrition",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            const Center(
              child: Text("Donate",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
              canvasColor: Colors.white,
              primaryColor: Colors.black,
              textTheme: TextTheme()),
          child: BottomNavigationBar(
            onTap: (val) {
              setState(() {
                currentIndex = val;
                pageController.animateToPage(val,
                    duration: Duration(microseconds: 800),
                    curve: Curves.easeIn);
              });
            },
            currentIndex: currentIndex,
            showUnselectedLabels: true,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.shifting,
            elevation: 5,
            items: bottomNavBarItemList.map((e) => e).toList(),
          ),
        ),
        /*floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName("week_2_page"));
        }),*/
      ),
    );
  }
}
