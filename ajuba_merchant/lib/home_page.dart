
import 'dart:convert';

import 'package:ajuba_merchant/utils/api.dart';
import 'package:ajuba_merchant/widgets/my_drawer.dart';
import 'package:ajuba_merchant/widgets/orders_ticket.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import 'dataClasses/orders.dart';


class HomePage extends StatelessWidget {
  int count=0;
  List<Order?> pending=new List.empty(growable: true) ;
  List<Order?> processing=new List.empty(growable: true) ;
  List<Order?> dispatched=new List.empty(growable: true) ;
  List<Order?> today=new List.empty(growable: true) ;




  @override
  Widget build(BuildContext context) {
    //refreshHome("","");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          body: TabBarView(
            children: [
              /*ListView.builder(
                itemCount: 100,
                itemBuilder: (context,index){
                    return TicketOrders(pending![index]) ;
                },
              ),*/
              Icon(CupertinoIcons.phone),Icon(CupertinoIcons.phone),
              Icon(CupertinoIcons.phone),
              Icon(CupertinoIcons.phone_down),
            ],
          ),
          drawer: MyDrawer(),




        )



            ),
      );






  }


 /* refreshHome(String phone,String token) async{

    var client=http.Client();


  }
  getPending(http.Client client) async{
    var response= await client.get(Uri.parse(Api.base+"/Ajuba/admin/getPendingOrders"));
    pending.clear();
    count++;
    if(count==4){
      count=0;
      client.close();
    }

    List<dynamic>? list= json.decode(response.body);

    list!.forEach((element) {
      Map<String,dynamic> map= json.decode(element);
      pending.add(Order.fromMap(map));
    });

  }
  getProcessing(http.Client client) async{
    var response= await client.get(Uri.parse(Api.base+"/Ajuba/admin/getProcessingOrders"));
    processing.clear();
    count++;
    if(count==4){
      count=0;
      client.close();
    }

    List<dynamic>? list= json.decode(response.body);

    list!.forEach((element) {
      Map<String,dynamic> map= json.decode(element);
      processing.add(Order.fromMap(map));
    });

  }
  getDispatched(http.Client client) async{
    var response= await client.get(Uri.parse(Api.base+"/Ajuba/admin/getDispatchedOrders"));
    dispatched.clear();
    count++;
    if(count==4){
      count=0;
      client.close();
    }

    List<dynamic>? list= json.decode(response.body);

    list!.forEach((element) {
      Map<String,dynamic> map= json.decode(element);
      dispatched.add(Order.fromMap(map));
    });

  }
  getToday(http.Client client,String day,String month,String year) async{
    var response= await client.get(Uri.parse(Api.base+"Ajuba/admin/orders/$day/$month/$year"));
    today.clear();
    count++;
    if(count==4){
      count=0;
      client.close();

    }

    List<dynamic>? list= json.decode(response.body);

    list!.forEach((element) {
      Map<String,dynamic> map= json.decode(element);
      today.add(Order.fromMap(map));
    });

  }
*/
}
