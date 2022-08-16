import 'package:book_sell/screens/cartpage.dart';
import 'package:book_sell/screens/detailspage.dart';
import 'package:book_sell/screens/homepage.dart';
import 'package:book_sell/screens/routes.dart';
import 'package:book_sell/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  get data => null;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "book sell",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(),
        ),
        home: Homepage(),
        routes: {
          Myroutes.homepage: (context) => Homepage(),
          Myroutes.detailspage: (context) => Detailspage(),
          Myroutes.cartpage: (context) => Cartpage(),
          // Myroutes.loginpage: (context) => Loginpage(),
          // Myroutes.signuppage: (context) => Signuppage(),
        });
  }
}
