import 'package:book_sell/loginpage.dart';
import 'package:book_sell/models/usermodel.dart';
import 'package:book_sell/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
  List data = [];
  bool loading = true;

  User? user = FirebaseAuth.instance.currentUser;
  Usermodel loggedinuser = Usermodel();
  void initState() {
    // TODO: implement initState
    super.initState();
    getjsondata();
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
      results = data;
    } else {
      results = data
          .where((user) =>
              user["title"].toLowerCase().contains(enterkeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      data = results!;
    });
  }

  getjsondata() async {
    try {
      Uri url = Uri.parse(
          "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=bvvivAeO3fEKT66GAXKZU6DRfHSdNksv#");
      var response = await http.get(url);
      // print(response.body);

      Map<String, dynamic> map = json.decode(response.body);

      List<dynamic> bookdata = map["results"]["books"] as List<dynamic>;
      setState(() {
        data = bookdata;
        loading = false;
        // print(data[0]["book_image"].toString());
      });
    } catch (error) {
      print(error);
    }
  }

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
                  onPressed: () {},
                  child: Icon(Icons.shopping_cart_outlined),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // Padding(
                //     padding: const EdgeInsets.only(left: 25, top: 25),
                //     child: Text(
                //       "Hi ${loggedinuser.displayName != null ? loggedinuser.displayName : "user"}",
                //       style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w600,
                //           color: Colors.grey[800]),
                //     )),
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
                onChanged: (value) => runfilter(value),
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
            child: loading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Detailspage(
                                    get: data[index],
                                  )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      data[index]["book_image"].toString()))),
                        ),
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
          Stack(children: [
            loading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 25, left: 25, right: 20),
                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {});
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Detailspage(
                                      get: data[index],
                                    )));
                          },
                          child: Container(
                            height: 80,
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
                                              image: NetworkImage(data[index]
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
                                          data[index]["title"],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data[index]["author"],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "\$20",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ));
                    },
                  ),
          ]),
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
