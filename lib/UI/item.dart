import 'package:cloud_firestore/cloud_firestore.dart';


class Item{
  String gpuName;
  String gpuType;
  String location;
  String price;
  String photo;

  DocumentReference documentReference;

  Item({this.gpuName,this.gpuType,this.location,this.price,this.photo});

  Item.fromMap(Map<String,dynamic> map, {this.documentReference}){

     gpuName  = map["gpuName"];

     location = map["location"];
     price = map["price"];
     photo = map["photo"];



    // print("Documents -> $bookName  $authorName");

  }

  Item.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, documentReference:snapshot.reference);

  toJson(){
    return{'gpuName': gpuName, 'location' : location, 'price' : price, 'photo' : photo};

  }

}