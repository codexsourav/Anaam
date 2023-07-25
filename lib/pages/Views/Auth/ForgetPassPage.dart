import 'package:anaam/components/snackbar.dart';
import 'package:anaam/utils/validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/InputBox.dart';
import '../../../components/MyButton.dart';

class ForgetPassPage extends StatefulWidget {
  ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      // Show a success message
      showSnackbar(context, text: "Reset Password Mail", color: Colors.green);
    } catch (e) {
      showSnackbar(context, text: "Invalid Email ID!", color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 130),
                const Padding(
                  padding: EdgeInsets.only(bottom: 35),
                  child: Text(
                    'Forget My Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputBox(
                        hint: "Email ID",
                        controller: email,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        validate: (val) {
                          if (val.isEmpty || validate.isEmail(val)) {
                            return "Please Enter A Valid Email ID";
                          }
                        },
                      ),
                      MyButton(
                          text: "Send Email",
                          ontap: () {
                            if (_formKey.currentState!.validate()) {
                              resetPassword();
                            }
                          }),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Back To Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
