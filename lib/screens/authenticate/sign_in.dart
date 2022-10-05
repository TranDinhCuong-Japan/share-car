import 'package:flutter/material.dart';
import 'package:share_stuff/services/auth.dart';
import 'package:share_stuff/shared/constants.dart';
import 'package:share_stuff/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function? toggleView;

  SignIn({this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return (loading == true)
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: const Text('Sign in'),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView!();
                    },
                    icon: Icon(Icons.person),
                    label: Text('register'))
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
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
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value) => value!.length < 6
                            ? 'Enter password 6+ chars long'
                            : null,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
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
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .signWithEmailAndPasswod(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Could not sign in with those credentials';
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text('sign in')),
                      const SizedBox(
                        height: 20.0,
                      ),

                      // Anon sign in
                      TextButton(
                          onPressed: () async {
                            await _auth.signInAnon();
                          },
                          child: const Text('Sign in anon')),

                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
