import 'package:babbage_backend/services/auth.dart';
import 'package:babbage_backend/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:babbage_backend/shared/contants.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final AuthService _auth = AuthService();
final  _formKey= GlobalKey<FormState>();
bool loading=false;

//text field state
String email='';
String password='';
String error='';


  @override
  Widget build(BuildContext context) {
     return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
      backgroundColor: Colors.brown[400] ,
       elevation: 0.0,
       title: Text('Sign In To Babbage '),
       actions: <Widget>[
         FlatButton.icon(
           onPressed: (){
             widget.toggleView();
             },
           icon: Icon(Icons.person),
           label: Text('Register'),
           )
       ],
        ),
    body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal:50.0),
      child:Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height:20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText:'Email'),
              validator: (val)=>val.isEmpty ? 'Enter an email': null,
              onChanged: (val){
                 setState(() {
                   email=val;
                 });
              }
            ),
             SizedBox(height:20.0),
             TextFormField(
              decoration: textInputDecoration.copyWith(hintText:'Password'),
               validator: (val)=>val.length < 6 ? 'Password should not be less than 6 characters ': null,
               obscureText: true,
              onChanged: (val){
                  setState(() {
                   password=val;
                 }); 
              }
            ),
            SizedBox(height:20.0),
            RaisedButton(
              onPressed: () async{
                if(_formKey.currentState.validate()){
                  setState(() {
                    loading=true;
                  });
                  dynamic result= await _auth.signinWithEmailAndPassword(email, password);
                  
                      if(result == null){
                        setState(() {
                          error = 'could not sign in with those credentials';
                          loading=false;
                        });
                      }
                }
              },
              color: Colors.pink[400],
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  ),
              ),
              ),
               SizedBox(height:12.0),
             Text(
               error,
               style: TextStyle(
                 color: Colors.red,
                 fontSize:14.0,
                 )
                 )
             
          ],
        ),
      )
    ),
    );
  }
}