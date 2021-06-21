import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddFoodUnit extends StatefulWidget {


  String category="";



  AddFoodUnit(this.category);

  @override
  _AddFoodUnitState createState() => _AddFoodUnitState();
}

class _AddFoodUnitState extends State<AddFoodUnit> {
  String name="";
  int price=0;
  File? _image;
  ImagePicker _picker=ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add food item",
              ),
        backgroundColor: Colors.blue[900],


      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            //Placeholder(fallbackHeight: 300,),
            CircleAvatar(
              child: (_image==null)?Image.asset("assets/images/app_icon.png"):Image.file(_image!)
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter name",
                labelText: "Name",


              ),
              validator: (value){
                if(value!.isEmpty)
                  return "Name cannot be empty.";
                return null;
              },
              onChanged:(value){
                name=value;
                setState(() {

                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter price",
                labelText: "Price",


              ),
              validator: (value){
                if(value!.isEmpty)
                  return "Name cannot be empty.";
                return null;
              },
              keyboardType: TextInputType.number,
              onChanged:(value){
                name=value;
                setState(() {

                });
              },
            ),
            InkWell(
              onTap: ()=>_showPicker(context),

              child: Container(
                color: Colors.red[400],
                height: 60,
                child: Text("Select Image"),
              ),
            ),
            InkWell(

              child: Container(
                color: Colors.green[400],
                height: 60,
                child: Text("Upload Image"),
              ),
            ),

          ],



        ),
      ),

    );
  }
  _imgFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera,imageQuality: 50
    );

    File image = File(pickedFile.path);
    setState(() {
      _image = image;
    });


  }

  _imgFromGallery() async {
    print("Form gallery");
    final pickedFile = await _picker.getImage(source: ImageSource.gallery,imageQuality: 50
    );

      File image = File(pickedFile.path);
      setState(() {
        _image = image;
      });


  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
