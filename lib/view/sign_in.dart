import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:to_do/view/home.dart';
import 'package:to_do/view/sign_up.dart';

import '../model/textfield.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  String? eemail, pass;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future<void> signIn() async {
    try {
      print("ok2");
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: eemail!, password: pass!);
      Get.off(() => HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
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
                  "Login",
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
                      signIn();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Enter Fields"),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xff6c63ff),
                    ),
                    height: 70,
                    child: const Center(
                        child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("you dont have Account ?"),
                      InkWell(
                        onTap: () {
                          Get.off(() => SignUp());
                        },
                        child: const Text(
                          "  Register",
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
