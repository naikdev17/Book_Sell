import 'package:book_sell/homepage.dart';
import 'package:book_sell/loginpage.dart';
import 'package:book_sell/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final usernameeditingcontroller = TextEditingController();
  final emaileditingcontroller = TextEditingController();
  final passwordeditingcontroller = TextEditingController();
  final confirmpasswordeditingcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 00,
                ),
                Image.asset("lib/assets/login.png"),
                SizedBox(height: 45),
                Container(
                  height: 300,
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                            controller: usernameeditingcontroller,
                            autofocus: false,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Username should not be empty";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              usernameeditingcontroller.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                hintText: "Usename",
                                prefixIcon: Icon(Icons.person_outline))),
                        TextFormField(
                            controller: emaileditingcontroller,
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please Enter Your Email");
                              }
                              // reg expression for email validation
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please Enter a valid email");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              emaileditingcontroller.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.mail_outline))),
                        TextFormField(
                            autofocus: false,
                            controller: passwordeditingcontroller,
                            obscureText: true,
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Password is required for login");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 6 Character)");
                              }
                            },
                            onSaved: (value) {
                              passwordeditingcontroller.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                hintText: "password",
                                prefixIcon: Icon(Icons.lock_outline))),
                        TextFormField(
                            autofocus: false,
                            controller: confirmpasswordeditingcontroller,
                            obscureText: true,
                            validator: (value) {
                              if (confirmpasswordeditingcontroller.text !=
                                  passwordeditingcontroller.text) {
                                return "Password don't match";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              confirmpasswordeditingcontroller.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                hintText: "Confirm password",
                                prefixIcon: Icon(Icons.lock_outline))),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    height: 46,
                    width: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          signup(emaileditingcontroller.text,
                              passwordeditingcontroller.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginpage()));
                        },
                        child: Text("SIGN UP",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600))),
                  ),
                ])
              ],
            ),
          ),
        ),
      )),
    );
  }

  void signup(String email, String password) async {
    if (formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postdetailstofirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e);
      });
    }
  }

  postdetailstofirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    Usermodel usermodel = Usermodel();

    usermodel.email = user!.email;
    usermodel.uid = user.uid;
    usermodel.displayName = user.displayName;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(usermodel.toMap());
    Fluttertoast.showToast(msg: "Account created sucessfully");

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Homepage()), (route) => true);
  }
}
