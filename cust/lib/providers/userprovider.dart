import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Userprovider with ChangeNotifier{
  
  Future<String> login(String email,String password)async{
    try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        return null;
    }
        catch(error ){
          return 'error';

        }
  }
  Future<String> register(String email,String password)async{
    try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
         return null;
    }
        catch(error ){
          return 'error';

        }
  }
}