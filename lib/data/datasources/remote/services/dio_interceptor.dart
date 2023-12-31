import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../config/values/api_keys.dart';

import '../../../../core/utils/common.dart';
import '../../../../core/utils/api_data.dart';

class DioInterceptor extends Interceptor {
  DioInterceptor(this.apiData);
  final ApiData apiData;

  /// Adds [apiData.apiKey] to each request on logs request info.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String headerMessage = "";
    options.data[keyApi] = apiData.apiKey;
    options.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    try {
      options.queryParameters.forEach(
        (k, v) => debugPrint(
          '► $k: $v',
        ),
      );
    } catch (_) {}
    try {
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      log.d((options.data));
      final String prettyJson = encoder.convert(options.data);
      log.d(
        // ignore: unnecessary_null_comparison
        "REQUEST ► ︎ ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"${options.baseUrl}${options.path}"}\n\n"
        "Headers:\n"
        "$headerMessage\n"
        "❖ QueryParameters : ${options.queryParameters}\n"
        "Body: $prettyJson",
      );
    } catch (e) {
      log.e("Failed to extract json request $e");
      rethrow;
      // Crashlytics.nonFatalError(
      //   error: e,
      //   reason: "Failed to extract json request",
      // );
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    log.e(
      "<-- ${dioError.message} ${dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL'}\n\n"
      "${dioError.response != null ? dioError.response!.data : 'Unknown Error'}",
    );

    // Crashlytics.nonFatalError(
    //   error: dioError.error,
    //   stackTrace: dioError.stackTrace,
    //   reason: "Failed to fetch data",
    // );
    // super.onError(dioError, handler);
    // handler.next(dioError);
    throw dioError;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String headerMessage = "";
    response.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(response.data);
    log.d(
      // ignore: unnecessary_null_comparison
      "◀ ︎RESPONSE ${response.statusCode} ${response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL'}\n\n"
      "Headers:\n"
      "$headerMessage\n"
      "❖ Results : \n"
      "Response: $prettyJson",
    );
    super.onResponse(response, handler);
  }
}
