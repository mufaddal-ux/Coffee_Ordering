import 'package:fire/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:fire/Services/auth.dart';
class Register extends StatefulWidget {

  final Function toggleView;
  Register({
    this.toggleView
  });
  @override
  _RegisterState createState() => _RegisterState();

}

class _RegisterState extends State<Register> {
  @override

    final AuthService _auth=AuthService();
    final _formKey =GlobalKey<FormState>();
    String email=" ";
    String password=" ";
    String error="";
    bool loading=false;
  Widget build(BuildContext context) {
    return loading? Loading()  :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("REGISTER"),
        actions: [
          FlatButton.icon(icon: Icon(Icons.person),
            label: Text("Sign In"),
            onPressed: (){
              widget.toggleView();
            },)
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
        child:Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                  fillColor: Colors.brown[500],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red,width: 2.0)
                  ),
                    focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white,width: 2.0)
              )
                ),
                validator: (val)=>val.isEmpty?'Enter a Email':null ,
                  onChanged: (val){
                    setState(()
                    => email = val
                    );
                  }
              ),
              SizedBox(height: 20),
              TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      fillColor: Colors.brown[500],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red,width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 2.0)
                      )
                  ),
                  validator: (val)=>val.length< 6 ?'Enter a Password with more than 6 characters':null ,
                  onChanged: (val){
                    setState(()
                    => password=val
                    );
                  }
              ),
              SizedBox(height: 20),
              RaisedButton(onPressed: () async {
                if(_formKey.currentState.validate()){
                  setState(() {
                    loading=true;
                  });
                        dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                        if(result==null){
                              setState(() {
                                error = 'Please enter valid Email id';
                                loading=false;
                              });
                        }else{

                        }
                }

              },
                color: Colors.pinkAccent,
                child: Text("REGISTER",style: TextStyle(color: Colors.white,fontSize: 15,letterSpacing: 2,wordSpacing: 5)),
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),

              )
            ],
          ),
        ),
      ),
    );
  }
}
