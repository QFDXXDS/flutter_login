
import 'dart:io';
import 'package:dio/dio.dart';
import '../net/Api.dart';
import 'package:flutter_login/Modules/Login/ReqModel/ReqModel.dart';

class UserDao {

  static login(userName, password) async {
    LoginReq req = LoginReq(userName, password);
    Options option = Options(method: req.method());
    var res = await HttpManager.netFetch(req, option);

    return res ;
  }

}