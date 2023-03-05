import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:untitled9/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.debug,
  );

  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  String home = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Random title"),),
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10)
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.black))
              
            ),
            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
            onChanged: (val){
              setState(() {
                this.home = val ;
              });
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          ElevatedButton(onPressed: ()async{
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: "+91" + this.home,
                verificationCompleted:(jj){
              return null;
            }, verificationFailed: (v){
              print(v.toString() + "FAILED FAILDE ");
            }, codeSent: (j , t ){
              showDialog(context: context, builder: (context){
                print("SEUCCESS");
                return AlertDialog(
                  content: Text("HELLO"),
                );
              });
            }, codeAutoRetrievalTimeout: (fefe){

            });
          }, child: Text("Submit"))
        ],
      ),
    );
  }
}
