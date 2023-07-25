import 'package:anaam/components/InputBox.dart';
import 'package:anaam/components/MyButton.dart';
import 'package:anaam/pages/MainPage.dart';
import 'package:anaam/pages/Views/Auth/ForgetPassPage.dart';
import 'package:anaam/pages/Views/Auth/SignupPage.dart';
import 'package:anaam/resources/autharize.dart';
import 'package:anaam/utils/validate.dart';
import 'package:flutter/material.dart';

import '../../../components/snackbar.dart';
import '../../../model/setOnline.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final Autharize _autharize = Autharize();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  chackUser() async {
    setState(() {
      isLoading = true;
    });
    var res = await _autharize.loginAccount(email: email.text, pass: pass.text);
    await setOnline();
    setState(() {
      isLoading = false;
    });
    switch (res) {
      case "user-not-found":
        showSnackbar(context,
            text: "Invalid Email Or Password",
            color: const Color.fromARGB(255, 207, 68, 58));
        break;
      case "invalid-email":
        showSnackbar(context,
            text: "Invalid Email Or Password",
            color: const Color.fromARGB(255, 207, 68, 58));
        break;
      case "wrong-password":
        showSnackbar(context,
            text: "Invalid Email Or Password",
            color: const Color.fromARGB(255, 207, 68, 58));
        break;
      case "login-true":
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
        break;
      default:
        showSnackbar(context,
            text: "Sumthing Want Wrong!",
            color: const Color.fromARGB(255, 207, 68, 58));
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
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 200),
                Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                  child: Text(
                    'Anaam',
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
                        margin: EdgeInsets.symmetric(vertical: 10),
                        validate: (val) {
                          if (val.isEmpty || validate.isEmail(val)) {
                            return "Please Enter A Valid Email ID";
                          }
                        },
                      ),
                      InputBox(
                        hint: "Password",
                        controller: pass,
                        ispassword: true,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        validate: (val) {
                          if (val.isEmpty) {
                            return "Please Enter Password";
                          } else if (val.length <= 4) {
                            return "Invalid Password";
                          }
                        },
                      ),
                      MyButton(
                          loading: isLoading,
                          text: "Login",
                          ontap: () async {
                            if (_formKey.currentState!.validate()) {
                              chackUser();
                            }
                          }),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgetPassPage(),
                            ));
                          },
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ));
                        },
                        child: Text(
                          'Signup Now',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
