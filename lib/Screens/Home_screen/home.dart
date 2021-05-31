import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/Screens/Home_screen/setting_form.dart';
import 'package:fire/Services/auth.dart';
import 'package:fire/Services/database.dart';
import 'package:fire/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fire/Screens/Home_screen/brew_list.dart';
class Home extends StatelessWidget {
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context,builder: (context)
      {
    return Container(
  padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
  child: SettingsForm(),
);
            });
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text("STAR BUCKS"),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon:Icon(Icons.settings),
                label: Text("Coffee"),
                onPressed: ()=>_showSettingsPanel(),),
              FlatButton.icon(onPressed: ()
              async {
                await _auth.signOut();
              }, icon: Icon(Icons.person), label: Text("LogOut")),

            ],
          ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/coffeeBeans.jpeg"),
              fit: BoxFit.cover
            )
          ),
            child: BrewList()
        ),
      ),
    );
  }


}
