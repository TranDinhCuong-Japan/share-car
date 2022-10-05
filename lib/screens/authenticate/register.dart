import 'package:flutter/material.dart';
import 'package:share_stuff/services/auth.dart';
import 'package:share_stuff/shared/constants.dart';
import 'package:share_stuff/shared/loading.dart';

class Register extends StatefulWidget {
  final Function? toggleView;

  Register({this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loadding = false;
  
  @override
  Widget build(BuildContext context) {
    return (loadding)? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: const Text('Sign up'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView!();
              },
              icon: Icon(Icons.person),
              label: Text('Sign In'))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter an email';
                    } else {
                      return null;
                    }
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) =>
                      value!.length < 6 ? 'Enter password 6+ chars long' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink[400],
                      onPrimary: Colors.white,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loadding =true;
                        });
                        dynamic result =
                          await  _auth.registerWithEmailAndPasswod(email, password);
                        print(result);
                        if (result == null) {
                          setState(() { 
                            error = 'Please supply a valid email';
                            loadding = false;
                          });
                        }
                      }
                    },
                    child: Text('register')),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          )),
    );
  }
}
