import 'package:cloud_firestore/cloud_firestore.dart';


class Book{
  String foodName;
  String location;
  String photo;
  String price;
  String gpuName;


  DocumentReference documentReference;

  Book({this.foodName,this.location,this.photo,this.price,this.gpuName});

  Book.fromMap(Map<String,dynamic> map, {this.documentReference}){
    foodName = map["foodName"];
    location = map["location"];
    photo = map["photo"];
    price = map["price"];
    gpuName = map["gpuName"];


     print("Documents -> $foodName  $location  $price $gpuName  $photo $this.documentReference");

  }

  Book.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, documentReference:snapshot.reference);

  toJson(){
    return{'foodName': foodName, 'location' : location, 'photo' : photo, 'price' : price, 'gpuName' : gpuName};

  }

}