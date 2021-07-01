
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

abstract class StorageDirectory{


  static Future<String> getlocalPath() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  
  


  static Future<File> getFile(String name) async {
    final path = getlocalPath;
    return File('$path/$name');
  }
  static saveFile(File file,String name) async {
    final path = getlocalPath;
    await file.copy("$path/$name") ;



  }

}