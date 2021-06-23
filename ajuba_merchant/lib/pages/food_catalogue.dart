import 'package:ajuba_merchant/dataClasses/food_unit.dart';
import 'package:ajuba_merchant/pages/add_food_unit.dart';
import 'package:ajuba_merchant/utils/api.dart';
import 'package:ajuba_merchant/utils/screen_h_w.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
              child: ListTile(
                tileColor: Colors.white,
                contentPadding: EdgeInsets.all(12),
                title: Text(foodList[index]!.name!),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(Api.base+"Ajuba/images/${foodList[index]!.image}"),
                  maxRadius: 40,
                ),
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
                                      await Api.deleteFood(category, foodList[index]!);

                                      Navigator.of(context1).pop();
                                      getFoodListFromApi();
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
            itemCount: foodList.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddFoodUnit(category)));
        },
          child: Icon(CupertinoIcons.add),
          backgroundColor: Colors.blueAccent.shade700,



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
    setState(() {

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
      setState(() {

      });
    _refreshController.loadComplete();
  }

}




