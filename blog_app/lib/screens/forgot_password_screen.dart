// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  String email = "";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
          backwardsCompatibility: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          onChanged: (value) {
                            email = value;
                          },
                          validator: (value) {
                            return value!.isEmpty ? 'enter email' : null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RoundButton(
                          title: 'Send Email',
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                _auth
                                    .sendPasswordResetEmail(
                                        email: emailController.text.toString())
                                    .then((value) {
                                  tostMessages(
                                      'Please check your email, a reset link has been sent you via email');
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }).onError((error, stackTrace) {
                                  tostMessages(error.toString());
                                  setState(() {
                                    showSpinner = false;
                                  });
                                });
                              } catch (e) {
                                print(e.toString());
                                tostMessages(e.toString());
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            }
                          },
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void tostMessages(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepOrange,
        textColor: Colors.indigo,
        fontSize: 26.0);
  }
}
