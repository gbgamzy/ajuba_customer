import 'dart:async';
import 'dart:convert';


import 'package:ajuba_customer/data_classes/admin.dart';
import 'package:ajuba_customer/data_classes/food_menu.dart';
import 'package:ajuba_customer/data_classes/food_unit.dart';
import 'package:ajuba_customer/data_classes/message.dart';
import 'package:ajuba_customer/data_classes/order.dart';
import 'package:ajuba_customer/data_classes/rider.dart';


import 'package:http/http.dart' as http;

abstract class Api{
  static String base = "http://ajubabhaturewala.co.in/";
  static String image = "http://ajubabhaturewala.co.in/Ajuba/images/";


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
  static getImage(String? imgId) async{
    final url = Uri.parse(base+"Ajuba/images/$imgId");
    final response=await http.get(url);

    return response;

  }
  static Future<Admin?> getPrices() async{
    final url = Uri.parse(base+"Ajuba/admin/getAdmin");
    var response=await http.get(url);

    Map<String,dynamic> map=jsonDecode(response.body);

    Admin? admin=Admin.fromMap(map);
    return admin;

  }

  static placeOrder(String phone,Order order) async{
    final url = Uri.parse(base+"Ajuba/placeOrder/$phone");
    print("jsonAdmin");



    var response=await http.post(url,body:jsonEncode(order),headers:{"Content-Type":"application/json"});
    Map<String,dynamic> map=jsonDecode(response.body);

    print(map);

  }

  static Future<List<Order?>> getOrders(String phone) async{
    List<Order?> list = new List.empty(growable: true);
    final url = Uri.parse(base+"Ajuba/customer/$phone/orders");
    final response=await http.get(url);

    List<dynamic> values = json.decode(response.body);
    if(values.length>0){
      for(int i=0;i<values.length;i++){
        if(values[i]!=null){
          Map<String,dynamic> map=values[i];
          list.add(Order.fromMap(map));

        }
      }
    }
    print(list[0]);
    return list;
  }

  static Future<Rider> getRider(String phone) async{
    final url = Uri.parse(base+"Ajuba/customer/rider/$phone");
    var response=await http.get(url);

    Map<String,dynamic> map=jsonDecode(response.body);

    Rider rider=Rider.fromMap(map);
    return rider;
  }
  static Future<Message?> login(String phone,String registrationToken,String name) async{
    final url = Uri.parse(base+"Ajuba/customer/$phone/$registrationToken/$name");
    print("jsonAdmin");



    var response=await http.post(url,headers:{"Content-Type":"application/json"});
    Map<String,dynamic> map=jsonDecode(response.body);

    print(map);
  }



}