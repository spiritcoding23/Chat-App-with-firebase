import 'package:group_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:group_chat/custom_widgets/button_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool stateSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: stateSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                style: TextStyle(
                  color: Colors.black54,
                ),
                decoration: KTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              ButtonStylecustom(
                colour: Colors.blueAccent,
                text: 'Register',
                onPressed: () async {
                  if (password.length == 6) {
                    setState(() {
                      stateSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushReplacementNamed(context, ChatScreen.id);
                      }

                      setState(() {
                        stateSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      Alert(
                        context: context,
                        title: 'Error!',
                        desc:
                            'User Already Registered / Typed the wrong E-mail',
                      ).show();
                    }
                  } else {
                    setState(() {});
                    Alert(
                      context: context,
                      title: 'Error!',
                      desc: 'Password must be of 6 Digits',
                    ).show();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
