import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactus/contactus.dart';
import 'package:etechapp/UI/MapLocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:etechapp/UI/Account.dart';
import 'package:etechapp/UI/CheckOut.dart';
import 'package:etechapp/UI/OrderList.dart';
import 'package:etechapp/UI/OrderObj.dart';
import 'package:etechapp/model/DataBase.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ContactUs.dart';
import 'MainHome.dart';
import 'ProfilePage.dart';
import 'test.dart';
import 'Reviews.dart';

class Food extends StatefulWidget {
  var userID;
 Food(this.userID);
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {

  var userID;
  var name='User1';
  var email ='exampe@mail.com';
  var items ='';
  List<OrderObj> UserOrder = new List();

  CheckoutBtn(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CheckOut(UserOrder: UserOrder,)));

  }

  AddItem(var img,var price,var name){

    setState(() {
      UserOrder.add(OrderObj(name: name,img: img,price: price));

    });
  }











  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

      FirebaseAuth.instance.currentUser().then((userid) {
        Firestore.instance
            .collection('user info')
            .document(userid.uid)
            .get()
            .then((DocumentSnapshot ds) {
          // use ds as a snapshot
          setState(() {
            name = ds['name'];
            email = ds['email'];
          });

        });
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((userid) {
      Firestore.instance
          .collection('user info')
          .document(userid.uid)
          .get()
          .then((DocumentSnapshot ds) {
        // use ds as a snapshot
        setState(() {
          userID = userid.uid;
          name = ds['name'];
          email = ds['email'];
        });

      });
    });

    return Scaffold(

        appBar: AppBar(backgroundColor: Colors.teal,
          leading: Builder(
              builder: (BuildContext context){
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              }),
          title: Text("Order List"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.archive),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookApp()));
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
                accountName: Text('$name'),
                accountEmail: Text('$email'),
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
              leading: Icon(Icons.shopping_cart, color:Colors.teal,),
              title: Text('My Orders'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderList(userId:userID)));
              },
            ),
            ListTile(
              leading: Icon(Icons.public, color:Colors.teal,),
              title: Text('Our Services'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.fastfood, color: Colors.teal,),
              title: Text('User Favorites'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookApp()));
              },
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.teal,),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Contact()));
              },
            ),

            ListTile(
              leading: Icon(Icons.location_on, color: Colors.teal,),
              title: Text('Locate Us'),
              onTap: () {
                FlutterToast.showToast(msg: "Tap Marker to Navigate",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapLocation()));

                },
            ),
          ],
        ),
      ),



      body:
      SingleChildScrollView(

        child: Column(
          children: <Widget>[

            SizedBox(
              height: 15,
            ),
            Text("E-Tech", style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.teal
            ),),
            SizedBox(
              height: 10,
            ),
            ConstrainedBox(

              constraints: BoxConstraints(maxHeight:MediaQuery.of(context).size.height*0.75),
              child: GridView.count(
                crossAxisCount: 1,

                children: <Widget>[


                  Card(


                    child: Column(
                      children: <Widget>[

                        SizedBox(

                          height: 300,
                          width: double.infinity,
                          child: Image.asset('assets/burger.jpg', height: 240,
                            fit: BoxFit.cover,),
                        ),
                        Text('AMD Ryzen', style: TextStyle(fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w900),),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('RS: 35000.00', style: TextStyle(fontWeight: FontWeight.w800),),
                                GestureDetector(
                                  child: Container(

                                    child: Text(
                                      'Add to cart', style: TextStyle(fontSize: 16),),
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4)),

                                    ),

                                  ),
                                  onTap:() => AddItem('assets/burger.jpg', '1.2', 'Beef Burger') ,
                                )
                              ],
                            )
                        )

                      ],
                    ),
                  ),
                  Card(
                    child: Column(


                      children: <Widget>[
                        SizedBox(


                          height: 290,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/checkenBurger.jpg', height: 240,
                            fit: BoxFit.cover,),
                        ),

                        Text('Nvidia RTX 2070', style: TextStyle(fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w900),),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('RS:250000.00', style: TextStyle(fontWeight: FontWeight.w800),),
                                GestureDetector(
                                  child: Container(

                                    child: Text(
                                      'Add to cart', style: TextStyle(fontSize: 16),),
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4)),

                                    ),

                                  ),
                                  onTap: ()=>AddItem('assets/checkenBurger.jpg', '1.2', 'AMD'),
                                )
                              ],
                            )
                        )

                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Image.asset('assets/pancake.jpg', height: 100,
                            fit: BoxFit.cover,),
                        ),
                        Text('ASUS', style: TextStyle(fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w900),),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('RS:20000.00', style: TextStyle(fontWeight: FontWeight.w800),),
                                GestureDetector(
                                  child: Container(

                                    child: Text(
                                      'Add to cart', style: TextStyle(fontSize: 16),),
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4)),

                                    ),

                                  ),
                                  onTap: () => AddItem('assets/pancake.jpg', '0.8', 'Nvidia'),
                                )
                              ],
                            )
                        )

                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/chesscake.jpeg', height: 100,
                            fit: BoxFit.cover,),
                        ),
                        Text('Gigabyte', style: TextStyle(fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w900),),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('RS:12000.00', style: TextStyle(fontWeight: FontWeight.w800),),
                                GestureDetector(
                                  child: Container(

                                    child: Text(
                                      'Add to cart', style: TextStyle(fontSize: 16),),
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4)),

                                    ),

                                  ),
                                  onTap: () =>AddItem('assets/chesscake.jpeg', '1.5', 'Nvdia'),
                                )
                              ],
                            )
                        )

                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Image.asset('assets/avocado.jpeg', height: 100,
                            fit: BoxFit.cover,),
                        ),
                        Text('AMD', style: TextStyle(fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w900),),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('RS:130000.00', style: TextStyle(fontWeight: FontWeight.w800),),
                                GestureDetector(
                                  child: Container(

                                    child: Text(
                                      'Add to cart', style: TextStyle(fontSize: 16),),
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4)),

                                    ),

                                  ),
                                  onTap: () =>AddItem('assets/avocado.jpeg', '1.5', 'ASUS'),
                                )
                              ],
                            )
                        )

                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Image.asset('assets/orange.jpg', height: 240,
                            fit: BoxFit.cover,),
                        ),
                        Text('Nvidia GTX 1080', style: TextStyle(fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w900),),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('RS: 110000.00', style: TextStyle(fontWeight: FontWeight.w800),),
                                GestureDetector(
                                  child: Container(

                                    child: Text(
                                      'Add to cart', style: TextStyle(fontSize: 16),),
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4)),

                                    ),

                                  ),
                                  onTap: ()=>AddItem('assets/orange.jpg', '1.0', 'Palit'),
                                )
                              ],
                            )
                        )

                      ],
                    ),
                  ),

                ],

              ),
            ),
            Padding(


              padding: EdgeInsets.only(top: 5,bottom: 20),
                child:RaisedButton(onPressed: () => CheckoutBtn(),
                  child: Text('(${UserOrder.length}) CheckOut',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),
                  shape:RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.teal)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 9.0,horizontal: 40.0),
                  color: Colors.teal,
                )
            )

          ],
        )
      )
    );
  }



}


