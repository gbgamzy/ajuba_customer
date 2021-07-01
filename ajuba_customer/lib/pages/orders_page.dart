import 'package:ajuba_customer/data_classes/order.dart';
import 'package:ajuba_customer/utils/api.dart';
import 'package:ajuba_customer/widgtes/ticket_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {


  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order?> orders = List.empty(growable: true);
  String phone="7009516346";
  @override
  void initState() {

    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
          backgroundColor: Colors.blue.shade900,
        ),
      backgroundColor: Colors.grey[50],
      body: Container(
        child: ListView.builder(itemBuilder: (context, index) {
          return TicketOrders(orders[index]);
        },
        itemCount: orders.length,),
      ),
      );

  }


  refresh() async{

    orders=await Api.getOrders(phone);
    setState(() {

    });

  }

}
