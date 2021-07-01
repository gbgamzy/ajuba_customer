

import 'package:ajuba_customer/data_classes/address.dart';
import 'package:ajuba_customer/data_classes/food_menu.dart';
import 'package:ajuba_customer/data_classes/food_unit.dart';
import 'package:ajuba_customer/utils/api.dart';
import 'package:ajuba_customer/utils/routes.dart';
import 'package:ajuba_customer/utils/screen_h_w.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  int _tabLength=0;
  double deliveryPrice=0;
  double cartValue=0;
  bool panel=false;
  bool refreshed=false;
  double height=0,width=0;
  List<FoodMenu> menuList=List.empty(growable: true);
  List<FoodUnit> foodList=List.empty(growable: true);

  SharedPreferences? prefs;

  
  List<Tab> tabs = List.empty(growable: true);
  List<FoodUnit> cart = List.empty(growable: true);
  List<Address> address = List.empty(growable: true);
  int selectedAddress=-1;

  @override
  Widget build(BuildContext context) {
    height=Dimension.getHeight(context);
    width=Dimension.getWidth(context);

    cart.clear();
    cartValue=0;

    foodList.sort((a,b)=>b.price.compareTo(a.price));
    foodList.forEach((element) {
      if(element.quantity>0){
        cart.add(element);
        cartValue+=element.quantity*element.price;
      }
    });
    if(!Hive.isAdapterRegistered(0))
      Hive.registerAdapter(AddressAdapter());
    Hive.openBox("address");
    getAddress();

    return MaterialApp(
      home:

        SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: false,
          child: Scaffold(
          backgroundColor: Colors.grey.shade50,

          body:
            SlidingUpPanel(

              panelBuilder: (scrollController){
                return buildSlidingPanel(scrollController);
              },
              onPanelOpened: (){
                panel=true;
                setState(() {

                });
              },
              onPanelClosed: (){
                panel=false;
                setState(() {

                });
              },


              parallaxEnabled: true,
              backdropTapClosesPanel: true,
              collapsed: Column(
                children: [
                  Expanded(child: Icon(Icons.horizontal_rule_rounded,size: 40,color: Colors.black26,),
                  flex:1
                  ),
                  Expanded(
                    flex:2,
                    child: Row(

                      children: [
                        Expanded(
                          flex:1,
                          child: InkWell(
                            onTap: (){

                            },
                            child: InkWell(
                              child: Column(
                                children: [
                                  Icon(CupertinoIcons.arrow_left_circle_fill),
                                  Text("Log out"),
                                ],
                              ),
                              onTap: (){
                                prefs!.setBool("logged", false);
                                Navigator.popAndPushNamed(context, Routes.login);


                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child:Column(
                            children: [
                              Icon(Icons.shopping_cart),
                              Text("Cart")
                            ],
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: InkWell(
                            onTap: () {
                              print("Clicked");
                              Navigator.pushNamed(context,Routes.orders);
                              },
                            child: Column(
                              children: [
                                Icon(CupertinoIcons.cube_box),
                                Text("Orders"),
                              ],
                            ),
                          ),
                        ),


                      ],
                    ),
                  )
                ],
              ),

              defaultPanelState: panel?PanelState.OPEN:PanelState.CLOSED,
              backdropEnabled: true,

              renderPanelSheet: true,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              panelSnapping: false,
              maxHeight: height/1.5,



              body: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ListView(
                  children: [Center(

                  child: Column(

                    children: [

                      Material(
                        borderRadius: BorderRadius.circular(10),
                        child: CarouselSlider(


                          options: CarouselOptions(height: MediaQuery.of(context).size.width*9/16,
                            autoPlay: true,
                            autoPlayCurve: Curves.ease,
                            enableInfiniteScroll: true,
                            aspectRatio: 16/9,

                            autoPlayAnimationDuration: Duration(seconds: 2),


                          ),
                          items: [1,2,3,4,5].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(


                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(

                                        width: MediaQuery.of(context).size.width,
                                        height:  MediaQuery.of(context).size.width*9/16,
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.amber
                                        ),
                                        child: Text('text $i', style: TextStyle(fontSize: 16.0),)

                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                         ),

                      ),
                      foodList.length>0?Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {

                          return Padding(
                            
                            padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 4.0),

                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Container(



                                decoration: BoxDecoration(



                                  borderRadius:  BorderRadius.circular(20),
                                  //border: Border(top: BorderSide(),bottom: BorderSide(),left: BorderSide(),right: BorderSide()),

                                ),
                                child: Column(
                                  children: [

                                    AspectRatio(
                                      child: Image.network(Api.image+foodList[index].image,centerSlice: Rect.largest,

                                      ),
                                      aspectRatio: 16/9,
                                    ),
                                    ListTile(
                                      title: Text(foodList[index].name,textScaleFactor: 1.1,),
                                      subtitle: Text("Rs. "+foodList[index].price.toString()),
                                      trailing:
                                      (foodList[index].quantity<1)?Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              foodList[index].quantity=1;
                                              foodList.forEach((element) {print(element.name);});
                                            });
                                          },
                                          enableFeedback: true,
                                          splashColor: Colors.redAccent,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: Colors.red),
                                            ),
                                            width: Dimension.getWidth(context)/3.7,
                                            child: Center(
                                              child: Text("+ Add",textScaleFactor: 1.1,style: TextStyle(
                                                  color:Colors.red,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                            ),
                                          ),
                                        ),
                                      )
                                          :Container(
                                        width: Dimension.getWidth(context)/3.7,
                                        child: Row(

                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                              child: InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    foodList[index].quantity-=1;
                                                  });
                                                },
                                                child: Container(
                                                  child: Icon(CupertinoIcons.minus_circle,size: 30,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text("${foodList[index].quantity}",textScaleFactor: 1.2,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                              child: InkWell(
                                                onTap: (){
                                                  foodList[index].quantity+=1;
                                                  setState(() {

                                                  });
                                                },

                                                child: Container(
                                                    child: Icon(CupertinoIcons.plus_circle,size:30,color: Colors.green,)
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                          addAutomaticKeepAlives:true,
                          shrinkWrap: true,

                        itemCount: foodList.length,
                        ),
                      ):Container(),
                      SizedBox(
                        height: height/5,
                      )

                    ],
                  ),
                  ),],
                ),
              ),
            ),

          ),
        ),



    );
  }


  @override
  void initState() {
    super.initState();

    refresh();


  }
  getAddress()async{
    var box = Hive.box("address");

    address.clear();
    box.values.forEach((element) {
      address.add(element);
    });
  }
  refresh() async{
    prefs= await SharedPreferences.getInstance();
    getAddress();
    List<FoodMenu?> menu=await Api.getMenu();
    _tabLength=menu.length+1;
    print(_tabLength);
    FoodMenu all = FoodMenu();
    all.category="All";

    menuList.add(all);
    menu.forEach((element) {
      print(element!.category);
      menuList.add(element);
    });

    List<FoodUnit?> foodList1=await Api.getFoodList();
    foodList1.forEach((element) async{

      foodList.add(element!);






    });
    refreshed=true;
    setState(() {

    });


  }

  Widget buildSlidingPanel(ScrollController scrollController) {
    return panel?Container(
      color:Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ListView(
          //physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(child: Text("Address book",textAlign: TextAlign.left,textScaleFactor: 1.2,
                  style:TextStyle(fontWeight: FontWeight.bold)
              ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),



                ),
                child:Center(
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: Dimension.getHeight(context)/5,

                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        controller: ScrollController(
                            initialScrollOffset:-1
                        ),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),

                        itemBuilder: (context, index) {

                          return Align(
                            alignment: Alignment.topCenter,
                            child: Center(
                              heightFactor: 0.9,
                              child: InkWell(
                                onTap: (){

                                  selectedAddress=index;
                                  setState(() {

                                  });
                                },
                                child: ListTile(
                                  selected: (selectedAddress==index)?true:false,

                                  title: Text("${address[index].homeAddress}"),
                                  subtitle: Text("${address[index].streetAddress}"),
                                  leading: Icon(CupertinoIcons.location_fill,color: Colors.blue,),
                                  trailing: InkWell(child: Icon(CupertinoIcons.delete_solid,color: Colors.red,),
                                    onTap: (){
                                      if(!Hive.isAdapterRegistered(0))
                                        Hive.registerAdapter(AddressAdapter());

                                      var box = Hive.box("address");
                                      box.deleteAt(index);
                                      setState(() {

                                      });


                                    },

                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount:address.length,

                        shrinkWrap: true,
                        addRepaintBoundaries: true,
                      ),
                    ),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  print("Click");
                  Navigator.pushNamed(context, Routes.addAddress);
                },
                child: Container(child: Text("+ Add Address",textAlign: TextAlign.left,textScaleFactor: 1.2,
                    style:TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[900])
                ),
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(child: Text("Cart",textAlign: TextAlign.left,textScaleFactor: 1.2,
                      style:TextStyle(fontWeight: FontWeight.bold)
                  ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Card(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: ListView.builder(itemBuilder: (context, index) {
                      return ListTile(
                        leading:Container(child: Image.network(Api.image+cart[index].image,centerSlice: Rect.largest,),
                          width: Dimension.getWidth(context)/8,

                        ),
                        title: Text(cart[index].name),
                        subtitle: Text("${cart[index].price}"),
                        trailing: Container(
                          width: Dimension.getWidth(context)/4.2,
                          child: Row(

                            children: [
                              SizedBox(
                                  width:Dimension.getWidth(context)/400
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      foodList.forEach((element) {
                                        if(element.FUID==cart[index].FUID)
                                          element.quantity--;
                                      });
                                    });
                                  },
                                  child: Container(
                                    child: Icon(CupertinoIcons.minus_circle,size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text("${cart[index].quantity}",textScaleFactor: 1.2,),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                child: InkWell(
                                  onTap: (){
                                    foodList.forEach((element) {
                                      if(element.FUID==cart[index].FUID)
                                        element.quantity++;
                                    });
                                    setState(() {

                                    });
                                  },

                                  child: Container(
                                      child: Icon(CupertinoIcons.plus_circle,size:30,color: Colors.green,)
                                  ),
                                ),
                              ),
                            ],
                          ),


                        ),

                      );

                    },
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,

                      itemCount: cart.length,
                    ),
                  ),
                ),
                Card(
                  child: Center(
                    heightFactor: 2,
                    child: Column(
                      children: [
                        Text("Delivery price: Rs. $deliveryPrice"),
                        Text("Total price: Rs. ${deliveryPrice+cartValue}"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height/25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height/20,
                    width: width/3,
                    child: ElevatedButton(onPressed: (){

                    }, child: Text("Place order",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                    ),
                  ),
                ),
                SizedBox(
                  height: height/25,
                )


              ],
            )

          ],
        ),
      ),
    ):Container(

    );

  }

  // ignore: unused_element

}

