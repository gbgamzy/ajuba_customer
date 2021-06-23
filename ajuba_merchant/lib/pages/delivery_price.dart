import 'package:ajuba_merchant/dataClasses/admin.dart';
import 'package:ajuba_merchant/dataClasses/food_menu.dart';
import 'package:ajuba_merchant/pages/home_page.dart';
import 'package:ajuba_merchant/pages/menu.dart';
import 'package:ajuba_merchant/pages/rider.dart';
import 'package:ajuba_merchant/utils/api.dart';
import 'package:ajuba_merchant/utils/routes.dart';
import 'package:ajuba_merchant/utils/toast.dart';
import 'package:ajuba_merchant/widgets/my_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
Admin admin=Admin();
class DeliveryPrice extends StatefulWidget {


  @override
  _DeliveryPriceState createState() => _DeliveryPriceState();
}


class _DeliveryPriceState extends State<DeliveryPrice> {


  @override
  Widget build(BuildContext context) {
    getPricesFromApi();
    double height = MediaQuery.of(context).size.height;

    print(".............................");
    print(admin.minimumPrice);
    return MaterialApp(
      routes: {
        Routes.home : (context)=>HomePage(),
        Routes.menu : (context)=>Menu(),
        Routes.rider : (context)=>RiderPage(),
        Routes.delivery_price : (context)=>DeliveryPrice()


      },
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          title: Text("Delivery price"),
        ),
        drawer: MyDrawer(),
        body:
        Container(
          child: SmartRefresher(
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
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, height/6, 0, 0),
              child: Center(
                child: Column(
                children: [Table(
                  children: [
                    TableRow(
                      children: [
                        Text("Minimum order price",
                        textAlign: TextAlign.center),
                        Text("Delivery charges",
                        textAlign: TextAlign.center),

                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 0),
                          child: TextFormField(
                            initialValue: "${admin.minimumDistance}",
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            onChanged: (value)=>admin.minimumDistance=int.parse(value),
                            key: Key(admin.minimumDistance.toString()+"minimumDistance"),

        ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 0),
                          child: TextFormField(
                            initialValue: admin.minimumPrice.toString(),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            onChanged: (value)=>admin.minimumPrice=int.parse(value.toString()),
                            key: Key(admin.minimumPrice.toString()+"minimumPrice"),



                          ),
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Text("Distance",
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Text("Delivery charges",
                              textAlign: TextAlign.center),
                        ),

                      ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 0),
                            child: TextFormField(
                              initialValue: admin.dist1.toString(),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value)=>admin.dist1=int.parse(value),
                              key: Key(admin.dist1.toString()+"dist1"),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 0),
                            child: TextFormField(
                              initialValue: admin.price1.toString(),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value)=>admin.price1=int.parse(value),
                              key: Key(admin.price1.toString()+"price1"),


                            ),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 0),
                            child: TextFormField(
                              initialValue: admin.dist2.toString(),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value)=>admin.dist2=int.parse(value),
                              key: Key(admin.dist2.toString()+"dist2"),


                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 0),
                            child: TextFormField(
                              initialValue: admin.price2.toString(),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value)=>admin.price2=int.parse(value),
                              key: Key(admin.price2.toString()+"price2"),



                            ),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 0),
                            child: TextFormField(
                              initialValue: admin.dist3.toString(),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value)=>admin.dist3=int.parse(value),
                              key: Key(admin.dist3.toString()+"dist3"),


                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 0),
                            child: TextFormField(
                              initialValue: admin.price3.toString(),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value)=>admin.price3=int.parse(value),
                              key: Key(admin.price3.toString()+"price3"),



                            ),
                          ),
                        ]
                    ),


                  ],
                ),
                  SizedBox(
                    height: height/12,
                  ),
                  ElevatedButton(onPressed: () async{
                    await Api.uploadPrices(admin);
                    ShowToast.showToast(context,"Done",Colors.greenAccent,CupertinoIcons.checkmark_alt);
                  }, child: Text("Upload"))

                ]
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
  getPricesFromApi() async{
    admin=(await Api.getPrices())!;


  }

  @override
  void initState() {
    getPricesFromApi();
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
      await refresh();
      setState((){

      });
    _refreshController.loadComplete();
  }
  refresh() async{
    await getPricesFromApi();
    setState(() {
      print(admin.minimumDistance);
    });
  }

}
