
import 'package:flutter/cupertino.dart';

class Dimension{

  static getHeight(BuildContext context)=>MediaQuery.of(context).size.height;
  static getWidth(BuildContext context)=>MediaQuery.of(context).size.width;



}