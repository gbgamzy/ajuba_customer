import 'dart:async';
import 'dart:collection';
import 'package:ajuba_customer/data_classes/rider.dart';
import 'package:ajuba_customer/utils/api.dart';
import 'package:geolocator/geolocator.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
String phone="";
class LocateOrderPage extends StatefulWidget {



  @override
  _LocateOrderPageState createState() => _LocateOrderPageState();
}

class _LocateOrderPageState extends State<LocateOrderPage> {



  Marker? marker;
  Completer<GoogleMapController> _controller = Completer();
  LatLng position=LatLng(30.4762,74.5122);


  @override
  Widget build(BuildContext context) {

    getCurrentLoc();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Location"),
        centerTitle: true,

      ),
      body:GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(30.4762,74.5122),
            tilt: 19.440717697143555,
            zoom: 13.151926040649414

        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

        markers: {
          Marker(markerId: MarkerId("mark1"),
            anchor: Offset(0.5,1.0),
            icon: BitmapDescriptor.defaultMarker,
            position: position

          )
        },
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (p){
          goTo(p);
        },


      ),
    );
  }
  Future<void> goTo(LatLng position1) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(

        tilt: 19.440717697143555,
        zoom: 18.151926040649414,
       target:position1
    )));
    position=position1;
    setState(() {

    });
  }
  refresh() async {
    Rider rider = await Api.getRider(phone);
    goTo(LatLng(rider.latitude,rider.longitude));


  }

  getCurrentLoc() async{
    print("hi");
    var x = await _determinePosition();

    goTo(LatLng(x.latitude, x.longitude));
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }



}
