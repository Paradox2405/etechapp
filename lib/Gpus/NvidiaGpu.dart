import 'package:flutter/material.dart';
import 'package:etechapp/UI/OrderObj.dart';
import 'package:etechapp/UI/CheckOut.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';


class NvidiaGpu extends StatefulWidget {
  @override
  _NvidiaGpuState createState() => _NvidiaGpuState();
}

class _NvidiaGpuState extends State<NvidiaGpu> {
  ScreenshotController screenshotController = ScreenshotController();
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

  var description =
  Container(child: Text(
    " The powerful new GeForce RTX™ 2070  "
        "takes advantage of the cutting-edge NVIDIA Turing™ architecture "
        "to immerse you in incredible realism and performance "
        " in the latest games. The future of gaming starts here.  ",
    textAlign: TextAlign.justify,
    style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),
  ),
      padding: EdgeInsets.all(16)
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.teal,
        title: Text('Nvidia Gpu'),
      ),
      body: Screenshot(

        controller: screenshotController,


        child:SafeArea(
          child: Column(


            children: <Widget>[
              Image.asset("assets/gpu3.jpg"),
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
                onTap: ()=>AddItem('assets/gpu3.jpg', '250000', 'Nvidia'),
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
                height: 50,
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
