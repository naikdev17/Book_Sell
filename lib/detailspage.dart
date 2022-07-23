import 'package:book_sell/cartpage.dart';
import 'package:book_sell/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'homepage.dart';
import 'routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Detailspage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final get;
  Detailspage({Key? key, required this.get});

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
//  print(widget.get.toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 49,
          width: 140,
          margin: EdgeInsets.only(left: 20, right: 25, bottom: 25, top: 10),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(10)),
          child: TextButton(
              onPressed: () {
                Fluttertoast.showToast(msg: "Feature Is Not Supported Yet");
              },
              child: Text(
                "Add To Cart",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
        ),
        Container(
          height: 49,
          width: 140,
          margin: EdgeInsets.only(left: 40, right: 25, bottom: 25, top: 10),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: TextButton(
              onPressed: () {
                Fluttertoast.showToast(msg: "Feature Is Not Supported Yet");
              },
              child: Text(
                "Buy Now",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
        ),
      ]),
      body: SafeArea(
          child: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: [
                      Positioned(
                          left: 10,
                          top: 35,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Homepage()));
                              },
                            ),
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 270,
                          height: 300,
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.get["book_image"].toString()))),
                        ),
                      )
                    ],
                  ),
                )),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(top: 25, left: 25),
                child: Text(
                  widget.get["title"],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 25),
                child: Text(
                  widget.get["author"],
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, left: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "20",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 32,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                height: 28,
                margin: EdgeInsets.only(top: 20, bottom: 15),
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 25, bottom: 25, left: 25),
                child: Text(
                  widget.get["description"],
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[850],
                      letterSpacing: 1.2,
                      height: 1.5),
                ),
              )
            ]))
          ],
        ),
      )),
    );
  }
}
