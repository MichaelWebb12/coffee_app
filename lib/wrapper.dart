import 'package:babbage_backend/models/user.dart';
import 'package:babbage_backend/screens/authentication/authentication.dart';
import 'package:babbage_backend/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    //return either Home or Authenticate widget
    if (user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}