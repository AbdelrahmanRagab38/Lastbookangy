import 'package:bookangy/Pages/signup_page.dart';
import 'package:bookangy/Widgets/RoundedButton.dart';
import 'package:bookangy/Widgets/circluarButton.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

import '../authentication.dart';
import '../constants.dart';
import 'admin/adminHome.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';

  LoginPage({this.auth});  //, this.loginCallback});
  final Auth auth;
 // final VoidCallback loginCallback;


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final adminPassword = 'Admin1234';
  String _email;
  String _password;
//  String _errorMessage;
  //bool _isLoginForm;
  //bool _isLoading;




  @override
  Widget build(BuildContext context) {
    String userId = "";

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.13),
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/icons/book.png'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome to ',
                      style: TextStyle(
                          fontSize: 28, color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      'BookAngy',
                      style: TextStyle(fontSize: 28, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 48.0,
              ),


              TextFormField(
                //try to take the input

                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: kInputDecoration.copyWith(
                  hintText: 'User Name',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Email can\'t be empty.' : null,
                onChanged: (val) => _email=val ,


              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: kInputDecoration.copyWith(
                  hintText: '******',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Password can\'t be empty.' : null,
                onChanged: (val) => _password=val ,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(

                text: 'Sign IN',
                color: Colors.indigoAccent,
                onPressed: () async {
    if (_formKey.currentState.validate()) {
      print("77777777777777777777");
         Auth myauth= new Auth();
      print(_email);
      print(_password);

      if (_password == adminPassword) {
    try {
    await myauth.signIn(_email, _password);
    Navigator.pushNamed(context, AdminHome.id);
    }
    catch(e){
    print(e);
    }

      }
      else {
        final AuthResult = await myauth.signIn(_email, _password);
        print("77777777777777777777");
        print(AuthResult.user.uid);
        print("77777777777777777777");
        if (userId != null) {
          Navigator.pushReplacementNamed(context, '/books');
        }
        else {
          print("Eror");
        }
      }
                };
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'OR',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircluarButton(
                    onPress: () {},
                    icon: 'assets/icons/facebook.png',
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  CircluarButton(
                    onPress: () {},
                    icon: 'assets/icons/gmail.png',
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('do you have no acc? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupPage.id);
                    },
                    child: Text(
                      'sign up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
      ),
    );

  }
}
