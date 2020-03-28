import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'share.dart';

class NetUtils {

  var dio = new Dio(new BaseOptions(
    //连接服务器超时时间，单位是毫秒.
    connectTimeout: 10000,
    //响应流上前后两次接受到数据的间隔，单位为毫秒。
    receiveTimeout: 5000,
    //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
    responseType: ResponseType.json,
  ));

  NetUtils(){
    dio.interceptors.add(new LogsInterceptors());
    dio.interceptors.add(new ResponseInterceptors());
    dio.interceptors.add(new SetTokenInterceptors());
  }

  Future get(String url, [Map<String, dynamic> params]) async {
    var response;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  Future post(String url, Map<String, dynamic> params) async {
    var response = await dio.post(url, data: params);
    return response.data;
  }
}

class LogsInterceptors extends InterceptorsWrapper {

  @override
  onRequest(RequestOptions options){
    if(true){
      debugPrint('请求url: ${options.path}');
      debugPrint('请求头: ' + options.headers.toString());
      if(options.data != null){
        debugPrint('请求参数: ' + options.data.toString());
      }
    }
    return options;
  }

  @override
  onResponse(Response response){
    if(true){
      if(response != null){
        debugPrint('返回参数: ' + response.toString());
      }
    }
    return response;
  }

  @override
  onError(DioError err){
    if(true){
      debugPrint('请求异常: ' + err.toString());
      debugPrint('请求异常信息: ' + err.response?.toString()?? '');
    }
    return err;
  }
}

Future<bool> getToken() async {
  try {
    await Share.remove('token');
    int userId = await Share.getIntValue('userId');
    var response = await netUtils.get(Api.BASE_URL + Api.GETTOKEN, { 'userId': userId });
    await Share.setStringValue('token', response['data']['token']);
    return true;
  } on DioError catch (e) {
    return false;
  }
}

class ResponseInterceptors extends InterceptorsWrapper{

  @override
  onResponse(Response response) async{
    int count = 0;
    Dio dio = netUtils.dio;
    var res = response.data;
    int userId = await Share.getIntValue('userId');
    var result;
    if(res is Map){
      result = res;
    } else {
      result = json.decode(res);
    }
    if(res['code'] == 10006 || (res['code'] == 10002 && userId != null)){
      if(await getToken() && count < 10){
        var request = response.request;
        try {
          var response = await dio.request(request.path,
              data: request.data,
              queryParameters: request.queryParameters,
              cancelToken: request.cancelToken,
              options: request,
              onReceiveProgress: request.onReceiveProgress);
          return response;
        } on DioError catch (e) {
          return e;
        }
      }
    }
    return result;
  }
}

class SetTokenInterceptors extends InterceptorsWrapper{

  @override
  onRequest(RequestOptions options) async {
    String token = await Share.getStringValue('token');
    if(token != null){
      options.headers['token'] = token;
    }
    return options;
  }
}

final NetUtils netUtils = new NetUtils();
