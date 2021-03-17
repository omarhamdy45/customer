import 'package:cust/providers/moviesprovider.dart';
import 'package:cust/providers/userprovider.dart';
import 'package:cust/screens/auth.dart';
import 'package:cust/screens/home.dart';

import 'package:cust/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

   //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context)=>Userprovider(),),
         ChangeNotifierProvider(create: (context)=>Movieprovider(),),

      ],

          child: MaterialApp(
             theme: ThemeData(
            primaryColor: Colors.black,
            accentColor: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
             
        
        
        home: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else {
                if (FirebaseAuth.instance.currentUser != null) {
                  return MyHomePage();
                } else {
                  return Authscreen();
                }
              }
            }),
            routes: {
            Authscreen.route:(context)=>Authscreen(),         
            MyHomePage.route:(context)=>MyHomePage(),
          },
          ),
    );
  }
}

