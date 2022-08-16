import 'package:book_sell/screens/loginpage.dart';
import 'package:book_sell/servises/services.dart';
import 'package:book_sell/servises/usermodel.dart';
import 'package:book_sell/screens/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'cartpage.dart';
import 'detailspage.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  User? user = FirebaseAuth.instance.currentUser;
  Usermodel loggedinuser = Usermodel();
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      this.loggedinuser = Usermodel.fromMap(value.data());
      setState(() {});
    });
  }

  //searchbar logic
  void runfilter(String enterkeyword) {
    List<dynamic>? results = [];
    if (enterkeyword.isEmpty) {
      results = productcontroller.data;
    } else {
      results = productcontroller.data
          .where((user) =>
              user["title"].toLowerCase().contains(enterkeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      productcontroller.data = results!;
    });
  }

  final productcontroller = Get.put(Productcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
          child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Stack(children: [
            Positioned(
                right: 10,
                top: 15,
                child: IconButton(
                    hoverColor: Colors.red,
                    onPressed: () {
                      logout(context);
                    },
                    icon: Icon(Icons.power_settings_new_outlined))),
            Positioned(
                right: 50,
                top: 10,
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  foregroundColor: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(context, Myroutes.cartpage);
                  },
                  child: Icon(Icons.shopping_cart_outlined),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25, top: 25),
                  child: Text(
                    "Discover Latest Book",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ]),
          Container(
            height: 40,
            margin: EdgeInsets.only(top: 15, left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200]),
            child: Stack(children: [
              TextField(
                autofocus: false,
                // onChanged: (value) => runfilter(value),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 19, right: 19, bottom: 8),
                    hintText: "search....",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600)),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 200,
            child: GetBuilder<Productcontroller>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: productcontroller.data.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => Detailspage(),
                            arguments: productcontroller.data[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(productcontroller
                                    .data[index]["book_image"]
                                    .toString()))),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
              child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: Text(
              "Popular",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          )),
          GetBuilder<Productcontroller>(
            builder: (controller) {
              return Stack(children: [
                ListView.builder(
                  padding: EdgeInsets.only(top: 25, left: 25, right: 20),
                  itemCount: productcontroller.data.length,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Get.to(() => Detailspage(),
                              arguments: productcontroller.data[index]);
                        },
                        child: Container(
                          height: 90,
                          margin: EdgeInsets.only(bottom: 19),
                          width: MediaQuery.of(context).size.width - 50,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                productcontroller.data[index]
                                                        ["book_image"]
                                                    .toString())),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productcontroller.data[index]["title"],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        productcontroller.data[index]["author"],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "\$20",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(width: 5),
                                          IconButton(
                                              onPressed: () {
                                                productcontroller.addtocart(
                                                    productcontroller
                                                        .data[index]);
                                              },
                                              icon: Icon(Icons
                                                  .add_shopping_cart_outlined))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ));
                  },
                ),
              ]);
            },
          ),
        ],
      )),
    );
  }

  Future<void> logout(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Loginpage()));
  }
}
