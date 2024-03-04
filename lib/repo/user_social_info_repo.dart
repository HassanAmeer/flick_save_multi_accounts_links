import 'dart:convert';

import 'package:flick/provider/auth.dart';
import 'package:flick/repo/auth_repo.dart';
import 'package:flutter/material.dart';

import '../datasource/remote/base/api_response.dart';
import '../datasource/remote/dio/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../datasource/remote/exception/api_error_handler.dart';
import '../utils/app_constant.dart';
import 'package:provider/provider.dart';

class UserSocialInfoRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  UserSocialInfoRepo(
      {required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> addSocialMedia(
      String socialMediaName,
      String? socialMediaType,
      String? socialMediaLink,
      String? category,
      bool isActive,
      BuildContext context) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      Map data = {
        "socialMediaName": socialMediaName,
        "socialMediaType": socialMediaType,
        "socialMediaLink": socialMediaLink,
        "category": category,
        'isActive': isActive
      };

      debugPrint('api data:${jsonEncode(data)}');
      debugPrint(
          'Api link: ${AppConstant.baseUrl}${AppConstant.socialMedia}${Provider.of<AuthProviders>(context, listen: false).getUserId()}');

      response = await Dio().put(
        '${AppConstant.baseUrl}${AppConstant.socialMedia}${Provider.of<AuthProviders>(context, listen: false).getUserId()}',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      return ApiResponse.withError(
          ApiErrorHandler.getMessage(stackTrace), response);
    }
  }

  Future<ApiResponse> updateSocialMedia(
      String? socialMediaName,
      String socialId,
      String? socialMediaType,
      String? socialMediaLink,
      String? category,
      bool? isActive,
      BuildContext context) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      Map data = {
        "socialMediaName": socialMediaName,
        "socialMediaType": socialMediaType,
        if (socialMediaLink != null || socialMediaLink!.isNotEmpty)
          "socialMediaLink": socialMediaLink,
        if (category != null || category!.isNotEmpty) "category": category,
        if (isActive != null) 'isActive': isActive,
      };
      debugPrint('api data:${jsonEncode(data)}');
      debugPrint(
          'Api link: ${AppConstant.baseUrl}${AppConstant.socialMediaUpdate}${Provider.of<AuthProviders>(context, listen: false).getUserId()}');

      response = await Dio().put(
        '${AppConstant.baseUrl}${AppConstant.socialMediaUpdate}${Provider.of<AuthProviders>(context, listen: false).getUserId()}/${socialId}',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      return ApiResponse.withError(
          ApiErrorHandler.getMessage(stackTrace), response);
    }
  }

  Future<ApiResponse> socialMediaIsActive(
      String socialId, bool isActive, BuildContext context) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      Map data = {
        'isActive': isActive,
      };
      debugPrint('api data:${jsonEncode(data)}');
      debugPrint(
          'Api link: ${AppConstant.baseUrl}${AppConstant.socialMediaUpdate}${Provider.of<AuthProviders>(context, listen: false).getUserId()}');

      response = await Dio().put(
        '${AppConstant.baseUrl}${AppConstant.socialMediaUpdate}${Provider.of<AuthProviders>(context, listen: false).getUserId()}/${socialId}',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      return ApiResponse.withError(
          ApiErrorHandler.getMessage(stackTrace), response);
    }
  }

  Future<ApiResponse> deleteSocialMedia(
      String socialId, BuildContext context) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      debugPrint(
          'Api link: ${AppConstant.baseUrl}${AppConstant.socialMediaUpdate}${Provider.of<AuthProviders>(context, listen: false).getUserId()}');

      response = await Dio().delete(
        '${AppConstant.baseUrl}${AppConstant.deleteSocialMedia}${Provider.of<AuthProviders>(context, listen: false).getUserId()}/${socialId}',
      );
      return ApiResponse.withSuccess(response);
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      return ApiResponse.withError(
          ApiErrorHandler.getMessage(stackTrace), response);
    }
  }
}
