
import 'dart:convert';


import 'package:ajuba_merchant/pages/delivery_price.dart';
import 'package:ajuba_merchant/pages/rider.dart';
import 'package:ajuba_merchant/utils/api.dart';
import 'package:ajuba_merchant/widgets/my_drawer.dart';
import 'package:ajuba_merchant/widgets/orders_ticket.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'menu.dart';
import '../utils/routes.dart';


import '../dataClasses/orders.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with
    AutomaticKeepAliveClientMixin<HomePage>{
  late int count;
  DateTime date=DateTime.now();


  List<Order?> pending=new List.empty(growable: true) ;

  List<Order?> processing=new List.empty(growable: true) ;

  List<Order?> dispatched=new List.empty(growable: true) ;

  List<Order?> today=new List.empty(growable: true) ;

  @override
  Widget build(BuildContext context) {





    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes:{

        Routes.menu : (context)=>Menu(),
        Routes.rider : (context)=>RiderPage(),
        Routes.delivery_price : (context)=>DeliveryPrice()


      },
      home: DefaultTabController(
        length: 4,
        
        child: Scaffold(
          appBar: AppBar(

            title: Text("Ajuba"),

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


                   SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: ClassicHeader(),

                    controller: _refreshController1,
                    onRefresh: _onRefresh1,
                    onLoading: _onLoading1,


                    child: ListView.builder(

                      itemCount: pending.length,
                      itemBuilder: (context,index){
                          return TicketOrders(pending[index]) ;
                      },
                    ),
                  ),
                SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: ClassicHeader(),
                  footer:CustomFooter(
                    builder: (context,mode){
                      Widget body ;
                      if(mode==LoadStatus.idle){
                        body =  Text("pull up load");
                      }
                      else if(mode==LoadStatus.loading){
                        body =  CupertinoActivityIndicator();
                      }
                      else if(mode == LoadStatus.failed){
                        body = Text("Load Failed!Click retry!");
                      }
                      else if(mode == LoadStatus.canLoading){
                        body = Text("release to load more");
                      }
                      else{
                        body = Text("No more Data");
                      }
                      return Container(
                        height: 55.0,
                        child: Center(child:body),

                      );
                    },
                  ),
                  controller: _refreshController2,
                  onRefresh: _onRefresh2,
                  onLoading: _onLoading2,

                  child: ListView.builder(
                    itemCount: processing.length,
                    itemBuilder: (context,index){
                        return TicketOrders(processing[index]) ;
                    },
                  ),
                ),SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: ClassicHeader(),
                  footer:CustomFooter(
                    builder: (context,mode){
                      Widget body ;
                      if(mode==LoadStatus.idle){
                        body =  Text("pull up load");
                      }
                      else if(mode==LoadStatus.loading){
                        body =  CupertinoActivityIndicator();
                      }
                      else if(mode == LoadStatus.failed){
                        body = Text("Load Failed!Click retry!");
                      }
                      else if(mode == LoadStatus.canLoading){
                        body = Text("release to load more");
                      }
                      else{
                        body = Text("No more Data");
                      }
                      return Container(
                        height: 55.0,
                        child: Center(child:body),

                      );
                    },
                  ),
                  controller: _refreshController3,
                  onRefresh: _onRefresh3,
                  onLoading: _onLoading3,

                  child: ListView.builder(
                    itemCount: dispatched.length,
                    itemBuilder: (context,index){
                        return TicketOrders(dispatched[index]) ;
                    },
                  ),
                ),SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: ClassicHeader(),
                  footer:CustomFooter(
                    builder: (context,mode){
                      Widget body ;
                      if(mode==LoadStatus.idle){
                        body =  Text("pull up load");
                      }
                      else if(mode==LoadStatus.loading){
                        body =  CupertinoActivityIndicator();
                      }
                      else if(mode == LoadStatus.failed){
                        body = Text("Load Failed!Click retry!");
                      }
                      else if(mode == LoadStatus.canLoading){
                        body = Text("release to load more");
                      }
                      else{
                        body = Text("No more Data");
                      }
                      return Container(
                        height: 55.0,
                        child: Center(child:body),

                      );
                    },
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,

                  child: ListView.builder(
                    itemCount: today.length,
                    itemBuilder: (context,index){
                        return TicketOrders(today[index]) ;
                    },
                  ),
                ),
              ],
            ),
          ),
          drawer: MyDrawer(),




        )



            ),
      );






  }

  refreshHome() async{
    count=0;
    var client=http.Client();
    getPending(client);
    getProcessing(client);
    getDispatched(client);


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
      List<dynamic> values = json.decode(response.body);
      print(values);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            pending.add(Order.fromMap(map));

          }
        }
      }
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
      List<dynamic> values = json.decode(response.body);
      print(values);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            processing.add(Order.fromMap(map));

          }
        }
      }
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



      List<dynamic> values = json.decode(response.body);
      print(values);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            dispatched.add(Order.fromMap(map));

          }
        }
      }
      else{
        return;
      }
    }
  }

  getToday(http.Client client,String day,String month,String year) async{
    if(day.length==1){
      day="0"+day;
    }
    if(month.length==1){
      month="0"+month;
    }


    if(count==4){

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
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  RefreshController _refreshController1 =
  RefreshController(initialRefresh: false);
  RefreshController _refreshController2 =
  RefreshController(initialRefresh: false);
  RefreshController _refreshController3=
  RefreshController();

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await refreshHome();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  void _onRefresh1() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await refreshHome();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading1() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  void _onRefresh2() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await refreshHome();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading2() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  void _onRefresh3() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await refreshHome();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading3() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if(mounted)
      setState((){

      });
    _refreshController.loadComplete();
  }

  @override
  bool get wantKeepAlive => true;

}
