import 'package:anaam/components/InputBox.dart';
import 'package:anaam/components/MyButton.dart';
import 'package:anaam/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../components/snackbar.dart';
import '../../../resources/autharize.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Autharize auth = Autharize();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController uname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();

  signupProcess() async {
    setState(() {
      loading = true;
    });
    var res = await auth.signUpUser(
        email: email.text, pass: pass.text, name: name.text, uname: uname.text);
    setState(() {
      loading = false;
    });
    switch (res) {
      case "email-already-in-use":
        showSnackbar(context,
            text: "Email is Alrady Used",
            color: const Color.fromARGB(255, 207, 68, 58));
        break;
      case "invalid-email":
        showSnackbar(context,
            text: "Invalid Email ID",
            color: const Color.fromARGB(255, 207, 68, 58));
        break;
      case "weak-password":
        showSnackbar(context,
            text: "Password Too Short Min 6",
            color: const Color.fromARGB(255, 207, 68, 58));
        break;
      case "account-crated":
        showSnackbar(context,
            text: "Your Account is Crated",
            color: const Color.fromARGB(255, 50, 151, 84));
        Navigator.of(context).pop();
        break;
      case "uname-exist":
        showSnackbar(context,
            text: "Username Alrady Exist",
            color: const Color.fromARGB(255, 207, 68, 58));
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const Padding(
                  padding: EdgeInsets.only(bottom: 35),
                  child: Text(
                    'Create A New Account',
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
                        hint: "Name",
                        controller: name,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        validate: (val) {
                          if (val.isEmpty) {
                            return "Please Enter Your Name";
                          } else if (val.length <= 3) {
                            return "Name Is Too Short";
                          }
                        },
                      ),
                      InputBox(
                        hint: "@Username",
                        controller: uname,
                        format: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9]'))
                        ],
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        validate: (val) {
                          val = val.trim();
                          print(val);
                          if (val.isEmpty) {
                            return "Please A Username";
                          } else if (val.length <= 4) {
                            return "Userame Is Too Short Min 4";
                          }
                        },
                      ),
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
                      InputBox(
                        hint: "Password",
                        controller: pass,
                        ispassword: true,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        validate: (val) {
                          if (val.isEmpty) {
                            return "Please Enter Password";
                          } else if (val.length <= 5) {
                            return "Password Is Min 5 ";
                          }
                        },
                      ),
                      InputBox(
                        hint: "Confirm Password",
                        controller: cpass,
                        ispassword: true,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        validate: (val) {
                          if (pass.text != cpass.text) {
                            return "Password Not Matched!";
                          }
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(onChanged: (val) {}, value: true),
                          const Text('Accept Terms And Conditions')
                        ],
                      ),
                      MyButton(
                          text: 'SignUp',
                          loading: loading,
                          ontap: () {
                            if (_formKey.currentState!.validate()) {
                              signupProcess();
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
                        'Alrady a Account Login',
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
