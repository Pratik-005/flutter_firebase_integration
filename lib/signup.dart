import 'package:flutter/material.dart';
import 'package:flutter_firebase/functions/auth_functions.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  bool newUser = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: ValueKey('email'),
                decoration: InputDecoration(hintText: 'Email'),
                validator: (value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  setState(() {
                    email = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                key: ValueKey('password'),
                decoration: InputDecoration(hintText: 'Password'),
                validator: (value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  setState(() {
                    password = newValue!;
                  });
                },
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (newUser) {
                        signUp(email, password);
                      } else {
                        signIn(email, password);
                      }
                    }
                  },
                  child: Text(
                    newUser ? 'Sign up' : 'Sign In',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    newUser = !newUser;
                  });
                },
                child: !newUser
                    ? Text('New user ? sign up')
                    : Text('Already signed up ? login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
