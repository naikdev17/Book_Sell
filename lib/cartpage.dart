import 'package:flutter/material.dart';

class Cartpage extends StatefulWidget {
  var cartdata;
  Cartpage({Key? key, required this.cartdata}) : super(key: key);

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Cart"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            )),
        body: Container(
          child: ListView(
            padding: EdgeInsets.only(top: 25, left: 25, right: 20),
            children: [
              Container(
                height: 80,
                margin: EdgeInsets.only(bottom: 19),
                width: MediaQuery.of(context).size.width - 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.cartdata["book_image"].toString()))),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
