import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }

}

class LoginScreenState extends State<LoginScreen> with validationMixin {
  final formKey = GlobalKey<FormState>();
  
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email address',
        hintText: 'your.email@example.com',
      ),
      validator: validateEmail,
      onSaved: (v) {
        email = v;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Your password',
      ),
      validator: validatePassword,
      onSaved: (v) {
        password = v;
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      onPressed: () {
        if (!formKey.currentState.validate()) {
          return;
        }

        formKey.currentState.save();
        print('$email - $password');
      },
      child: Text('Submit'),
    );
  }
}