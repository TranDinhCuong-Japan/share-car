import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_stuff/models/user.dart';
import 'package:share_stuff/screens/authenticate/authenticate.dart';
import 'package:share_stuff/screens/home/home.dart';



class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    // return either Home or Authenticate widget
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}