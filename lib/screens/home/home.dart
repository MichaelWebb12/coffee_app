import 'package:babbage_backend/screens/home/setting_form.dart';
import 'package:babbage_backend/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:babbage_backend/services/database.dart';
import 'package:provider/provider.dart';
import 'package:babbage_backend/screens/home/brewList.dart';
import 'package:babbage_backend/models/brew.dart';
class Home extends StatelessWidget {

  final AuthService _auth=AuthService();

  @override
  Widget build(BuildContext context) {

   void _showSettingsPanel(){
     showModalBottomSheet(context: context, builder: (context){
       return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal:60.0),
          child: SettingForm(),
       );
     });
   }

    return StreamProvider<List<Brew>>.value(
          value: DatabaseService().babbage,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('babbage backend'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async{
                await _auth.signOuT();
              },
               icon: Icon(Icons.person),
                label: Text('LogOut'),
                ),
                FlatButton.icon(
                  onPressed: ()=>_showSettingsPanel(), 
                  icon: Icon(Icons.settings),
                   label: Text('settings'))
          ],

        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'), 
              fit: BoxFit.cover,
              )
          ),
          child: BrewList()),
      ),
    );
  }
}