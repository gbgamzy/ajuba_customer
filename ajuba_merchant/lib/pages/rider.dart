import 'package:ajuba_merchant/dataClasses/delivery_boy.dart';
import 'package:ajuba_merchant/utils/api.dart';
import 'package:ajuba_merchant/utils/routes.dart';
import 'package:ajuba_merchant/utils/screen_h_w.dart';
import 'package:ajuba_merchant/utils/toast.dart';
import 'package:ajuba_merchant/widgets/my_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'delivery_price.dart';
import 'home_page.dart';
import 'menu.dart';
List<DropdownMenuItem<String?>> names = new List.empty(growable: true);

class RiderPage extends StatefulWidget {


  @override
  _RiderPageState createState() => _RiderPageState();
}

class _RiderPageState extends State<RiderPage> {
  List<Rider?> riders= new List.empty(growable: true);
  final _addRiderKey = GlobalKey<FormState>();



  String? name,phone;
  @override
  Widget build(BuildContext context) {
    double height=Dimension.getHeight(context);
    double width=Dimension.getWidth(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{

        Routes.menu : (context)=>Menu(),
        Routes.rider : (context)=>RiderPage(),
        Routes.delivery_price : (context)=>DeliveryPrice(),
        Routes.home:(context)=>HomePage()

      },
      home: Scaffold(
        backgroundColor: Colors.grey.shade50,
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
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),


                tileColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(riders[index]!.deliveryBoyName!),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(riders[index]!.deliveryBoyPhone!),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/bicycle.png",
                    color: Colors.indigo,
                  ),
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
                                width: width/2.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: InkWell(
                                  onTap: () async{
                                    await Api.deleteRider(riders[index]!.deliveryBoyPhone!);
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

          },itemCount: riders.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context,
                builder: (context1){
                  return AlertDialog(
                    scrollable:true ,
                    title: Text("Add rider"),

                    content: Container(
                      child:Form(
                        key: _addRiderKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  hintText: "Enter name"

                                ),
                                onChanged: (value)=>name=value,
                                validator:(value){
                                  if(value!.isEmpty)
                                    return "Name cannot be empty";
                                  else
                                    return null;
                                },

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Phone number",
                                  hintText: "Enter phone number"

                                ),
                                onChanged: (value)=>phone=value,
                                validator:(value){
                                  if(value!.length!=10)
                                    return "Invalid";
                                  else
                                    return null;
                                },

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(onPressed:() async{
                                if(_addRiderKey.currentState!.validate()){
                                      addRider();
                                      ShowToast.showToast(
                                          context,
                                          "Done",
                                          Colors.greenAccent,
                                          CupertinoIcons.checkmark_alt);
                                      Navigator.of(context1).pop();
                                    }
                                  }, child: Text("Add rider")),
                            )
                          ],
                        ),
                      )
                    ),
                  );
                }

            );


          },
          child: Icon(CupertinoIcons.add)
        ),


      ),

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

  addRider() async{
    Rider rider = new Rider();
    rider.deliveryBoyName=name;
    rider.deliveryBoyPhone=phone;

    await Api.addRider(rider);
    refresh();
  }
}

