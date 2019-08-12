import 'package:flutter/material.dart';
import '../../Modules/Login/LoginPage.dart';


class MinePage extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<MinePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("我的"),
        centerTitle: true,

      ),
      body: Center(
        child: RaisedButton(
        child: Text("退出"),
        onPressed: (){
          Navigator.pushReplacementNamed(context, LoginPage.sName);
        }),
      ),
    );  }


}