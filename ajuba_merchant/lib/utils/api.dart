import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:ajuba_merchant/dataClasses/admin.dart';
import 'package:ajuba_merchant/dataClasses/delivery_boy.dart';
import 'package:ajuba_merchant/dataClasses/food_menu.dart';
import 'package:ajuba_merchant/dataClasses/food_unit.dart';
import 'package:ajuba_merchant/dataClasses/message.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;



abstract class Api{

  static String base = "http://ajubabhaturewala.co.in/";

  static Future<List<FoodMenu?>> getMenu() async{
    print("api called");
    List<FoodMenu?> list = new List.empty(growable: true);
    final url = Uri.parse(base+"Ajuba/customer/menu");
    final response=await http.get(url);

    List<dynamic> values = json.decode(response.body);
    if(values.length>0){
      for(int i=0;i<values.length;i++){
        if(values[i]!=null){
          Map<String,dynamic> map=values[i];
          list.add(FoodMenu.fromMap(map));

        }
      }
    }
    print(list[0]);
    return list;

  }
  static deleteMenu(String category) async{
    final url = Uri.parse(base+"Ajuba/admin/foodMenu/category/$category");

    await http.delete(url);
  }
  static deleteFood(String category,FoodUnit food) async{
    final url = Uri.parse(base+"Ajuba/admin/foodMenu/$category/food/${food.name}");

    await http.delete(url);
  }
  static deleteImage(String id) async{
    final url = Uri.parse(base+"Ajuba/images/$id");

    await http.delete(url);
  }
  static addMenu(String category) async{
    final url = Uri.parse(base+"Ajuba/admin/foodMenu/category/$category");
    await http.post(url);

  }
  static Future<List<FoodUnit?>> getFoodList() async{
    List<FoodUnit?> list = new List.empty(growable: true);
    final url = Uri.parse(base+"Ajuba/customer/food");
    final response=await http.get(url);

    List<dynamic> values = json.decode(response.body);
    if(values.length>0){
      for(int i=0;i<values.length;i++){
        if(values[i]!=null){
          Map<String,dynamic> map=values[i];
          list.add(FoodUnit.fromMap(map));

        }
      }
    }

    return list;
  }
  static deleteFoodUnit(String category,String name) async{
    final url = Uri.parse(base+"Ajuba/admin/foodMenu/$category/food/$name");
    await http.delete(url);

  }
  static getImage(String? imgId) async{
    final url = Uri.parse(base+"Ajuba/images/$imgId");
    final response=await http.get(url);

    return response;

  }
  static enableItem(int fuid) async {
    final url = Uri.parse(base+"Ajuba/admin/foodMenu/$fuid/1");
    await http.post(url);
  }
  static disableItem(int fuid) async {
    final url = Uri.parse(base+"Ajuba/admin/foodMenu/$fuid/0");
    await http.post(url);
  }
  static addFood(String category,FoodUnit foodUnit) async{
    final url = Uri.parse(base+"Ajuba/admin/foodMenu/$category/food");
    await http.post(url,body: foodUnit.toJson());
  }
  static uploadImage(File _image) async{
    final uri = Uri.parse(base+"Ajuba/images");
    // open a byteStream
    
    var stream = new http.ByteStream(http.ByteStream.fromBytes(_image.readAsBytesSync()));
    // get file length
    var length = await _image.length();

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file.. here this "image_file" is a key of the API request
    var multipartFile = new http.MultipartFile('upload', stream, length, filename: _image.path);

    // add file to multipart
    request.files.add(multipartFile);

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });


    }).catchError((e) {
      print(e);
    });








  }

  static Future<List<Rider?>> getRiderList() async{
    List<Rider?> list = new List.empty(growable: true);
    final url = Uri.parse(base+"Ajuba/admin/getRidersList");
    final response=await http.get(url);

    List<dynamic> values = json.decode(response.body);
    print(values);
    if(values.length>0){
      for(int i=0;i<values.length;i++){
        if(values[i]!=null){

          Map<String,dynamic> map=values[i];
          list.add(Rider.fromMap(map));

        }
      }
    }


    return list;
  }
  static addRider(Rider rider) async{
    final url = Uri.parse(base+"Ajuba/admin/getRidersList");
    await http.post(url,body: rider.toJson());
  }
  static deleteRider(String phone) async{
    final url = Uri.parse(base+"Ajuba/admin/getRidersList/$phone");
    await http.delete(url);
  }
  static Future<Admin?> getPrices() async{
    final url = Uri.parse(base+"Ajuba/admin/prices");
    var response=await http.get(url);

    Map<String,dynamic> map=jsonDecode(response.body);

    Admin? admin=Admin.fromMap(map);
    return admin;

  }

  static uploadPrices(Admin admin) async{
    final url = Uri.parse(base+"Ajuba/admin/prices");
    print("jsonAdmin");
    print(jsonEncode(admin));


    var response=await http.post(url,body:jsonEncode(admin),headers:{"Content-Type":"application/json"});
    Map<String,dynamic> map=jsonDecode(response.body);

    print(map);


  }






}