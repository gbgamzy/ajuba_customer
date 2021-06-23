import 'package:ajuba_merchant/dataClasses/customer.dart';
import 'package:ajuba_merchant/dataClasses/orders.dart';
import 'package:ajuba_merchant/utils/screen_h_w.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Order? order;
Customer? customer;
class UserReportPage extends StatefulWidget {



  UserReportPage();
  UserReportPage.order(Order? o){
    order=o;
  }

  @override
  _UserReportPageState createState() => _UserReportPageState();
}

class _UserReportPageState extends State<UserReportPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          //title: Text("${order!.name}"),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade50,
                    child: Icon(CupertinoIcons.profile_circled,
                      size: 90,
                    ),
                    maxRadius: 60,
                  ),
                ),
                //Text("${order!.contents}"),
                //Text("${order!.houseName}, ${order!.streetAddress}"),
                Table(
                  children: [
                    TableRow(
                      children: [
                        Text("${customer!.successCount}"),
                        Divider(

                        )
                      ]
                    )
                  ],
                )

              ],
            ),
          ),
        ),

      )
    );
  }
}
