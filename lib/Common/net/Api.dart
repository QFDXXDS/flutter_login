

import 'package:dio/dio.dart';
import '../Config/Config.dart';
import 'ResultData.dart';
import 'Code.dart';
import 'dart:convert';

abstract class HttpReq {

    String method() {

      return "get" ;
    }

    String url() ;

    Map params() ;


}


class HttpManager {

  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  static netFetch(HttpReq req , Options option, {noTip = false}) async {


//    if (option == null) {

      option = Options(method: req.method()) ;
      option.connectTimeout = 15000 ;
//    } else {
//
//
//    }

      var data = json.encode(req.params()) ;
      var url = Config.HTTP_URL + req.url() ;
      Dio dio = Dio() ;
      Response response;
      try {
        response = await dio.request(url,data: data,options: option) ;
      } on DioError catch(e) {
        Response errorResponse;
        if(e.response != null) {

          errorResponse = e.response ;
        } else {
          errorResponse = Response(statusCode: 666) ;
        }
        if(Config.DEBUG) {

          print('请求异常: ' + e.toString());
          print('请求异常url: ' + req.url());

        }

        return ResultData(Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip), false, errorResponse.statusCode) ;
      }
      if (Config.DEBUG) {

        print("请求Url" + req.url()) ;
        print("请求头：" + option.headers.toString()) ;
        if (req.params() != null) {

          print("请求参数： " + req.params().toString()) ;
        }
        if(response != null) {
          print("返回参数：" + response.toString());
        }
      }
      try {

        if(option.contentType != null && option.contentType.primaryType == "text") {

          return ResultData(response.data, true, Code.SUCCESS) ;
        } else {

          var responseJson = response.data;
          if (response.statusCode == 200 || response.statusCode == 201 ) {

            return ResultData(response.data, true, Code.SUCCESS) ;
          }
        }

      } catch (e){

        print(e.toString() + req.url()) ;
        return ResultData(response.data, false, response.statusCode) ;
      }
      return ResultData(Code.errorHandleFunction(response.statusCode, "", noTip), false, response.statusCode) ;

  }


}