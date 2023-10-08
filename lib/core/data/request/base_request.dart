import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:users/core/app_flavor.dart';

import '../models/request_model.dart';

var _header = <String, String>{};
var _token = <String, String>{};
var _baseUrl = AppFlavor.baseUrl;
var _fcmToken = '';

class BaseRequestDefaults {
  BaseRequestDefaults._();

  static final _instance = BaseRequestDefaults._();

  static BaseRequestDefaults get instance => _instance;

  // void setHeader(Map<String, String> header) => _header = header;
  void addHeader(String key, String value) => _header.addAll({key: value});

  void addHeaders(Map<String, dynamic> map) => map.forEach((key, value) => _header.addAll({key: value}));

  void updateHeader(String key, String value) => _header.update(key, (v) => value);

  void removeHeader(String key) => _header.remove(key);

  void setLanguage(String language) => _header.addAll({'Accept-Language': language});

  void setToken(String token) => _token = {'Authorization': 'Bearer $token'};

  void removeToken() => _token = {};

  void setBaseUrl(String baseUrl) => _baseUrl = baseUrl;

  void setFcmToken(String fcmToken) => _fcmToken = fcmToken;

  String get fcmToken => _fcmToken;

  bool hasToken() => _token.isNotEmpty;
}

abstract class BaseRequest {
  BaseRequest(
    this.path,
    this.method,
    this.queryParameters,
    this.requestModel,
    this.data,
  );

  final RequestModel requestModel;
  final String path;
  final String method;
  final Map<String, dynamic>? queryParameters;
  final Future<dynamic> data;
}

mixin Request implements BaseRequest {
  String get baseUrl => _baseUrl;

  String get fcmToken => _fcmToken;

  String get url => baseUrl + path;

  CancelToken get cancelToken => requestModel.cancelToken;

  bool get includeAuthorization => true;

  bool get multiPart => false;

  Map<String, String>? get headers {
    final headers = <String, String>{};
    headers.addAll(_header);
    if (_token.isNotEmpty && includeAuthorization) {
      headers.addAll(_token);
    }

    return headers;
  }
}

mixin GetRequest on Request {
  @override
  RequestModel get requestModel => EmptyRequestModel();

  @override
  Map<String, dynamic>? get queryParameters {
    final map = requestModel.toJson();
    return map.isEmpty ? null : requestModel.toJson();
  }

  @override
  Future<dynamic> get data async => null;

  @override
  String get method => 'GET';
}

mixin PostRequest on Request {
  @override
  Map<String, dynamic>? get queryParameters => null;

  @override
  Future<dynamic> get data async {
    final map = requestModel.toJson();
    if (map.isEmpty) return null;
    return multiPart ? FormData.fromMap(map) : map;
  }

  @override
  String get method => 'POST';
}

mixin PutRequest on Request {
  @override
  Map<String, dynamic>? get queryParameters => null;

  @override
  Future<dynamic> get data async {
    final map = requestModel.toJson();
    if (map.isEmpty) return null;
    return multiPart ? FormData.fromMap(map) : map;
  }

  @override
  String get method => 'PUT';
}

mixin DeleteRequest on Request {
  @override
  RequestModel get requestModel => EmptyRequestModel();

  @override
  Map<String, dynamic>? get queryParameters {
    final map = requestModel.toJson();
    return map.isEmpty ? null : requestModel.toJson();
  }

  @override
  Future<dynamic> get data async => null;

  @override
  String get method => 'DELETE';
}
