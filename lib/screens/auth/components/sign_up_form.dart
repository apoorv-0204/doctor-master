import 'package:doctor/screens/auth/components/sign_in_form.dart';
import 'package:doctor/screens/auth/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';
import '../../main/main_screen.dart';

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? _email = "";
    String _password = "";
    String? _phoneNumber = "";
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextFormField(
          //   validator: RequiredValidator(errorText: requiredField),
          //   onSaved: (newValue) {},
          //   decoration: InputDecoration(labelText: "Username*"),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
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
          ),
          TextFormField(
            onSaved: (newValue) { _phoneNumber = newValue; },
            decoration: InputDecoration(labelText: "Phone Number"),
            keyboardType: TextInputType.phone,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              validator: passwordValidator,
              obscureText: true,
              onChanged: (value) => _password = value,
              onSaved: (pass) {},
              decoration: InputDecoration(labelText: "Password*"),
            ),
          ),
          TextFormField(
            validator: (val) =>
                MatchValidator(errorText: 'Passwords do not match')
                    .validateMatch(val!, _password),
            obscureText: true,
            onSaved: (newValue) {},
            decoration: InputDecoration(labelText: "Confirm password*"),
          ),
          SizedBox(height: defaultPadding * 1.5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  String errorMessage = "";
                  bool error = false;
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _email.toString(),
                        password: _password,
                    );
                    print(userCredential.user);
                  } on FirebaseAuthException catch (e) {
                    error = true;
                    if (e.code == 'weak-password') {
                      errorMessage = 'The password provided is too weak.';
                    } else if (e.code == 'email-already-in-use') {
                      errorMessage = 'The account already exists for that email.';
                    }
                    print('Error: '+  e.code);
                  } catch (e) {
                    print(e);
                  }

                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(error ? 'Error' : 'Success', textAlign: TextAlign.center),
                      content: Text(error ? errorMessage : 'Account Created Successfully', textAlign: TextAlign.center),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () => {
                            if(error) {
                              Navigator.pop(context, 'OK')
                            }
                            else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(), // MainScreen();
                                ),
                              )
                            }
                          },
                          child: Center(child: Text(error ? 'OK' : 'Sign In')),
                        ),
                      ],
                    ),
                  );
                }
              },
              // onPressed: () => showDialog<String>(
              //   context: context,
              //   builder: (BuildContext context) => AlertDialog(
              //     title: const Text('Error', textAlign: TextAlign.center),
              //     content: const Text('AlertDialog description', textAlign: TextAlign.center),
              //     actions: <Widget>[
              //       ElevatedButton(
              //         onPressed: () => Navigator.pop(context, 'OK'),
              //         child: const Center(child: const Text('OK')),
              //       ),
              //     ],
              //   ),
              // ),
              child: Text("Sign Up"),
            ),
          ),
        ],
      ),
    );
  }
}
