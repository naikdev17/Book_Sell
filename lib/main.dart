import 'package:book_sell/cartpage.dart';
import 'package:book_sell/detailspage.dart';
import 'package:book_sell/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes.dart';
import 'loginpage.dart';
import 'signuppage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'homepage.dart';

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
    return MaterialApp(
        title: "book sell",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(),
        ),
        home: Homepage(),
        routes: {
          Myroutes.homepage: (context) => Homepage(),
          Myroutes.detailspage: (context) => Detailspage(
                get: data,
              ),
          Myroutes.cartpage: (context) => Cartpage(
                cartdata: data,
              ),
          // Myroutes.loginpage: (context) => Loginpage(),
          // Myroutes.signuppage: (context) => Signuppage(),
        });
  }
}
