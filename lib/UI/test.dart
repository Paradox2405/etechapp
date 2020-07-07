import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Account.dart';
import 'Initial.dart';
import 'ProfilePage.dart';
import 'Reviews.dart';
import 'OrderObj.dart';
import 'book.dart';


class BookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test',
      home: BookFirebaseDemo(),
    );
  }
}



class BookFirebaseDemo extends StatefulWidget {

  BookFirebaseDemo() : super();

  final String appTitle = "Book DB";

  static String Fref = "Gpu";

  setMRef(ref){
    var hh;
    Fref = ref;
    hh = ref;

  }

  String getMRef(){
    String chec = Fref;
    return chec;
  }






  @override
  _BookFirebaseDemoState createState() => _BookFirebaseDemoState();
}



class _BookFirebaseDemoState extends State<BookFirebaseDemo> {

  TextEditingController bookNameController = TextEditingController();
  TextEditingController bookAuthorController = TextEditingController();

  bool isEditing = false;
  bool textFieldVisibility =false;

  String storeCollectionName = "Items";

  Book currentBook;

  var userID;
  var name='User1';
  var email ='exampe@mail.com';
  var items ='';
  List<OrderObj> UserOrder = new List();


  var foodRef;

 var pass = new BookFirebaseDemo();

  setRef(ref) {
    foodRef = ref;
    pass.setMRef(foodRef);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BookApp2()));

  }


  getAllBooks(){
    return Firestore.instance.collection(storeCollectionName).snapshots();
  }


  AddItem(var img,var price,var name){

    setState(() {
      UserOrder.add(OrderObj(name: name,img: img,price: price));

    });
  }






    deleteBook(Book book) {
      Firestore.instance.runTransaction(
              (Transaction transaction) async {
            await transaction.delete(book.documentReference);
          }

      );
    }


  Widget buildBody(BuildContext context){

    return StreamBuilder<QuerySnapshot>(

      stream: getAllBooks(),
      builder: (context,snapshot) {

        if (snapshot.hasData) {


          return buildList(context,snapshot.data.documents);
        }
        return buildList(context, snapshot.data.documents);
      },
    ); // StreamBuilder
  }








  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot){


    return ListView(
      children: snapshot.map((data) => listItemBuild(context,data)).toList(),
    );
  }

  Widget listItemBuild(BuildContext context,DocumentSnapshot data){
    File _image;
    final book = Book.fromSnapshot(data);

    return Padding(
        key: ValueKey(book.foodName),
        padding: EdgeInsets.symmetric(vertical : 19, horizontal: 10),
        child: Container(

          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal),
            borderRadius: BorderRadius.circular(20),
            boxShadow:  [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 0,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: SingleChildScrollView(

            child: ListTile(
              title: Column(

                children: <Widget>[
                  Divider(color: Colors.white,
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 130,
                          backgroundColor: Colors.teal,
                          child: ClipOval(
                            child: new SizedBox(
                              width: 230.0,
                              height: 230.0,
                              child: (book.photo==null)?Image.file(
                                _image,
                                fit: BoxFit.fill,
                              ):Image.network(
                                book.photo,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Divider(color: Colors.white,
                    height: 30,
                    thickness: 5,
                    indent: 20,
                    endIndent: 0,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.fastfood, color: Colors.teal,),
                      Text("  "+book.foodName),
                    ],

                  ),
                  Divider(),
                  Row(

                    children: <Widget>[
                      Icon(Icons.monetization_on, color: Colors.teal,),
                      Text("  "+book.price, textAlign: TextAlign.center,),

                    ],

                  ),
                  Divider(),
                  Row( children: <Widget>[
                    Icon(Icons.restaurant, color: Colors.teal,),
                    Text("  "+book.gpuName),
                  ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.teal,),
                      Text("  "+book.location),

                    ],
                  ),
                  Divider(color: Colors.white,
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 0,),

                ],
              ),

              onTap:() => setRef(book.foodName) ,
            ),
          ),
        )
    );

  }







  button(){
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
        child: Text(isEditing ? "UPDATE" : "ADD"),
        onPressed: (){
          if(isEditing == true) {
           // updateIfEditing();
          }else{
            //addBook();
          }

          setState(() {
            textFieldVisibility = false;
          });

        },
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(backgroundColor: Colors.teal,
        title: Text('User Favorites'),
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            }),

        actions: <Widget>[
         // IconButton(
          //  icon: Icon(Icons.add),

           // onPressed: (){
           //   Navigator.push(context,
            //      MaterialPageRoute(builder: (context) => ProfilePage()));

          //  },
        //  ),
          IconButton(
            icon: Icon(Icons.fastfood),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Gpu(0)));
            },
          ),

        ],
      ),

      drawer: Drawer(

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.teal),

                currentAccountPicture: ClipOval(
                  child: Image.asset(
                    'assets/Account-512.webp',
                    fit: BoxFit.cover,
                  ),
                )),
            ListTile(
              leading: Icon(Icons.person, color: Colors.teal,),
              title: Text('My Account'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Account()));
              },
            ),

           // ListTile(
             // leading: Icon(Icons.fastfood, color:Colors.teal,),
            //  title: Text('Post Yours'),
             // onTap: () {
              //  Navigator.push(context,
                 //   MaterialPageRoute(builder: (context) => ProfilePage()));
             // },
           // ),
            ListTile(
              leading: Icon(Icons.fastfood, color: Colors.teal,),
              title: Text('Reviews'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookApp()));
              },
            ),
          ],
        ),
      ),



      body:

      Container(

        padding: EdgeInsets.all(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            textFieldVisibility
                ?Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextFormField(
                      controller: bookNameController,
                      decoration: InputDecoration(
                          labelText: "Book Name",
                          hintText: "Enter Book Name"
                      ),
                    ),
                    TextFormField(
                      controller: bookAuthorController,
                      decoration: InputDecoration(
                          labelText: "Book Author",
                          hintText: "Enter Author Name"
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                button()
              ],
            ): Container(),
            SizedBox(
              height: 20,
            ),
            Text("THE MENU", style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.teal
            ),),
            SizedBox(
              height: 20,
            ),
            Flexible(child: buildBody(context),)



          ],
        ),
      ),
    );
  }



}



