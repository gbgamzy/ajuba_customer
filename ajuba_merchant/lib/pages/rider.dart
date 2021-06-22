import 'package:ajuba_merchant/dataClasses/delivery_boy.dart';
import 'package:ajuba_merchant/utils/api.dart';
import 'package:ajuba_merchant/utils/routes.dart';
import 'package:ajuba_merchant/widgets/my_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'delivery_price.dart';
import 'home_page.dart';
import 'menu.dart';


class RiderPage extends StatefulWidget {


  @override
  _RiderPageState createState() => _RiderPageState();
}

class _RiderPageState extends State<RiderPage> {
  List<Rider?> riders= new List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{

        Routes.menu : (context)=>Menu(),
        Routes.rider : (context)=>RiderPage(),
        Routes.delivery_price : (context)=>DeliveryPrice(),
        Routes.home:(context)=>HomePage()

      },
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text("Riders"),
        ),
        drawer: MyDrawer(),
        body: SmartRefresher(
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
          child: ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              title: Text(riders[index]!.deliveryBoyName!),
            );

          },itemCount: riders.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: Icon(CupertinoIcons.add)
        ),


      ),

    );
  }

  Future<void> _showAddRiderAlertDialog() async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add rider'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  refresh() async{
    riders.clear();
    List<Rider?> list=await Api.getRiderList();

    list.forEach((element) {
      print(element!.deliveryBoyName);
      riders.add(element);
    });
    setState(() {

    });


  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await refresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if(mounted)
      setState(() async{
        await refresh();
      });
    _refreshController.loadComplete();
  }
}

