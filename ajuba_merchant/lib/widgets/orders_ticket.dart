import 'package:ajuba_merchant/dataClasses/orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


class TicketOrders extends StatelessWidget {
  late Order? order;


  TicketOrders(Order? ord){
    order=ord;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: Card(
          elevation: 4,

          margin: EdgeInsets.symmetric(horizontal: 2,vertical: 8),
          //color:Colors.red,



          child:Container(


            child:Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 40),
                        child: Icon(CupertinoIcons.circle_fill,color:Colors.red),
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
                                textDirection:TextDirection.ltr    ,
                              ),

                                Expanded(
                                  flex:1,
                                  child: Container(
                                    alignment: Alignment.centerRight,

                                    child: Text("Date",
                                    textAlign: TextAlign.right,

                                      textScaleFactor: 1.2,
                                    ),

                                  ),
                                )


                              ]
                            )


                          ],
                          crossAxisAlignment:CrossAxisAlignment.start ,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                    child: Table(
                      children: [
                        TableRow(


                          children:[
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(child: Text("Name",textAlign: TextAlign.center,),alignment: Alignment.center,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(child:
                              Text("${order?.name}",textAlign: TextAlign.center,),alignment: Alignment.center,
                              ),
                            ),

                          ]
                        ),
                        TableRow(


                          children:[
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(child: Text("Address",textAlign: TextAlign.center,),alignment: Alignment.center,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(child: Text("${order?.houseName}, ${order?.streetAddress}",
                                textAlign: TextAlign.center,),alignment: Alignment.center,),
                            ),

                          ]
                        ),
                        TableRow(


                          children:[
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(child: Text("Rider",textAlign: TextAlign.center,),alignment: Alignment.center,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(child: Text("${order?.deliveryBoy}",textAlign: TextAlign.center,),alignment: Alignment.center,),
                            ),

                          ]
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.red.shade600,
                                child:Icon(CupertinoIcons.person_2_fill),
                                radius: 30,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                child:Icon(CupertinoIcons.train_style_one),
                                radius: 30,

                              ),
                            ),
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
