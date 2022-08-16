import 'package:book_sell/servises/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartpage extends StatefulWidget {
  Cartpage({Key? key}) : super(key: key);

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  final productcontroller = Get.put(Productcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("Cart"),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      body: Column(
        children: [
          Obx(
            () => Container(
              height: 600,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: productcontroller.cartitem.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: EdgeInsets.only(top: 25, left: 25, right: 20),
                      child: Container(
                          height: 90,
                          margin: EdgeInsets.only(bottom: 4),
                          width: MediaQuery.of(context).size.width - 50,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: 400,
                                child: Row(children: [
                                  Container(
                                    height: 80,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                productcontroller
                                                    .cartitem[index]
                                                        ["book_image"]
                                                    .toString()))),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productcontroller.data[index]
                                              ["title"],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          productcontroller.data[index]
                                              ["author"],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                        Row(children: [
                                          Text(
                                            "\$20",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 205,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                productcontroller.removecart(
                                                    productcontroller
                                                        .cartitem[index]);
                                              },
                                              icon: Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ))
                                        ]),
                                      ]),
                                ]),
                              ))));
                },
              ),
            ),
          ),
          // Obx(
          //   () => Row(
          //     children: [
          //       Text(
          //         "Total Price",
          //         style: TextStyle(
          //             fontSize: 25,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.redAccent),
          //       ),
          //       Text(
          //         "\$ ${productcontroller.gettotalprice()}",
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
