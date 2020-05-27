import 'package:bookangy/Widgets/RoundedButton.dart';
import 'package:bookangy/Widgets/circluarButton.dart';
import 'package:bookangy/provider/modelHud.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../Users.dart';
import '../authentication.dart';
import '../constants.dart';
import '../store.dart';

class SignupPage extends StatefulWidget {
  static String id = 'SignupScreen';
  SignupPage({this.auth});  //, this.loginCallback});
  final Auth auth;
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _store = Store();
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    String userId = "";

    return  Scaffold(
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: ModalProgressHUD(
            inAsyncCall: Provider.of<ModelHud>(context).isLoading,
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
                          'BookAng',
                          style: TextStyle(fontSize: 28, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextFormField(
                    onChanged: (val) => _username=val ,

                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    decoration: kInputDecoration.copyWith(
                      hintText: 'User Name',
                      hintStyle: TextStyle(color: Colors.grey),

                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    onChanged: (val) => _email=val ,

                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    decoration: kInputDecoration.copyWith(
                      hintText: 'ُEmail',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    onChanged: (val) => _password=val ,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    decoration: kInputDecoration.copyWith(
                      hintText: '******',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    text: 'Sign Up',
                    color: Colors.grey,
                    onPressed: () async {

                  //    final modelHud = Provider.of<ModelHud>(context,listen: false);
                      //modelHud.changeisLoading(true);

                      if (_formKey.currentState.validate()) {

                        try{

                          Auth myAuth = new Auth();
                        final AuthResult = await myAuth.signUp(_email, _password);
                        Navigator.pushReplacementNamed(context, '/books');

                        print("77777777777777777777");
                        print(AuthResult.user.uid);
                        print("77777777777777777777");
                        //   FirebaseUser user =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);

                          FirebaseUser _user = AuthResult.user;

                          _store.addUsers(Users(
                               UserName : _username,
                           password : _password,
                           Email : _email,
                           Uid: _user.uid
                          ));




                        if(AuthResult.user.uid!=null){
                        }
                        else {
                          print("Eror");
                        }
                        }on Exception catch(e){
                          Scaffold.of(context).showSnackBar(
                            SnackBar(content:
                            Text("Signup error"),
                          ),
                          );


                        }
                    //    modelHud.changeisLoading(false);

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
                      Text('do you have acc? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          'sign in',
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
        ),
      );

  }
}
