import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Users.dart';
import '../../Users.dart';
import '../../store.dart';
import '../book_model.dart';
import '../books_list.dart';
class viewAllUsers extends StatelessWidget {
  static String id = 'ViewUsers';
  @override
  Widget build(BuildContext context) {
    final _store = Store();

    return   Container(
        width: MediaQuery.of(context).size.width,
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text(
    'All Users',
    style: TextStyle(
    color: Colors.deepPurpleAccent,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(
    height: 15,
    ),


    Container(
    height: 190,
    child:  StreamBuilder<QuerySnapshot>(
    stream: _store.loadUsers(),
    // ignore: missing_return
    builder: (context, snapshot) {

    if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
    }

    else if (snapshot.hasData) {
    List<Users> users = [];
    for (var doc in snapshot.data.documents) {
    var data = doc.data;
    users.add(Users(
    UserName: data["username"],
    Uid: data["uid"],
    Email: data["email"]
    ));
    }

    return ListView.builder(
    physics: BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemCount: users.length,
    itemBuilder: (context, index) {
    return  VerticalUserCard(
    user: users[index],
    Name:  users[index].UserName,
    // description: Books[index]
    //     .description
    //     .replaceAll(RegExp(r'<br />'), ' '),
    //   authorName: Books[index].authorName,
    // rating: Books[index].stars,
    imageUrl:"https://www.freeiconspng.com/uploads/person-icon-8.png" );
        },
    );
    // Books.clear();


    }
    },
    ),
    ),
    ]))));
  }
}


class VerticalUserCard extends StatelessWidget {
  final Users user;
  final String Name;
  final String imageUrl;

  const VerticalUserCard({Key key, this.user, this.Name, this.imageUrl}) : super(key: key);

 // VerticalBookCard({this.imageUrl, this.title, this.user});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),

        Text(
          Name,
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
