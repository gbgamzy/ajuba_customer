import 'package:ajuba_merchant/pages/menu.dart';
import 'package:ajuba_merchant/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MyDrawer extends StatelessWidget {


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
              onTap:(){
                Navigator.pushNamed(context, Routes.menu);
              },


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
              onTap:(){

              },

            ),


            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical:8,horizontal: 30),
              title: Text("Delivery Price",
                textScaleFactor: 1.2,
                style: TextStyle(

                ),
              ),
              enableFeedback: true,
              leading: Icon(CupertinoIcons.money_dollar_circle),
              onTap:(){

              },

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

