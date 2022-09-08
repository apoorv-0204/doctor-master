import 'package:doctor/screens/auth/sign_in_screen.dart';
import 'package:doctor/screens/home/home_screen.dart';
import 'package:doctor/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';

class SignInForm extends StatelessWidget {
  String? _email = "";
  String _password = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: MultiValidator(
              [
                RequiredValidator(errorText: requiredField),
                EmailValidator(errorText: emailError),
              ],
            ),
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) { _email = newValue; },
            decoration: InputDecoration(labelText: "Email*"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              validator: passwordValidator,
              obscureText: true,
              onSaved: (newValue) { _password = newValue!;},
              decoration: InputDecoration(labelText: "Password*"),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text("Forgot your Password?"),
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String errorMessage = "";
                  bool error = false;
                  _formKey.currentState!.save();
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email.toString(),
                        password: _password
                    );
                  } on FirebaseAuthException catch (e) {
                    error = true;
                    if (e.code == 'user-not-found') {
                      errorMessage = 'No user found for that email.';

                    } else if (e.code == 'wrong-password') {
                      errorMessage = 'Wrong password provided for that user.';

                    }
                  }
                  if(error) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title: const Text('Error', textAlign: TextAlign
                                .center),
                            content: Text(errorMessage, textAlign: TextAlign
                                .center),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Center(child: const Text('OK')),
                              ),
                            ],
                          ),
                    );
                  }
                  else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(), // MainScreen();
                      ),
                    );
                  }
                }
              },
              child: Text("Sign In"),
            ),
          ),
        ],
      ),
    );
  }
}
