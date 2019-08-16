import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../Modules/Main/MainPage.dart';
import 'package:flutter_login/Common/Local/LocalStorage.dart';
import 'package:flutter_login/Common/Config/Config.dart';

import 'package:flutter_login/Common/dao/UserDao.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart';


class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return content();
  }
}

class content extends State<LoginPage> {
  var _userName = "";
  var _password = "";

  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();

  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();

  bool checkboxBool = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initParams();
  }

  initParams() async {

    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);

    controller.value = TextEditingValue(text: _userName ?? "");
    controller1.value = TextEditingValue(text: _password ?? "");

    var getCheckboxBool  = await LocalStorage.get(Config.REMEMBER_PW_KEY) ;
    if (getCheckboxBool != null && getCheckboxBool == true) {

      setState(() {
        checkboxBool = true ;

      });
    }


  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

//    FocusScope.of(context).requestFocus(_focusNode) ;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _toLogin() async {

    if (_userName == null || _userName.length == 0) {
      return;
    }
    if (_password == null || _password.length == 0) {
      return;
    }

    LocalStorage.save(Config.USER_NAME_KEY, _userName);
    if (checkboxBool) {
      LocalStorage.save(Config.PW_KEY, _password);
    } else {
      LocalStorage.remove(Config.PW_KEY);
    }

    var response = await UserDao.login(_userName, _password) ;

    var channel = IOWebSocketChannel.connect("") ;

    print(response);
    Navigator.pushReplacementNamed(context, MainPage.sName);
//    Navigator.push(context, MaterialPageRoute(builder: (context) {
//
//      return MainPage() ;
//    }
//    )) ;
  }

  _toAnonymity() {}
  _toCheckbox(bool selected) {
    setState(() {
      checkboxBool = !checkboxBool;

      LocalStorage.save(Config.REMEMBER_PW_KEY, checkboxBool) ;
    });
  }

  _tabBlank() {
    _focusNode.unfocus();
    _focusNode1.unfocus();
  }

  InputDecoration _InputDecoration() {
    InputDecoration decoration = InputDecoration(
//      icon: Image.asset("images/c3_1.png"),
//      prefix: Text("账号：",style: TextStyle(color: Colors.black,fontSize: 14),),
      prefixIcon: Padding(
        padding: EdgeInsets.only(top: 13),
        child: Text(
          "账号：",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      hintText: "用户名",
      hintStyle: TextStyle(fontSize: 12),
      border: InputBorder.none,
      filled: true,
    );
    return decoration;
  }

  InputDecoration _InputDecoration1() {
    InputDecoration decoration = InputDecoration(
//      icon: Image.asset("images/c3_1.png"),
      prefixIcon: Padding(
        padding: EdgeInsets.only(top: 13),
        child: Text(
          "密码：",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      hintText: "密码",
      hintStyle: TextStyle(fontSize: 12),
      border: InputBorder.none,
      filled: true,
    );
    return decoration;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        centerTitle: true,
      ),
      body: GestureDetector(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
              ),

              Image.asset('images/c11.png'),
              Padding(
                padding: EdgeInsets.all(10),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: controller,
                      focusNode: _focusNode,
                      decoration: _InputDecoration(),
                      autofocus: false,
                      onChanged: (value) {
                        _userName = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    TextField(
                      controller: controller1,
                      focusNode: _focusNode1,
                      decoration: _InputDecoration1(),
                      autofocus: false,
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: checkboxBool,
                          onChanged: _toCheckbox,
                          tristate: true,
                        ),
                        Text(
                          "记住密码",
                          style: TextStyle(color: checkboxBool ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              RaisedButton(
                onPressed: _toLogin,
                child: Text("登录"),
              ),
//              FlatButton(onPressed: _toAnonymity, child: Text("匿名登录")),
            ],
          ),
        ),
        behavior: HitTestBehavior.translucent,
        onTap: _tabBlank,
      ),
    );
  }
}
