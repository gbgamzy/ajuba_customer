
import 'package:flutter/cupertino.dart';

class Dimension{

  static double getHeight(BuildContext context)=>MediaQuery.of(context).size.height;
  static double getWidth(BuildContext context)=>MediaQuery.of(context).size.width;



}