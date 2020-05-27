import 'package:bookangy/provider/adminMode.dart';
import 'package:bookangy/provider/cartItem.dart';
import 'package:bookangy/provider/modelHud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/About_Screens/About.dart';
import 'Pages/CartScreen.dart';
import 'Pages/Login_Page.dart';
import 'Pages/Splash_Screen.dart';
import 'Pages/admin/addProduct.dart';
import 'Pages/admin/adminHome.dart';
import 'Pages/books_list.dart';
import 'Pages/signup_page.dart';
import 'authentication.dart';
import 'package:bookangy/Pages/admin/View_Users.dart';


void main() => runApp(MyApp());




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        )
      ],
      child: MaterialApp(
        title: 'Bookangy',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Color(0XFFCCCCCC)),
       home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
       BooksList.id: (context) => BooksList("Abdelrahman"),

          LoginPage.id: (context) => LoginPage(),
          SignupPage.id: (context) => SignupPage(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
          CartScreen.id:(context)=>CartScreen(),
          viewAllUsers.id:(context)=>viewAllUsers(),
          About.id:(context)=>About(),

    '/login': (BuildContext context) => LoginPage(auth: new Auth()),
         //  '/home': (BuildContext context) => HomePage(),
          '/books': (BuildContext context) => BooksList("Abdelrahman"),
          '/signup': (BuildContext context) => SignupPage(),

        },
      ),
    );
  }
}

