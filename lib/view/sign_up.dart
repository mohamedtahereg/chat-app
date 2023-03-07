import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:to_do/view/home.dart';
import 'package:to_do/view/sign_in.dart';

import '../model/textfield.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  String? eemail, pass;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future<void> signUp() async {
    try {
      print("ok2");
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: eemail!, password: pass!);
      print("done :) ");
      Get.off(SignIn());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }

    // return await FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(
    //         email: "kamel2@gmail.com", password: "pass2115s.s4")
    //     .then((value) {
    //   print(value.user!.email);
    // }).catchError((e) {
    //   print(e);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Form(
            key: formState,
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: SvgPicture.asset("assets/sign-up.svg"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23),
                ),
                const SizedBox(
                  height: 10,
                ),
                // MyTextField(
                //   textFieldIcon: const Icon(Icons.email),
                //   fieldName: "username",
                //   onSaved: (p0) {
                //     username = p0;
                //   },
                // ),
                MyTextField(
                  textFieldIcon: const Icon(Icons.password),
                  fieldName: "Email",
                  onSaved: (e1) {
                    eemail = e1;
                  },
                ),
                MyTextField(
                  textFieldIcon: const Icon(Icons.password),
                  fieldName: "Password",
                  onSaved: (p0) {
                    pass = p0;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (formState.currentState!.validate()) {
                      signUp();
                    } else {}
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xff6c63ff),
                    ),
                    height: 70,
                    child: Image.asset("assets/signup.png"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("if you have Account "),
                      InkWell(
                        onTap: () {
                          Get.off(() => SignIn());
                        },
                        child: const Text(
                          "  Click Here",
                          style: TextStyle(
                            color: Color(0xff6c63ff),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
