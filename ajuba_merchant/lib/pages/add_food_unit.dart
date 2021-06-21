import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddFoodUnit extends StatefulWidget {


  String category="";


  AddFoodUnit(this.category);

  @override
  _AddFoodUnitState createState() => _AddFoodUnitState();
}

class _AddFoodUnitState extends State<AddFoodUnit> {
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
            Placeholder(fallbackHeight: 300,),
            TextFormField(

            )
          ],



        ),
      ),

    );
  }
}
