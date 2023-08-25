import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../models/universal_data/universal_data.dart';

UniversalData handleDioErrors(Response response) {
  switch (response.statusCode) {
    case HttpStatus.badRequest:
      {
        return UniversalData(
          error: "Bad request exception",
          statusCode: response.data.statusCode,
        );
      }
    case HttpStatus.unauthorized:
      {
        return UniversalData(
          error: jsonDecode(response.data)["message"],
          statusCode: response.data.statusCode,
        );
      }
    case HttpStatus.forbidden:
      {
        return UniversalData(
          error: jsonDecode(response.data)["message"],
          statusCode:response.data.statusCode,
        );
      }
    case HttpStatus.notFound:
      {
        return UniversalData(
          error: jsonDecode(response.data)["message"],
          statusCode:response.data.statusCode,
        );
      }
    case HttpStatus.tooManyRequests:
      {
        return UniversalData(
          error: jsonDecode(response.data)["message"],
          statusCode:response.data.statusCode,
        );
      }
    case HttpStatus.internalServerError:
      {
        return UniversalData(
          error:
          "Error occurred while Communication with Server with StatusCode : ${response.statusCode}",
          statusCode: response.data.statusCode,
        );
      }
    case HttpStatus.notImplemented:
      {
        return UniversalData(
          error: "Server Error : ${response.statusCode}",
          statusCode: response.data.statusCode,
        );
      }
    default:
      return UniversalData(
        error: "Unknown Error occurred!",
        statusCode: response.data.statusCode,
      );
  }
}
