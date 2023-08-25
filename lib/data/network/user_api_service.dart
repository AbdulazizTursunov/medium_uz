import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:medium_uz/data/models/user_model/user_model.dart';
import '../../cubit/user_cubit/user_model_dio/user_model_dio.dart';
import '../../utils/constants/constants.dart';
import '../models/universal_data/universal_data.dart';

class UserApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://fifth-exam.free.mockoapp.net",

    headers: {"content-Type": "application/json"},
    connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
    receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
    sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
  ));

  UserApiService() {
    _initApSr();
  }

  _initApSr() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          //error.response.statusCode
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${requestOptions.path}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

  // List<dynamic> data = response.data;
  // List<UserModelDio> users = data.map((e) {
  //   return UserModelDio.fromJson(e);
  // }).toList();

    Future<UniversalData> getAllUser() async {
      Response response;
      try {
        response = await _dio.get('/users');
        if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
          print('ISHLADI ${response.data}');
          return UniversalData(
              data: (response.data as List?)
                  ?.map((e) => UserModelDio.fromJson(e))
                  .toList() ??
                  []);
        }
        return UniversalData(error: "Other Error");
      } on DioException catch (e) {
        if (e.response != null) {
          return UniversalData(error: e.response!.data["message"]);
        } else {
          return UniversalData(error: e.message!);
        }
      } catch (error) {
        return UniversalData(error: error.toString());
      }
    }
  }



