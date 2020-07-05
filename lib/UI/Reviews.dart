import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:etechapp/UI/test.dart';
import 'package:etechapp/UI/test.dart';
import 'Account.dart';
import 'Food.dart';
import 'OrderList.dart';
import 'ProfilePage.dart';
import 'test.dart';
import 'ReviewModel.dart';




class BookApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test',
      home: BookFirebaseDemo2(),
    );
  }
}



class BookFirebaseDemo2 extends StatefulWidget {




  BookFirebaseDemo2() : super();


  final String appTitle = "Reviews";

  @override
  _BookFirebaseDemoState2 createState() => _BookFirebaseDemoState2();
}




class _BookFirebaseDemoState2 extends State<BookFirebaseDemo2> {




  TextEditingController UserNameController = TextEditingController();
  TextEditingController CommentController = TextEditingController();

  bool isEditing = false;
  bool textFieldVisibility =false;

  String storeCollectionName = "Reviews";

  Book currentBook;

  final passed = BookFirebaseDemo();



  getAllBooks(){


    String test = passed.getMRef();

    return Firestore.instance.collection(storeCollectionName).document(test).collection(test).snapshots();
  }


  addBook() async {
    Book book = Book(UserName: UserNameController.text, Comment: CommentController.text);


    try{

      Firestore.instance.runTransaction(
              (Transaction transaction) async{
            await Firestore.instance
                .collection(storeCollectionName)
                .document(passed.getMRef())
                .collection(passed.getMRef())
                .document()
                .setData(book.toJson());
          }
      );

    }catch(e){
      print(e.toString());
    }


  }











  updateBook(Book book, String userName, String Comment){

    try{
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(book.documentReference, {'userName':userName,'comment':Comment});

      });
    }catch(e){
      print(e.toString());
    }

  }


  updateIfEditing(){
    if (isEditing){

      updateBook(currentBook, UserNameController.text, CommentController.text);

      setState(() {
        isEditing = false;
      });

    }
  }


  deleteBook(Book book){
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

    final book = Book.fromSnapshot(data);

    return Padding(
        key: ValueKey(book.UserName),
        padding: EdgeInsets.symmetric(vertical : 19, horizontal: 1),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal),
            borderRadius: BorderRadius.circular(4),
          ),
          child: SingleChildScrollView(
            child: ListTile(
              title: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.person, color: Colors.teal,),
                      Text("  "+book.UserName, style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Icon(Icons.comment, color: Colors.teal,),
                      RichText(
                        text: TextSpan(
                          text: '  ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: '  '+book.Comment,),

                          ],
                        ),
                      )
                    ],
                  ),

                      RichText(
                        text: TextSpan(
                          text: '  ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            //TextSpan(text: '  lkvnrvirhnvr gie eigejr ggrgio jregio greerio gre iog eroi greio gregio re ioreioreioo  e  i'+book.Comment,),

                          ],
                        ),
                      )
                    ],

              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red,),
                onPressed: (){
                  deleteBook(book);

                },
              ),
              onTap: (){
                setUpdateUI(book);
              },
            ),
          ),
        )
    );

  }


  setUpdateUI(Book book){
    UserNameController.text = book.UserName;
    CommentController.text = book.Comment;

    setState(() {
      textFieldVisibility = true;
      isEditing = true;
      currentBook = book;
    });
  }


  button(){
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
        child: Text(isEditing ? "UPDATE" : "ADD"),
        onPressed: (){
          if(isEditing == true) {
            updateIfEditing();
          }else{
            addBook();
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
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            }),
        title: Text("Reviews"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.fastfood),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookApp()));
            },
          ),
          IconButton(
            icon: Icon(Icons.add),

              onPressed: (){
                setState(() {
                  textFieldVisibility = !textFieldVisibility;
                });

            },
          )
        ],
      ),

      drawer: Drawer(

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.teal),
                //accountName: Text('$name'),
                //accountEmail: Text('$email'),
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

            ListTile(
              leading: Icon(Icons.fastfood, color:Colors.teal,),
              title: Text('Post Yours'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
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





      body: Container(
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
                      controller: UserNameController,
                      decoration: InputDecoration(
                          labelText: "Name",
                          hintText: "Your Name"
                      ),
                    ),
                    TextFormField(
                      controller: CommentController,
                      decoration: InputDecoration(
                          labelText: "Comment",
                          hintText: "Your Comment"
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
            Text("Reviews", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800
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



