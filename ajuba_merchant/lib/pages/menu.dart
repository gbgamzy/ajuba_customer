import 'package:ajuba_merchant/dataClasses/food_menu.dart';
import 'package:ajuba_merchant/pages/food_catalogue.dart';
import 'package:ajuba_merchant/pages/rider.dart';
import 'package:ajuba_merchant/utils/api.dart';
import 'package:ajuba_merchant/utils/routes.dart';
import 'package:ajuba_merchant/widgets/my_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'delivery_price.dart';
import 'home_page.dart';

class Menu extends StatefulWidget {



  @override
  _MenuState createState() => _MenuState();

}

class _MenuState extends State<Menu> {
  List<FoodMenu?> menu=new List.empty(growable:true);
  refresh() async{
    print("refresh");

     menu= await getMenuFromApi();
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


  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{

        //Routes.menu : (context)=>Menu(),
        Routes.rider : (context)=>RiderPage(),
        Routes.delivery_price : (context)=>DeliveryPrice(),
        Routes.home:(context)=>HomePage()


      },

      
      home: Scaffold(
        
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text("Menu"),

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
              title: Text(menu[index]!.category!),
              leading: Image.asset("assets/images/fast-food.png"),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>FoodCatalogue(menu[index]!.category!)));
                 },
            );
          },
          itemCount: menu.length,
          ),
        )
      ),
    );
  }



}
getMenuFromApi() async{



    return await Api.getMenu();
}


