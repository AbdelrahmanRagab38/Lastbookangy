import 'dart:developer';

import 'package:bookangy/Widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../authentication.dart';
import '../constants.dart';
import '../services.dart';
import '../store.dart';
import 'book_details.dart';
import 'book_model.dart';

class BooksList extends StatelessWidget {
  String _username;
  static String id = 'BookList';

  BooksList(this._username);

  @override
  Widget build(BuildContext context) {

    int _tabBarIndex = 0;
    int _bottomBarIndex = 0;
    final _store = Store();
    List<Book> _Books;
    final _auth = Auth();
    FirebaseUser _loggedUser;

    getCurrenUser() async {
      _loggedUser = await _auth.getUser();
    }


   /* Widget streamview(){

    };*/


    getCurrenUser();

    return Scaffold(
      appBar: AppBar(


      ),
      drawer: AppDrawer(),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 2.0, top: 8, bottom: 8, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200],
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child:
                                CircleAvatar(
                                  radius: 27,
                                  backgroundImage: NetworkImage(
                                      'https://i.pinimg.com/originals/9a/eb/7e/9aeb7e5e68cede5db7eeb558e3bba46b.jpg'),

                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Hi $_loggedUser ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 6,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),




        //    streamview(),







              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Recently Added',
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
                        stream: _store.loadProducts(),
                    // ignore: missing_return
                    builder: (context, snapshot) {

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      else if (snapshot.hasData) {
                        List<Book> Books = [];
                        for (var doc in snapshot.data.documents) {
                          var data = doc.data;
                          Books.add(Book(
                              price: data[kProductprice],
                              Bid: doc.documentID,
                              bookTitle: data[kProductName],
                              description:  data[kProductDescription],
                              authorName:  data[kProductCategory],
                              numPages: data[kProductNpages],
                              stars: data[kProductstars],
                              imageUrl: data[kProducturl]));
                        }

                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: Books.length,
                          itemBuilder: (context, index) {
                            return  VerticalBookCard(
                              book: Books[index],
                              title: Books[index].bookTitle,
                             // description: Books[index]
                             //     .description
                             //     .replaceAll(RegExp(r'<br />'), ' '),
                           //   authorName: Books[index].authorName,
                             // rating: Books[index].stars,
                              imageUrl: Books[index].imageUrl,
                            );
                          },
                        );
                        // Books.clear();


                      }
                    },
                  ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                  ),
                ),
              ),



              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Recommended',
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
                          child: FutureBuilder(
                              future: Services.getBooksInfo(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if ((snapshot.data.length / 4).toInt() == 0) {
                                  return Center(
                                    child: Text('No Recommended Books'),
                                  );
                                }
                                final data = List.from(snapshot.data.reversed);
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (data.length ~/ 4).toInt(),
                                  itemBuilder: (context, index) {
                                    return VerticalBookCard(
                                      book: data[index],
                                      title: data[index].bookTitle,
                                      imageUrl: data[index].imageUrl,
                                    );
                                  },
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'New Books',
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 60,
                child: FutureBuilder(
                    future: Services.getBooksInfo(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final data = snapshot.data;
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return HorizontalBookCard(
                            book: data[index],
                            title: data[index].bookTitle,
                            description: data[index]
                                .description
                                .replaceAll(RegExp(r'<br />'), ' '),
                            authorName: data[index].authorName,
                            rating: data[index].stars,
                            imageUrl: data[index].imageUrl,
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerticalBookCard extends StatelessWidget {
  final Book book;
  final String title;
  final String imageUrl;

  VerticalBookCard({this.imageUrl, this.title, this.book});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetails(
                  book: book,
                ),
              ),
            );
          },
          child: Padding(
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
        ),
        Text(
          title,
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

class HorizontalBookCard extends StatelessWidget {
  final Book book;
  final String imageUrl;
  final String title;
  final String description;
  final String rating;
  final String authorName;

  HorizontalBookCard(
      {this.imageUrl,
      this.book,
      this.title,
      this.description,
      this.authorName,
      this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetails(
                book: book,
              ),
            ),
          );
        },
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          authorName,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '$rating Stars',
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
