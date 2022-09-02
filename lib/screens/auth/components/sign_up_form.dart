import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';

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
                MatchValidator(errorText: 'passwords do not match')
                    .validateMatch(val!, _password),
            obscureText: true,
            onSaved: (newValue) {},
            decoration: InputDecoration(labelText: "Confirm password*"),
          ),
          SizedBox(height: defaultPadding * 1.5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              // onPressed: () async {
              //   if (_formKey.currentState!.validate()) {
              //     _formKey.currentState!.save();
              //     // try {
              //     //   print('Hello');
              //     //   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              //     //       email: "barra.allen@example.com",
              //     //       password: "SuperSecretPassword!"
              //     //   );
              //     // } on FirebaseAuthException catch (e) {
              //     //   if (e.code == 'weak-password') {
              //     //     print('The password provided is too weak.');
              //     //   } else if (e.code == 'email-already-in-use') {
              //     //     print('The account already exists for that email.');
              //     //   }
              //     // } catch (e) {
              //     //   print(e);
              //     // }
              //
              //     // try {
              //     //   UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              //     //       email: "barry.allen@example.com",
              //     //       password: "SuperSecretPassword"
              //     //   );
              //     //   print('Validated');
              //     // } on FirebaseAuthException catch (e) {
              //     //   if (e.code == 'user-not-found') {
              //     //     print('No user found for that email.');
              //     //   } else if (e.code == 'wrong-password') {
              //     //     print('Wrong password provided for that user.');
              //     //   }
              //     // }
              //
              //   }
              // },
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title', textAlign: TextAlign.center),
                  content: const Text('AlertDialog description', textAlign: TextAlign.center),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Center(child: const Text('OK')),
                    ),
                  ],
                ),
              ),
              child: Text("Sign Up"),
            ),
          ),
        ],
      ),
    );
  }
}
