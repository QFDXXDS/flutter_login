
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<ContactPage> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: Text("联系人"),
        centerTitle: true,

      ),
    );

  }


}