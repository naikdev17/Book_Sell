import 'package:book_sell/homepage.dart';
import 'package:book_sell/routes.dart';
import 'package:book_sell/signuppage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loginpage extends StatefulWidget {
  Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _auth = FirebaseAuth.instance;

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  String? errorMessage;

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          
              Form(
                key: formkey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Image.asset("lib/assets/login.png"),
                      SizedBox(height: 45),
                      TextFormField(
                          autofocus: false,
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null) {
                              return ("please enter Email Adress");
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("please enter valid Email Adress");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            emailcontroller.text = value!;
                          },
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.mail_outline))),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          autofocus: false,
                          obscureText: true,
                          controller: passwordcontroller,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value == null) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                          },
                          onSaved: (value) {
                            passwordcontroller.text = value!;
                          },
                          // obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 45),
              Container(
                height: 46,
                width: 290,
                child: ElevatedButton(
                    onPressed: () {
                      signIn(emailcontroller.text, passwordcontroller.text);
                    },
                    child: Text("LOGIN",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New user?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signuppage()));
                      },
                      child: Text(
                        "Register Here",
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  void signIn(String email, String password) async {
    if (formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login sucessful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Homepage()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e);
      });
    }
  }
}
