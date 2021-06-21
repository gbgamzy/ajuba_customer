
import 'dart:convert';

import 'package:ajuba_merchant/utils/api.dart';
import 'package:ajuba_merchant/widgets/my_drawer.dart';
import 'package:ajuba_merchant/widgets/orders_ticket.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'menu.dart';
import '../utils/routes.dart';


import '../dataClasses/orders.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count=0;
  DateTime date=DateTime.now();


  List<Order?> pending=new List.empty(growable: true) ;

  List<Order?> processing=new List.empty(growable: true) ;

  List<Order?> dispatched=new List.empty(growable: true) ;

  List<Order?> today=new List.empty(growable: true) ;

  @override
  Widget build(BuildContext context) {
    try{
      refreshHome("", "");
    }
    catch(e){
      print(e);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{

        Routes.menu : (context)=>Menu()
      },
      home: DefaultTabController(
        length: 4,
        
        child: Scaffold(
          appBar: AppBar(
            title: Text("Ajuba ",

            ),
            backgroundColor: Colors.blue.shade900,
            bottom: TabBar(tabs: [
              Tab(text: "Pending",),
              Tab(text: "Processing",),
              Tab(text: "Dispatched",),
              Tab(text: "Completed",),
            ],
            enableFeedback: true,
              automaticIndicatorColorAdjustment: true,
              
              ),
            ),
          body: Container(
            color: Colors.grey.shade200,
            child: TabBarView(
              children: [
                ListView.builder(

                  itemCount: pending.length,
                  itemBuilder: (context,index){
                      return TicketOrders(pending[index]) ;
                  },
                ),ListView.builder(
                  itemCount: processing.length,
                  itemBuilder: (context,index){
                      return TicketOrders(processing[index]) ;
                  },
                ),ListView.builder(
                  itemCount: dispatched.length,
                  itemBuilder: (context,index){
                      return TicketOrders(dispatched[index]) ;
                  },
                ),ListView.builder(
                  itemCount: today.length,
                  itemBuilder: (context,index){
                      return TicketOrders(today[index]) ;
                  },
                ),
              ],
            ),
          ),
          drawer: MyDrawer(),




        )



            ),
      );






  }

  refreshHome(String phone,String token) async{
    count=0;
    var client=http.Client();
    /*getPending(client);
    getProcessing(client);
    getDispatched(client);*/


    getToday(client, date.day.toString(), date.month.toString(), date.year.toString());


  }

  getPending(http.Client client) async{

    if(count==4){

      setState(() {

      });
      client.close();

    }
    else {
      var response = await client
          .get(Uri.parse(Api.base + "Ajuba/admin/getPendingOrders"));
      pending.clear();
      print(count);
      count++;

      List<dynamic>? list = json.decode(response.body);

      list!.forEach((element) {
        Map<String, dynamic> map = json.decode(element);
        pending.add(Order.fromMap(map));
      });
    }
  }

  getProcessing(http.Client client) async{

    if(count==4){

      setState(() {

      });
      client.close();

    }

    else{
      count++;
    var response = await client.get(Uri.parse(Api.base + "Ajuba/admin/getProcessingOrders"));
      processing.clear();
      print(count);
      List<dynamic>? list = json.decode(response.body);

      list!.forEach((element) {
        Map<String, dynamic> map = json.decode(element);
        processing.add(Order.fromMap(map));
      });
    }
  }

  getDispatched(http.Client client) async{

    if(count==4){

      setState(() {

      });
      client.close();

    }
    else{
      var response = await client.get(
          Uri.parse(Api.base + "Ajuba/admin/getDispatchedOrders"));
      dispatched.clear();
      print(count);
      count++;

      List<dynamic>? list = json.decode(response.body);


      setState(() {
        list!.forEach((element) {
          Map<String, dynamic> map = json.decode(element);
          print("map");
          print(map);
          dispatched.add(Order.fromMap(map));
        });
      });
    }
  }

  getToday(http.Client client,String day,String month,String year) async{
    if(day.length==1){
      day="0"+day;
    }
    if(month.length==1){
      month="0"+month;
    }


    if(count==1){

      setState(() {

      });
      client.close();

    }
    else{
      var response = await client
          .get(Uri.parse(Api.base + "Ajuba/admin/orders/$day/$month/$year"));
      today.clear();

      print(count);
      count++;

      List<dynamic> values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            today.add(Order.fromMap(map));

          }
        }
      }

    }
  }
}
