import 'package:fire/Screens/Authenticate/authenticate.dart';
import 'package:fire/Screens/Home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fire/models/user.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user =Provider.of<User>(context);

    //return either home or authenticate widget depends upon user
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }


  }
}
