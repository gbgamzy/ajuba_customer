import 'dart:async';



import 'package:ajuba_customer/data_classes/address.dart';
import 'package:ajuba_customer/utils/screen_h_w.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';

class AddAddressPage extends StatefulWidget {


  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {


  var box = Hive.box("address");


  GlobalKey<FormState> _addAddressKey = GlobalKey();
  Marker? marker;
  String homeAddress="",streetAddress="";
  Completer<GoogleMapController> _controller = Completer();
  LatLng position=LatLng(30.4762,74.5122);
  Location location = Location();
  @override
  void initState() {

    super.initState();

    getLoc();

  }
  @override
  Widget build(BuildContext context) {
    double height=Dimension.getHeight(context);
    double width=Dimension.getWidth(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
      ),
      body:Stack(
        children: [GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(30.4762,74.5122),
              tilt: 19.440717697143555,
              zoom: 13.151926040649414

          ),
          onTap: (position1){
            position=position1;
            goTo(position1);
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            Marker(markerId: MarkerId("mark1"),
                anchor: Offset(0.5,1),
                icon: BitmapDescriptor.defaultMarker,
                position: position,


            )
          },
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: true,




        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Form(
              key: _addAddressKey,
              child: Card(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                margin: EdgeInsets.all(16),
                child: Wrap(
                  
                  alignment: WrapAlignment.center,
                  children: [Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Add address",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex:5,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 8),
                                    child: TextFormField(
                
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                
                                        labelText: "Home address",
                                        hintText: "Enter home address"
                                      ),
                                      validator: (value){
                                        if(value!.isEmpty) {
                                          return "Cannot be empty";
                                        }
                                        return null;
                                      },
                                      onChanged: (value)=>homeAddress=value,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 8, 0, 30),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        labelText: "Street address",
                                        hintText: "Enter street address"
                                      ),
                                      validator: (value){
                                        if(value!.isEmpty) {
                                          return "Cannot be empty";
                                        }
                                        return null;
                                      },
                                      onChanged: (value)=>streetAddress=value,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex:1,
                            child: Center(
                
                              child: CircleAvatar(
                                child:InkWell(
                                  onTap: (){
                                    saveAddress();
                
                                  },
                                  child: Icon(CupertinoIcons.checkmark_alt),
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                
                    ]
                  
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () async{
                  print("clickedddedede");
                  await getCurrentLoc();
                },
                child: CircleAvatar(
                  child:Icon(CupertinoIcons.location)
                ),
              ),
            ),
          )
      ])
    );
  }
  saveAddress()async{
    if(_addAddressKey.currentState!.validate() ){
      Address address = Address(
        homeAddress,streetAddress,position.latitude,position.longitude
      );

      if(!Hive.isAdapterRegistered(0))
      Hive.registerAdapter(AddressAdapter());

      Hive.openBox("address");

      
      box.add(address);
      Navigator.pop(context);




    }
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
  getLoc() async{
    print("hi");
    var x = await _determinePosition();

    goTo(LatLng(x.latitude, x.longitude));
  }

}
