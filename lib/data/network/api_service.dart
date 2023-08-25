import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:medium_uz/data/models/user_model/user_model.dart';
import 'package:medium_uz/utils/constants/constants.dart';
import '../../cubit/article_cubit/article_model.dart';
import '../models/universal_data/universal_data.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {"content-Type": "application/json"},
    connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
    receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
    sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
  ));

  ApiService() {
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
          // return handler.resolve(Response(requestOptions: requestOptions, data: {"name": "ali", "age": 26}));
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

  ///===================  AUTHENTICATION  ====================///

  Future<UniversalData> confirmCodeApi({required String code}) async {
    Response response;
    try {
      response = await _dio.post("/password",
          data: {"checkPass": code},);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        debugPrint("================================================================== response ${response.data}");
        return UniversalData(data: response.data["message"]);
      }

      /// kelishi mumkin bo'lgan erorlarni handling qilish uchun
      // handleDioErrors(response);

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

  Future<UniversalData> sendCodeGmailUser(
      {required String email, required String password}) async {
    Response response;
    try {
      response = await _dio
          .post("/gmail", data: {"gmail": email, "password": password});
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UniversalData(data: response.data["message"]);
      }

      /// kelishi mumkin bo'lgan erorlarni handling qilish uchun
      // handleDioErrors(response);

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

  Future<UniversalData> registerUserMediumUz(
      {required UserModel userModel}) async {

    _dio.options.headers = {
      "Accept": "multipart/form-data",
    };
    try {
      print(userModel.getFormInfoUserData());
      Response   response =
          await _dio.post("/register",
              data: await userModel.getFormInfoUserData(),);
      print("_------------------------------------------${response.data}");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {

        return UniversalData(data: response.data["data"]);
      }

      /// kelishi mumkin bo'lgan erorlarni handling qilish uchun
      // handleDioErrors(response);

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

  Future<UniversalData> loginUserMediumUz(
      {required String email, required String password}) async {
    Response response;
    try {
      response = await _dio
          .post("/login", data: {"gmail": email, "password": password});
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UniversalData(data: response.data["data"]);
      }

      /// kelishi mumkin bo'lgan erorlarni handling qilish uchun
      // handleDioErrors(response);

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


  /// =============================== Article =============

  Future<UniversalData> getAllArticles() async {
    Response response;
    try {
      response = await _dio.get('/articles');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        print('ISHLADI ${response.data}');
        return UniversalData(
            data: (response.data["data"] as List?)
                ?.map((e) => ArticleModel.fromJson(e))
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

  /// =============================== PROFILE ============================///

  Future<UniversalData> getUserData() async {
    Response response;
    try {
      response = await _dio.get('/users');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        print('ISHLADI ${response.data}');
        return UniversalData(
            data:UserModel.fromJson(response.data["data"]));
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
