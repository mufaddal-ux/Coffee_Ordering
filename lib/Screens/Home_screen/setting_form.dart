import 'package:fire/Services/database.dart';
import 'package:fire/models/user.dart';
import 'package:fire/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:fire/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey=GlobalKey<FormState>();
  final List<String> sugars= ['0','1','2','3','4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;


  @override
  Widget build(BuildContext context) {

    final user=Provider.of<User>(context);

      return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            UserData userData=snapshot.data;
            return ListView(
                children: [Form(
                  key: _formKey,
                  child: Column(

                    children:<Widget> [
                      Text("Update your Coffee",
                        style: TextStyle(fontSize: 18.0),

                      ),
                      SizedBox(height:20.0),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration,
                        validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      SizedBox(height: 10.0),
                      //dropdown
                      DropdownButtonFormField(

                        value: _currentSugars ?? userData.sugars,
                        decoration: textInputDecoration,
                        items: sugars.map((sugar){
                          return DropdownMenuItem(
                              child:Text("$sugar sugars"),
                              value: sugar);
                        }).toList(),
                        onChanged: (val) => setState(() => _currentSugars = val ),
                      ),
                      //slider
                      SizedBox(height: 10.0),
                      Slider(
                        min: 100.0,
                        max: 900.0,
                        activeColor: Colors.brown[_currentStrength ?? userData.strength],
                        inactiveColor: Colors.grey[_currentStrength ?? userData.strength],
                        divisions: 8,
                        value: (_currentStrength ?? userData.strength).toDouble(),
                        onChanged: (val) => setState(()=> _currentStrength=val.round()),
                      ),
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugars ?? userData.sugars,
                                _currentName ?? userData.name,
                                _currentStrength ?? userData.strength
                              );
                              Navigator.pop(context);
                            }
                          }),
                    ],
                  ),
                ),
                ]
            );
          }else{
            return Loading();
          }

        }
      );

  }
}




