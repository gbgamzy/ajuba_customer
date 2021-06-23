import 'package:ajuba_merchant/dataClasses/food_menu.dart';
import 'package:ajuba_merchant/pages/food_catalogue.dart';
import 'package:ajuba_merchant/pages/rider.dart';
import 'package:ajuba_merchant/utils/api.dart';
import 'package:ajuba_merchant/utils/routes.dart';
import 'package:ajuba_merchant/utils/screen_h_w.dart';
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
  String? name;
  final _addMenu = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double height=Dimension.getHeight(context);
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
        backgroundColor: Colors.grey.shade50,
        
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

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
              child: ListTile(
                contentPadding: EdgeInsets.all(8),

                title: Text(menu[index]!.category!),
                tileColor: Colors.white,
                leading: Image.asset("assets/images/fast-food.png",
                    height: 70,
                ),

                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>FoodCatalogue(menu[index]!.category!)));
                   },
                trailing: InkWell(
                  onTap: () async{
                    showDialog(context: context, builder: (context1){
                      return AlertDialog(
                        title: Text("Confirm delete?"),
                        content: Container(

                          child: Row(
                              children:[
                                SizedBox(
                                  width: Dimension.getWidth(context)/2.5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: InkWell(
                                    onTap: () async{
                                      await Api.deleteMenu(menu[index]!.category!);
                                      refresh();
                                      Navigator.of(context1).pop();
                                    },
                                    child: Text("Yes",
                                      style: TextStyle(
                                          color: Colors.blueAccent
                                      ),


                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.of(context1).pop();
                                    },
                                    child: Text("No",
                                      style: TextStyle(
                                          color: Colors.blueAccent
                                      ),),
                                  ),
                                )
                              ]
                          ),
                        ),
                      );
                    });

                  },
                  child: Icon(CupertinoIcons.delete_simple,
                    color: Colors.red.shade300,

                  ),
                ),
              ),
            );
          },
          itemCount: menu.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (context1){
              return AlertDialog(
                title: Text("Add menu"),
                content: Container(
                  height: height/7,
                  child: Form(
                    key:_addMenu,
                    child: Column(


                      children: [
                        TextFormField(
                          onChanged: (value)=> name=value,
                          decoration: InputDecoration(
                            hintText: "Enter title",
                            labelText: "Title",

                          ),
                          validator: (value){
                            if(value!.isEmpty)
                              return "Cannot be empty";
                            else
                              return null;
                          },
                        ),
                        SizedBox(
                          height:height/50
                        ),
                        ElevatedButton(onPressed: () async{
                          if(_addMenu.currentState!.validate()) {
                            await Api.addMenu(name!);
                            Navigator.of(context1).pop();
                            refresh();
                          }

                        }, child: Text("Add"))
                      ],
                    ),
                  ),
                ),
              );
            });
          },
          child: Icon(CupertinoIcons.add),
        ),
      ),
    );
  }



}
getMenuFromApi() async{



    return await Api.getMenu();
}


