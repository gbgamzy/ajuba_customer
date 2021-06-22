import 'package:ajuba_merchant/pages/menu.dart';
import 'package:ajuba_merchant/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int selection=0;

class MyDrawer extends StatefulWidget {


  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {



  @override
  Widget build(BuildContext context) {
    return Material(
      child: Drawer(

        child: Column(
          children: [
            DrawerHeader(
              child:Image.asset("assets/images/app_icon.png",
                height: 200,
                width: 200,

              )


            ),
            ListTile(
              selected: selection==0?true:false,
              onTap: selection!=0?() {
                Navigator.popAndPushNamed(context, Routes.home);
                selection=0;
                setState(() {
                  print(selection);
                });
              }:(){},

              contentPadding: EdgeInsets.symmetric(vertical:8,horizontal: 30),
              title: Text("Home",
                textScaleFactor: 1.2,
                style: TextStyle(

                ),
              ),
              enableFeedback: true,
              leading: Icon(CupertinoIcons.home),


            ),


            ListTile(
              selected: selection==1?true:false,
              onTap:selection!=1?(){
                Navigator.popAndPushNamed(context, Routes.menu);
                selection=1;
                setState(() {
                  print(selection);
                });
              }:(){},


              contentPadding: EdgeInsets.symmetric(vertical:8,horizontal: 30),
              title: Text("Food Menu",
                textScaleFactor: 1.2,
                style: TextStyle(


                ),

              ),
              enableFeedback: true,
              leading: Image.asset("assets/images/food_menu.png",
                height: 25,




              ),




            ),


            ListTile(
              selected: selection==2?true:false,
              contentPadding: EdgeInsets.symmetric(vertical:8,horizontal: 30),
              title: Text("Riders",
                textScaleFactor: 1.2,
                style: TextStyle(

                ),
              ),
              enableFeedback: true,
              leading: Image.asset("assets/images/bicycle.png",height: 28,
                isAntiAlias: true,
                ),
              onTap:selection!=2?(){
                Navigator.popAndPushNamed(context,Routes.rider);

                selection=2;
                setState(() {
                  print(selection);
                });
              }:(){},

            ),


            ListTile(
              selected: selection==3?true:false,
              contentPadding: EdgeInsets.symmetric(vertical:8,horizontal: 30),
              title: Text("Delivery Price",
                textScaleFactor: 1.2,
                style: TextStyle(

                ),
              ),
              enableFeedback: true,
              leading: Icon(CupertinoIcons.money_dollar_circle),
              onTap:selection!=3?() {
                Navigator.popAndPushNamed(context, Routes.delivery_price);
                selection=3;
                setState(() {
                  print(selection);
                });

              }:(){},

            ),


            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical:8,horizontal: 30),
              title: Text("Log out",
                textScaleFactor: 1.2,
                style: TextStyle(

                ),
              ),
              enableFeedback: true,
              leading: Icon(CupertinoIcons.arrow_left_circle,

              ),
              onTap:(){

              },

            ),

          ],
        ),

      ),
    );
  }
}

