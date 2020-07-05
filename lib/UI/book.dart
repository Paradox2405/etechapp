import 'package:cloud_firestore/cloud_firestore.dart';


class Book{
  String foodName;
  String location;
  String photo;
  String price;
  String restName;


  DocumentReference documentReference;

  Book({this.foodName,this.location,this.photo,this.price,this.restName});

  Book.fromMap(Map<String,dynamic> map, {this.documentReference}){
    foodName = map["foodName"];
    location = map["location"];
    photo = map["photo"];
    price = map["price"];
    restName = map["resturantName"];


     print("Documents -> $foodName  $location  $price $restName  $photo $this.documentReference");

  }

  Book.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, documentReference:snapshot.reference);

  toJson(){
    return{'foodName': foodName, 'location' : location, 'photo' : photo, 'price' : price, 'resturantName' : restName};

  }

}