
import 'package:ajuba_customer/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pinput/pin_put/pin_put.dart';
import 'package:pinput/pin_put/pin_put_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences prefs ;


  String name="",otp="",phone="",verification="";
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.indigoAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }


  bool changeButton=false;
  bool logging=false;
  FirebaseAuth auth = FirebaseAuth.instance;



  final _formKey = GlobalKey<FormState>();

  moveToHome() async{

    prefs.setString("phone", phone);
    prefs.setString("name", name);
    prefs.setBool("logged", true);
    setState(() {
      changeButton = true;
    });
    await Future.delayed(
      Duration(milliseconds: 1000),
    );

    Navigator.popAndPushNamed(context, Routes.home);




  }

  Future<void> initiatePref() async{
     prefs = await SharedPreferences.getInstance();
  }
  verify() async {
    if(verification.isNotEmpty) {

      try{
        await auth.signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verification, smsCode: otp)).then((value) async{
              if(value.user!=null){
                print(value.user);
                moveToHome();
              }
        });


      }
      catch(e){
        print(e);

      }

    }

  }
  sendOtp() async{

    if(_formKey.currentState!.validate()) {
      if(!logging){
        logging=true;
      }
      print("sendOtp clicked");
      print(phone);
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91" + phone,
          verificationCompleted: (phoneAuthCredential) async {
            await auth
                .signInWithCredential(phoneAuthCredential)
                .then((value) async {
              if (value.user != null) {
                print("SUCCESS");
                moveToHome();
              }
            });
          },
          verificationFailed: (FirebaseAuthException error) {
            if (error.code == 'invalid-phone-number') {
              print("error on verificationFailed");
              print(error);
            }
          },
          codeSent: (verificationId, forceResendingToken) async {
            setState(() {
              verification = verificationId;
              print("Verification set");
              print(verificationId);
            });
          },
          codeAutoRetrievalTimeout: (verificationId) {
            setState(() {
              verification = verificationId;
              print("Verification set");
              print(verificationId);
            });
          },
          timeout: Duration(seconds: 60));

      moveToHome();
    }



  }


  @override
  Widget build(BuildContext context) {
    initiatePref().whenComplete(() {
      if(prefs.getBool("logged")!=null)
        if(prefs.getBool("logged")!){
          moveToHome();
        }
    });
    double height=MediaQuery.of(context).size.height;



    return Material(
      child:SingleChildScrollView(
          child: Center(
            child: Form(
              key:_formKey,
              child: Column(

                children: [


                  SizedBox(
                    height: height/5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0,0,0,0),
                    child: Image.asset("assets/images/app_icon.png",
                      scale:1.3,


                    ),
                  ),
                  SizedBox(
                    height: height/16,
                  ),


                  logging?Container(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50.0),
                        child: PinPut(
                          onChanged: (value)=>otp=value,
                          fieldsCount: 6,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,


                          focusNode: _pinPutFocusNode,
                          controller: _pinPutController,
                          submittedFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          selectedFieldDecoration: _pinPutDecoration,
                          followingFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.indigo.withOpacity(.5),
                            ),
                          ),
                          pinAnimationType: PinAnimationType.fade,
                          autofocus: true,
                          checkClipboard: true,
                          enabled: true,
                          onSubmit: (String go)=>verify(),


                        )
                    ),
                  )

                      :Column(
                    children: [
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
                          onChanged: (value)=>phone=value,
                          validator: (value){
                            if(value!.length!=10){
                              return "Enter correct phone number";
                            }
                            return null;
                          },

                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height/16,),
                  Material(
                    color: Colors.indigo,
                    borderRadius: changeButton?BorderRadius.circular(40):BorderRadius.circular(10),
                    child: InkWell(
                      splashColor: Colors.white70,
                      onTap: (){
                        print("Button Tapped");
                        print("logging: $logging");
                        logging?verify():sendOtp();
                        setState(() {

                        });
                      }
                      ,

                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 700),
                        height: 50,
                        width: changeButton?50 :150,

                        alignment: Alignment.center,

                        child: changeButton?Icon(Icons.done,color:Colors.white):Text(logging?"Verify OTP":"Login",
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

            ),
          )
      ),

    );


  }
  @override
  void initState() {
    super.initState();
    initiatePref().whenComplete(() =>setState((){

    }) );


  }

}