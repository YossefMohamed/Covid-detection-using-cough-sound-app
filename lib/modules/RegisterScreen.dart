import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/modules/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:project_app/ChechBox_state.dart';
class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<RegisterScreen> {


  // controllers to get values
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff28B463),
          systemOverlayStyle:
              SystemUiOverlayStyle.light, // status bar text to light :)
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Form(
                        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              key: formKey,
              children: [
                Container(
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff28b463),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Only authenticated users can take covid-19 tests and tracking their results',
                  style: TextStyle(fontSize: 15.0, color: Color(0xff28b463)),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'Personal Information Make Contact Easy.\nDon\'t worry collected data is private',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                //userName
                TextFormField(
                  controller: userNameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    labelStyle: TextStyle(color: Color(0xff28b463)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff28b463),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xff28b463),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(color: Color(0xff28b463)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(
                        color: Color(0xff28b463),
                      ),
                    ),
                    prefixIcon:  Icon(
                      Icons.email,
                      color: Color(0xff28b463),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //phone
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Color(0xff28b463)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(
                        color: Color(0xff28b463),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Color(0xff28b463),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //gender
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    labelStyle: TextStyle(color: Color(0xff28b463)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(
                        color: Color(0xff28b463),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //age
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(color: Color(0xff28b463)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(
                        color: Color(0xff28b463),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //password
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xff28b463)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff28b463),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xff28b463),
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: Color(0xff28b463),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                //confirmPassword
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Color(0xff28b463)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff28b463),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xff28b463),
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: Color(0xff28b463),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child:  Text(
                    'By click register you agree to the terms of service',
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //register button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color(0xff28B463),
                  ),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                        createUserAccount();
                    },
                    child: const Text(
                      'REGISTER',
                      style:  TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              ],
            ))))));
  }

  // create user account
  Future<void> createUserAccount() async {

     // loading ...
    showDialog(
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            valueColor:  AlwaysStoppedAnimation<Color>(Color(0xff28b463)),
          ),
        ),
        context: context);

    // register user first
    try {
      Firebase.initializeApp();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );

      // create collection for user data
      /*
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      FirebaseAuth auth = FirebaseAuth.instance;
      users.add({
        'user_id': auth.currentUser!.uid.toString(),
        'name': userNameController.text.trim(),
        'phone': phoneController.text.trim(),
      }).then((value) =>
          Fluttertoast.showToast(
            msg: 'Register Successfully',
          )
      ).catchError((error) => Fluttertoast.showToast(
        msg: error.toString(),
      ));
    */
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginScreen()
      )
      );

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: e.message.toString(),
      );
    }
  }

}
