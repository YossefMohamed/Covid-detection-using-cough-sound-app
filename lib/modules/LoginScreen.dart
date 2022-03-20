import 'package:covid/modules/RegisterScreen.dart';
import 'package:covid/modules/home_page.dart';
import 'package:covid/modules/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // get edit texts values
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // track password status
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff28b463),
        systemOverlayStyle:
            SystemUiOverlayStyle.light, // status bar text to light :)
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff28b463),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Only authenticated users can take covid-19 tests and tracking their results',
                  style: TextStyle(fontSize: 15.0, color: Color(0xff28b463)),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  cursorColor: Color(0xff28b463),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hoverColor: Color(0xff28b463),
                      iconColor: Color(0xff28b463),
                      labelText: 'Email Address',
                      labelStyle: TextStyle(color: Color(0xff28b463)),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xff28b463),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff28b463),
                        ),
                      ),
                      focusColor: Color(0xff28b463),
                      fillColor: Color(0xff28b463)),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isObscure,
                  decoration:  InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color(0xff28b463)),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xff28b463),
                      ),

                    suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.remove_red_eye : Icons.visibility_off_rounded,
                          color: Color(0xff28b463),
                        ),
                        onPressed: () {
                            _isObscure = !_isObscure;
                            setState(() {});
                        },
                    ),

                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff28b463),
                        ),
                      ),
                      focusColor: Color(0xff28b463),
                      fillColor: Color(0xff28b463)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xff28b463),
                  ),
                  width: double.infinity,
                  // sign in firebase
                  child: MaterialButton(
                    onPressed: () async {
                      showDialog(
                          barrierDismissible: false,
                          builder: (context) => const Center(
                                child: CircularProgressIndicator(
                                  valueColor:  AlwaysStoppedAnimation<Color>(Color(0xff28b463)),
                                ),
                              ),
                          context: context);
                      try {
                        Firebase.initializeApp();
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                        Fluttertoast.showToast(
                          msg: 'Login Successfully',
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MainPage()));
                      } on FirebaseAuthException catch (e) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          msg: e.message.toString(),
                        );
                      }
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                    ),
                    TextButton(
                      onPressed: () {
                        // move to register page
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(color: Color(0xff28b463)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
