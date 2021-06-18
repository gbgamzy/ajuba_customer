
import 'package:flutter/material.dart';
import 'package:ajuba_merchant/utils/routes.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String name="";
  bool changeButton=false;


  final _formKey = GlobalKey<FormState>();

  moveToHome() async{
    if(_formKey.currentState!.validate()) {
      setState(() {
        changeButton = !changeButton;
      });
      await Future.delayed(
        Duration(milliseconds: 1000),
      );
      if (changeButton) await Navigator.pushNamed(context, Routes.home);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
    child:SingleChildScrollView(
      child: Center(
         child: Form(
           key:_formKey,
           child: Column(

                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0,0,0,0),
                    child: Image.asset("assets/images/app_icon.png",
                       scale:1.3,


                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 50.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        labelText: "Name",


                      ),
                      validator: (value){
                        if(value!.isEmpty)
                          return "Name cannot be empty.";
                        return null;
                      },
                      onChanged:(value){
                        name=value;
                        setState(() {

                        });
                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 50.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,

                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
                        labelText: "Phone number",

                      ),
                      validator: (value){
                        if(value!.length!=10){
                          return "Enter correct phone number";
                        }
                        return null;
                      },

                    ),
                  ),

                  SizedBox(height: 40,),
                  Material(
                    color: Colors.indigo,
                    borderRadius: changeButton?BorderRadius.circular(40):BorderRadius.circular(10),
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: ()=>moveToHome()
                      ,

                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 700),
                        height: 50,
                        width: changeButton?50 :150,

                        alignment: Alignment.center,

                        child: changeButton?Icon(Icons.done,color:Colors.white):Text("Login",
                          style: TextStyle(

                            fontSize: 16,
                            color: Colors.white
                          ),

                        ),
                      ),
                    ),
                  )
                  /*ElevatedButton(
                      onPressed: (){

                        Navigator.pushNamed(context, Routes.home);
                  },
                      child: Text("Login"),

                      style:TextButton.styleFrom(primary: Colors.white,backgroundColor: Colors.red.shade400,
                        minimumSize: Size(100, 40),

                      ) ,
                  ),
*/



                ],
              ),
         )
        ),
    )
    );
  }
}
