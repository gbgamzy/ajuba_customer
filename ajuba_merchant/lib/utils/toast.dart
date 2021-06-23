import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast{

  static FToast fToast=FToast();

  static init(BuildContext context){
    fToast.init(context);
  }


  static showToast( BuildContext context,String text, Color? color,IconData? icon){
      fToast.init(context);
      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            icon!=null?Icon(icon):SizedBox(),
            SizedBox(
            width: icon!=null?12.0:0.0,
            ),
            Text(text),
          ],
        ),
      );


      fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
      );



  }



}