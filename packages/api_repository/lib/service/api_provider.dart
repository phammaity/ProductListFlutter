import 'dart:convert';

import 'package:api_repository/config.dart';
import 'package:api_repository/models/item.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

enum RequestMethod {
  get,
  post,
  put,
  delete,
}

extension RequestMethodValue on RequestMethod {
  String get name {
    switch (this) {
      case RequestMethod.get:
        return "GET";
      case RequestMethod.post:
        return "POST";
      case RequestMethod.put:
        return "PUT";
      case RequestMethod.delete:
        return "DELETE";
    }
  }
}

class ApiProvider {
  static ApiProvider? _instance;

  factory ApiProvider.instance() => _instance ??= new ApiProvider._internal();

  Dio? dioClient;
  static const int defaultTimeout = 30000;

  Future<void> _config() async {
    dioClient = Dio();
    (dioClient!.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (client) {
      return client;
    };
  }

  ApiProvider._internal() {
    _config();
  }

  Future<AllItems> fetchAllItems() async {
    final url = Config.storeUrl;
    final response = await _request(url: url);
    return AllItems.fromJson(response);
  }

  Future<AllItems> fetchLocalItems() async {
    String data = await rootBundle.loadString(Config.localPath);
    final jsonResult = json.decode(data);
    return AllItems.fromJson(jsonResult);
  }

  Future<dynamic> _request(
      {required String url,
      dynamic data,
      RequestMethod requestMethod = RequestMethod.get,
      String contentType = Headers.jsonContentType,
      timeout = defaultTimeout}) async {
    try {
      final response = await dioClient?.request(
        url,
        data: data,
        options: Options(
            method: requestMethod.name,
            contentType: contentType,
            receiveTimeout: timeout,
            sendTimeout: timeout),
      );
      return json.decode(response?.data ?? "");
    } on DioError catch (dioErr, stackTrade) {
      print(dioErr);
    } catch (e, s) {
      print(e);
    }
  }
}
