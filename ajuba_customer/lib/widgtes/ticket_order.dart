
import 'package:ajuba_customer/data_classes/order.dart';
import 'package:ajuba_customer/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class TicketOrders extends StatelessWidget {
  late Order? order;


  TicketOrders(Order? ord) {
    order = ord;
  }



  @override
  Widget build(BuildContext context) {
    List<String> date = order!.date!.split(" ");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),

          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          //color:Colors.red,


          child: Container(


              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 40),
                          child: Icon(
                              CupertinoIcons.circle_fill, color: order!.status!="C"?Colors.red:Colors.green),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(

                            children: [
                              Text("${order?.contents}",
                                textScaleFactor: 1.2,
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 5,),
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text("Rs. ${order?.price}",
                                      textScaleFactor: 1.2,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerRight,

                                        child: order!.date!=null?Text("${date[0]}/${date[1]}"):Text("Date",
                                          textAlign: TextAlign.right,

                                          textScaleFactor: 1.2,
                                        ),

                                      ),
                                    )


                                  ]
                              )


                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                      child: Table(
                        children: [
                          TableRow(


                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    child: Text(
                                      "Name", textAlign: TextAlign.center,),
                                    alignment: Alignment.center,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    child:
                                    Text("${order?.name}",
                                      textAlign: TextAlign.center,),
                                    alignment: Alignment.center,
                                  ),
                                ),

                              ]
                          ),
                          TableRow(


                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    child: Text(
                                      "Address", textAlign: TextAlign.center,),
                                    alignment: Alignment.center,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(child: Text(
                                    "${order?.houseName}, ${order
                                        ?.streetAddress}",
                                    textAlign: TextAlign.center,),
                                    alignment: Alignment.center,),
                                ),

                              ]
                          ),
                          TableRow(


                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    child: Text(
                                      "Status", textAlign: TextAlign.center,),
                                    alignment: Alignment.center,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    child: Text(order!.status=="A"?"Pending":order!.status=="A2"?"Processing":order!.status=="B"?"Dispatched"
                                      :order!.status=="C"?"Delivered":order!.status=="D"?"Cancelled":"",
                                      style: TextStyle(
                                        color: Colors.red
                                      ),
                                      textAlign: TextAlign.center,),
                                    alignment: Alignment.center,),
                                ),

                              ]
                          ),

                          order!.status=="B"?TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red.shade600,
                                    child: InkWell(
                                      splashColor: Colors.redAccent,
                                        onTap: ()=>launch("tel://${order!.deliveryBoy!}"),
                                        child: Icon(CupertinoIcons.phone)),
                                    radius: 30,


                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: InkWell(
                                    splashColor: Colors.white,
                                    onTap: (){
                                      Navigator.pushNamed(context, Routes.locateOrder);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 30,
                                      child: Icon(CupertinoIcons.location),
                                    ),
                                  ),
                                ),
                              ]
                          ):TableRow(
                            children: [
                              Container(
                                height: 0,
                              ),
                              Container(
                                height: 0,
                              )
                            ]
                          )
                        ],


                      ),
                    ),

                  ],

                ),
              )
          )
      ),
    );
  }
}