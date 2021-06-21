import 'package:ajuba_merchant/dataClasses/food_unit.dart';
import 'package:ajuba_merchant/pages/add_food_unit.dart';
import 'package:ajuba_merchant/utils/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FoodCatalogue extends StatefulWidget {
  String category="";
  getCategory(){
    return category;
  }


  FoodCatalogue(this.category);



  @override
  _FoodCatalogueState createState() => _FoodCatalogueState(category);
}

class _FoodCatalogueState extends State<FoodCatalogue> {
  var category="";
  List<FoodUnit?> foodList = new List.empty(growable: true);

  _FoodCatalogueState(this.category);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (setting){

      },
      home: Scaffold(

        appBar: AppBar(
          title: Text(category),
          backgroundColor: Colors.blue[900],

        ),
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
              title: Text(foodList[index]!.name!),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(Api.base+"Ajuba/images/${foodList[index]!.image}"),
              ),
            );
          },
            itemCount: foodList.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddFoodUnit(category)));
        },
          child: Icon(CupertinoIcons.add),
          backgroundColor: Colors.blueAccent.shade700,



        ),
      ),
    );
  }
  getFoodListFromApi() async{
    foodList.clear();
    List<FoodUnit?> list= await Api.getFoodList();
    list.forEach((element) {
      if(element!.category==category){
        foodList.add(element);
      }
    });
    setState(() {

    });
    foodList.forEach((element) async{
      var image = await Api.getImage(element!.image);

    });


  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await getFoodListFromApi();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if(mounted)
      setState(() async{
        await getFoodListFromApi();
      });
    _refreshController.loadComplete();
  }

}




