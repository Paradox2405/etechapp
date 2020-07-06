import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(backgroundColor: Colors.teal),

        bottomNavigationBar: ContactUsBottomAppBar(
          companyName: 'E-Tech Store',
          textColor: Colors.white,
          backgroundColor: Colors.teal.shade300,
          email: 'etech@gmail.com',
        ),
        backgroundColor: Colors.teal,
        body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.teal.shade900,
          email: 'etech@gmail.com',
          companyName: 'E-Tech Store',
          companyColor: Colors.teal.shade100,
          phoneNumber: '+94719017983',
          website: 'https://etech.lk',
          githubUserName: 'udeshj1998',
          tagLine: 'GPU Specialists ',
          taglineColor: Colors.teal.shade100,
          instagram: 'udeshj1998',
          facebookHandle: 'E-tech-107632344351245',
        ),
      ),
    );
  }
}