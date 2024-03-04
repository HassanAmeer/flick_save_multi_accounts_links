import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../datasource/remote/base/api_response.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../utils/app_constant.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> addUser(
    String name,
    String? email,
    String? phone,
    String? profession,
    String? organization,
    bool isActive,
  ) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      Map data = {
        'id': getUserID(),
        'name': name,
        'email': email,
        'phone': phone ?? '',
        'profession': profession,
        'organization': organization,
        'isActive': isActive,
      };
      debugPrint('data:${jsonEncode(data)}');
      response = await Dio().put(
        '${AppConstant.baseUrl}${AppConstant.user}',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getUserData() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      debugPrint('${AppConstant.baseUrl}${AppConstant.user}/${getUserID()}');
      response = await Dio().get(
        '${AppConstant.baseUrl}${AppConstant.user}/${getUserID()}',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> userActive(bool isActive) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      debugPrint(
          '${AppConstant.baseUrl}${AppConstant.userActive}${getUserID()}');
      Map data = {
        "isActive": isActive,
      };
      response = await Dio().put(
        data: data,
        '${AppConstant.baseUrl}${AppConstant.userActive}${getUserID()}',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> userInfoUpdate(String? name, String? email, String? phone,
      String? profession, String? organization) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    debugPrint('!!! name is${name!.isNotEmpty}');
    try {
      debugPrint(
          '${AppConstant.baseUrl}${AppConstant.userActive}${getUserID()}');
      Map data = {
        if (name.isNotEmpty) "name": name,
        if (email!.isNotEmpty) "email": email,
        if (phone!.isNotEmpty) "phone": phone,
        if (profession!.isNotEmpty) "profession": profession,
        if (organization!.isNotEmpty) "organization": organization
      };
      debugPrint(jsonEncode(data));
      response = await Dio().put(
        data: data,
        '${AppConstant.baseUrl}${AppConstant.userActive}${getUserID()}',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<void> saveUserID(String userID) async {
    try {
      await sharedPreferences.setString(AppConstant.userID, userID);
    } catch (e, strackTrace) {
      debugPrint('$strackTrace');
    }
  }

  String getUserID() {
    return sharedPreferences.getString(AppConstant.userID) ?? '';
  }

  Future<bool> clearUserID() async {
    return sharedPreferences.remove(AppConstant.userID);
  }

  bool isExistsCustomerID() {
    return sharedPreferences.containsKey(AppConstant.userID);
  }
}
