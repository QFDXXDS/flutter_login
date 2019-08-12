
import 'package:flutter_login/Common/net/Api.dart';


class LoginReq extends HttpReq {

  String  loginId ;
  String password ;

  LoginReq(this.loginId,this.password) ;

  @override
  String method() {
    // TODO: implement method
    return "post" ;
  }

  @override
  Map params() {
    // TODO: implement params
    Map data = {
      "loginId": loginId,
      "password": password,
    };

    return data;
  }

  @override
  String url() {
    // TODO: implement url
    return "/rest/login";
  }
}