import 'package:ajuba_customer/data_classes/food_menu.dart';
import 'package:ajuba_customer/data_classes/food_unit.dart';
import 'package:ajuba_customer/utils/api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(

        appBar: AppBar(
          title: Text("Ajuba"),
          leading: Icon(CupertinoIcons.arrow_left_circle,
          size: 30,),
          backgroundColor: Colors.blue[900],
          centerTitle: true,


        ),
        body:SingleChildScrollView(
          child: Center(
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

                      autoPlayAnimationDuration: Duration(seconds: 2)


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
                DefaultTabController(
                  length: 3,
                  child: Container(
                    color: Colors.blue.shade900,
                    child: TabBar(
                      unselectedLabelColor: Colors.white,
                      automaticIndicatorColorAdjustment: true,
                      overlayColor: MaterialStateProperty.all(Colors.blue.shade900),
                      labelColor: Colors.red,
                      tabs:[
                        Tab(icon: Text("All")),
                        Tab(icon: Text("FastFood")),
                        Tab(icon: Text("Snacks")),

                      ] ,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        )


    );
  }

  @override
  void initState() {



  }
  refresh() async{
    List<FoodMenu?> menu=await Api.getMenu();
    List<FoodUnit?> foodList=await Api.getFoodList();
    foodList.forEach((element) {

    });


  }
  // ignore: unused_element

}
