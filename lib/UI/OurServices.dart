import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Services extends StatefulWidget {
  @override



  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {


  var description =
  Container(child: Text(
    "We offer the following services at E-Tech Store ",
    textAlign: TextAlign.justify,
    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16 ,height: 2, color: Color(0xFF6F8398),),


  ),
      padding: EdgeInsets.all(0)
  );

  var bullets=
      Container(child: Text(
        '''
   •Life Time Warranty on Products Purchased at
     Our Store
   •Delivery of GPUs Purchased at Our Store
   •Fixing GPUs to your devices at the comfort of
     your home
   •Repairing of GPUs Purchased at Our Store''',
        maxLines: 20,
        textAlign: TextAlign.justify,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,height: 3,color: CupertinoColors.black),

      ),
          padding: EdgeInsets.all(0)
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,
        title: Text('Our Speciality'),
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),

           // Image.asset(name)
            description,
            SizedBox(
              height: 50,
            ),
            bullets,
            SizedBox(
              height: 180,
            ),



            GestureDetector(
              child: Container(
                child: Text('Tap Here to get our Special Services Delivered to your Door Step',
                  style: TextStyle(fontSize: 13),),

                padding: EdgeInsets.only(
                    top: 8, bottom: 8, right: 8, left: 8),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(
                      Radius.circular(4)),

                ),

              ),
            ),

          ],


        ),
      ),



    );
  }
}
