import 'package:flutter_project_with_firebase/screens/authenticate/authenticate.dart';
import 'package:flutter_project_with_firebase/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project_with_firebase/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    //print(user);

    // return either the Home or Authenticate widget
    if(user == null)
      return Authenticate();
    else
      return Home();

  }
}
