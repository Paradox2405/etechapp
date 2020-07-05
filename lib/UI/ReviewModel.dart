import 'package:cloud_firestore/cloud_firestore.dart';
import 'Reviews.dart';


class Book{
  String UserName;
  String Comment;

  DocumentReference documentReference;



  Book({this.UserName,this.Comment});

  Book.fromMap(Map<String,dynamic> map, {this.documentReference}){
    UserName = map["userName"];
    Comment = map["comment"];

    print("Documents -> $UserName  $Comment $documentReference");

  }

/*
   void FetchOrderDetail(userId,Itemid ) async {

    await Firestore.instance.collection('Reviews').document(ref).get()
        .then((DocumentSnapshot ds) {

         UserName = ds['userName'];
         Comment = ds['comment'];

         print("Documents 2 -> $UserName  $Comment");


    });

  }


*/



  Book.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, documentReference:snapshot.reference);

  toJson(){
    return{'userName': UserName, 'comment' : Comment};

  }

}