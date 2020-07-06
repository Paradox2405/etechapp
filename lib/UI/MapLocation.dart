import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class MapLocation extends StatefulWidget {
  @override
  _MapLocationState createState() => _MapLocationState();

}

class _MapLocationState extends State<MapLocation> {


List <Marker> allMarkers=[];
void initState(){
 super.initState();
 allMarkers.add(Marker(
     markerId: MarkerId('myMarker'),
 draggable: false,
 infoWindow:InfoWindow(
   title: 'E-Tech Store'
 ),

 onTap: (){
       print('marker tapped');

 },
 position: LatLng(6.886922, 79.918706)
 ));
}


  GoogleMapController mapController;

  final LatLng _center = const LatLng(6.886922, 79.918706);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }




    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.teal,
          title: Text('Find Our Store Here'),
        ),

        body:
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
          markers: Set.from(allMarkers),
        ),
      );
      
    }
  }

