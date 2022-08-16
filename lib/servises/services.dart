import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Productcontroller extends GetxController {
  List data = [];
  List cartitem = List.empty().obs;

  addtocart(item) {
    if (cartitem.contains(item)) {
      return Fluttertoast.showToast(msg: "Already in the cart");
    } else {
      cartitem.add(item);
    }
  }

  removecart(item) {
    cartitem.remove(item);
  }

  gettotalprice() {
    double total = 0.0;
    cartitem.forEach((element) {
      total += element["price"];
    });
    return total;
  }

  @override
  void onInit() {
    super.onInit();
    getjsondata();
  }

  getjsondata() async {
    Uri url = Uri.parse(
        "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=bvvivAeO3fEKT66GAXKZU6DRfHSdNksv#");
    var response = await http.get(url);
    // print(response.body);

    Map<String, dynamic> map = json.decode(response.body);

    data = map["results"]["books"];

    update();
  }
}
