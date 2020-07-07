import 'package:etechapp/UI/test.dart';
import 'package:flutter/material.dart';
import 'package:etechapp/UI/OrderObj.dart';
import 'package:etechapp/UI/CheckOut.dart';
import 'package:social_share/social_share.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:async';
import '';




class AmdGpu extends StatefulWidget {
  @override



  _AmdGpuState createState() => _AmdGpuState();
}

class _AmdGpuState extends State<AmdGpu> {
  List<OrderObj> UserOrder = new List();
  ScreenshotController screenshotController = ScreenshotController();


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

  var description =
  Container(child: Text(
    "Compute Units 36, "
        "Boost Frequency Up To 1340 MHz, "
        "Base Frequency 1257 MHz, "
        "Stream Processors 2304. ",
    textAlign: TextAlign.justify,
    style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),
  ),
      padding: EdgeInsets.all(16)
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.teal,
        title: Text('AMD Ryzen Gpu'),
      ),
      body:
      Screenshot(

        controller: screenshotController,


      child:SafeArea(
        child: Column(


          children: <Widget>[
            Image.asset("assets/gpu2.jpg"),
            description,
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
              onTap: ()=>AddItem('assets/gpu2.jpg', '35000', 'AMD'),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(

                child: Text(
                  'Share To Instagram ', style: TextStyle(fontSize: 16),),
                padding: EdgeInsets.only(
                    top: 2, bottom: 2, right: 5, left: 5),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(
                      Radius.circular(4)),

                ),

              ),
              onTap: ()async{
                await screenshotController.capture().then((image) async{
                  SocialShare.shareInstagramStorywithBackground(image.path,"#ffffff", "#000000", "https://deep-link-url",
                      backgroundImagePath: image.path)
                      .then((data){
                        print(data);
                  });
                });
                },

            ),

            SizedBox(
              height: 20,
            ),

            GestureDetector(
              child: Container(

                child: Text(
                  'Share To Facebook ', style: TextStyle(fontSize: 16),),
                padding: EdgeInsets.only(
                    top: 2, bottom: 2, right: 5, left: 5),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(
                      Radius.circular(4)),

                ),

              ),
              onTap: ()async{
               // await screenshotController.capture().then((image) async{
                  //facebook appId is mandatory for andorid or else share won't work
                  //Platform.isAndroid
                     // ? SocialShare.shareFacebookStory(image.path,
                   //   "#ffffff", "#000000", "https://google.com",
                      //appId: "xxxxxxxxxxxxx")
                    //  .then((data){
                   // print(data);
                //  });
               // });
              },

            ),
            SizedBox(
              height: 100,
            ),
            Padding(


                padding: EdgeInsets.only(top: 5,bottom: 5),
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
        ),
      ),
          ),
    );
  }
}
