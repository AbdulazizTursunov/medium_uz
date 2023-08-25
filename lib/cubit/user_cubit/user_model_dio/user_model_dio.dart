import 'package:flutter/cupertino.dart';

class UserModelDio {
  final int id;
  String userName;
  String name;
  String state;
  String avatar_url;

  UserModelDio(
      {required this.state,
      required this.id,
      required this.name,
      required this.userName,
      required this.avatar_url});

  factory UserModelDio.fromJson(Map<String, dynamic> json) {
    debugPrint(" user dio ok");

    return UserModelDio(
        state: json['state'] as String? ?? "",
        id:json ['id'] as int? ?? 0,
        name:json ['name'] as String? ?? "",
        userName:json ['username'] as String? ?? "",
        avatar_url: json['avatar_url'] as String? ?? "");
  }



}
