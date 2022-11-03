import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phonenoController = TextEditingController();
  final cnameController = TextEditingController();
  final placeController = TextEditingController();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;

  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great

  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (_password.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        password_strength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        password_strength = 2 / 4;
      });
    } else {
      if (pass_valid.hasMatch(_password)) {
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('register'),),
        body: Form(
            key: _formKey,
            child: Column(children: [
              Container(
                height: 150.0,
                width: 190.0,
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange,
                      ),
                      child: Center(
                          child: Text(
                        'SIGN UP PAGE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: fnameController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.amberAccent),
                      ),
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Colors.orange),
                      hintText: 'Enter name'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: lnameController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.amberAccent),
                      ),
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Colors.orange),
                      hintText: 'Enter name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      suffixIcon:
                          Icon(Icons.email_outlined, color: Colors.orange),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.amberAccent),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.orange),
                      hintText: 'Enter valid email'),
                  onChanged: (val) {
                    validateEmail(val);
                  },
                ),
              ),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    } else {
                      //call function to check password
                      bool result = validatePassword(value);
                      if (result) {
                        // create account event
                        return null;
                      } else {
                        return " Password should contain Capital, small letter & Number & Special";
                      }
                    }
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      suffixIcon:
                          Icon(Icons.password_outlined, color: Colors.orange),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.amberAccent),
                      ),
                      labelText: 'passward',
                      labelStyle: TextStyle(color: Colors.orange),
                      hintText: 'Enter your secure password'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (phonenoController.value == null) {
                      return 'fill your phone number';
                    }
                  },
                  controller: phonenoController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.phone,
                        color: Colors.orange,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.amberAccent),
                      ),
                      labelText: 'phone no',
                      labelStyle: TextStyle(color: Colors.orange),
                      hintText: 'Enter you phone'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: LinearProgressIndicator(
                  value: password_strength,
                  backgroundColor: Colors.grey[300],
                  minHeight: 5,
                  color: password_strength <= 1 / 4
                      ? Colors.red
                      : password_strength == 2 / 4
                          ? Colors.yellow
                          : password_strength == 3 / 4
                              ? Colors.blue
                              : Colors.green,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: cnameController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.amberAccent),
                      ),
                      labelText: 'course Name',
                      labelStyle: TextStyle(color: Colors.orange),
                      hintText: 'Enter your course Name'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: placeController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.amberAccent),
                      ),
                      labelText: 'place',
                      labelStyle: TextStyle(color: Colors.orange),
                      hintText: 'Enter your place'),
                ),
              ),
              Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed:
                      // password_strength != 1
                      //     ? null:
                      () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((value){
                        FirebaseFirestore.instance.collection('login').doc().set({
                          'fname': fnameController.text,
                          'lname': lnameController.text,
                          'email': emailController.text,
                          'password': passwordController.text,
                          'phone': phonenoController.text,
                          'cnmae': cnameController.text,
                          'place': placeController.text,
                        });
                      });

                    }

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            ])));
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}
