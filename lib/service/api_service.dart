import 'dart:async';
import 'dart:convert';
import 'dart:io';



import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../core/dependency/get_it_injection.dart';
import '../core/network/connection_checker.dart';
import '../helper/local_db/local_db.dart';
import '../model/basic/error_response_model.dart';
import '../utils/logger/logger.dart';

final log = logger(ApiClient);

typedef ServerResponse<T> = Future<Either<ErrorResponseModel, T>>;

Map<String, String> basicHeaderInfo() {
  return {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
  };
}

Future<Map<String, String>> bearerHeaderInfo() async {
  final DBHelper dbHelper = serviceLocator();
  final token = await dbHelper.getToken();
  final id = await dbHelper.getUserId();

  log.i('|📍📍📍|----------------- [[ TOKEN ]] $token -----------------|📍📍📍|');
  log.i('|📍📍📍|----------------- [[ USER ID ]] $id -----------------|📍📍📍|');

  return {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: "Bearer $token",
  };
}

Future<Map<String, String>> bearerHeaderInfoForDelete() async {
  DBHelper dbHelper = DBHelper();
  final token = await dbHelper.getToken();

  log.i('|📍📍📍|----------------- [[ DELETE TOKEN ]] $token -----------------|📍📍📍|');

  return {
    HttpHeaders.authorizationHeader: token,
  };
}

String noInternetConnection = "no_internet_connection".tr;

final ConnectionChecker connectionChecker = serviceLocator();

class ApiClient {
  //=========================== Get method ======================

  Future<Response> get(
      {required String url,
        bool isBasic = false,
        int duration = 30,
      }) async {
    /// ======================- Check Internet ===================

    if (!await connectionChecker.isConnected) {
      log.i('|📍📍📍|----------------- [[ GET ]] method GET Internet Issue, URL $url -----------------|📍📍📍|');
      return Response(statusCode: 503, body: {"status": false, "message": noInternetConnection}, statusText: noInternetConnection);
    }
    log.i('|📍📍📍|----------------- [[ GET ]] method details start -----------------|📍📍📍|');
    log.i(url);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
      ).timeout(Duration(seconds: duration));

      log.d("Body => ${response.body}");
      log.d("Status Code => ${response.statusCode}");

      log.i('|📒📒📒|-----------------[[ GET ]] method response end -----------------|📒📒📒|');

      var body = jsonDecode(response.body);

      return Response(
        body: body ?? response.body,
        bodyString: response.body.toString(),
        request: Request(
            headers: response.request!.headers,
            method: response.request!.method,
            url: response.request!.url),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    } on SocketException {

      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert on Socket Exception');
    } on TimeoutException {

      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');
      log.e('Time out exception$url');

      return const Response(body: {
        "message": "Time out exception"
      }, statusCode: 400, statusText: '');
    } on http.ClientException {

      log.e('🐞🐞🐞 Error Alert Client Exception 🐞🐞🐞');
      log.e('client exception hitted');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert Client Exception');
    } catch (e) {

      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');
      log.e('❌❌❌ unlisted error received');
      log.e("❌❌❌ $e");

      return const Response(body: {
        "message": "Something went wrong"
      }, statusCode: 400, statusText: "Something went wrong");
    }
  }

  //========================== Post Method =======================
  Future<Response> post(
      {required String url,
        bool isBasic = false,
        required Map<String, dynamic> body,
        int duration = 30,
      }) async {
    try {

      /// ======================- Check Internet ===================

      if (!await connectionChecker.isConnected) {
        log.i('|📍📍📍|----------------- [[ GET ]] method GET Internet Issue, URL $url -----------------|📍📍📍|');
        return Response(statusCode: 503, body: {"status": false, "message": noInternetConnection}, statusText: noInternetConnection);
      }
      log.i('|📍📍📍|----------------- [[ GET ]] method details start -----------------|📍📍📍|');
      log.i(url);
      log.i(body);


      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
      ).timeout(Duration(seconds: duration));


      log.d("Body => ${response.body}");
      log.d("Status Code => ${response.statusCode}");

      log.i('|📒📒📒|-----------------[[ GET ]] method response end -----------------|📒📒📒|');

      body = jsonDecode(response.body);

      return Response(
        body: body,
        bodyString: response.body.toString(),
        request: Request(
            headers: response.request!.headers,
            method: response.request!.method,
            url: response.request!.url),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    } on SocketException {

      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert on Socket Exception');
    } on TimeoutException {

      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');
      log.e('Time out exception$url');

      return const Response(body: {
        "message": "Time out exception"
      }, statusCode: 400, statusText: '');
    } on http.ClientException {

      log.e('🐞🐞🐞 Error Alert Client Exception 🐞🐞🐞');
      log.e('client exception hitted');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert Client Exception');
    } catch (e) {

      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');
      log.e('❌❌❌ unlisted error received');
      log.e("❌❌❌ $e");

      return const Response(body: {
        "message": "Something went wrong"
      }, statusCode: 400, statusText: "Something went wrong");
    }
  }

  Future<Response> patch(
      {required String url,
        bool isBasic = false,
        required Map<String, dynamic> body,
        int duration = 30,
      }) async {
    try {

      /// ======================- Check Internet ===================

      if (!await connectionChecker.isConnected) {
        log.i('|📍📍📍|----------------- [[ GET ]] method GET Internet Issue, URL $url -----------------|📍📍📍|');
        return Response(statusCode: 503, body: {"status": false, "message": noInternetConnection}, statusText: noInternetConnection);
      }
      log.i('|📍📍📍|----------------- [[ GET ]] method details start -----------------|📍📍📍|');
      log.i(url);

      final response = await http.patch(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
      ).timeout(Duration(seconds: duration));


      log.d("Body => ${response.body}");
      log.d("Status Code => ${response.statusCode}");

      log.i('|📒📒📒|-----------------[[ GET ]] method response end -----------------|📒📒📒|');

      body = jsonDecode(response.body);

      return Response(
        body: body,
        bodyString: response.body.toString(),
        request: Request(
            headers: response.request!.headers,
            method: response.request!.method,
            url: response.request!.url),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    }  on SocketException {

      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert on Socket Exception');
    } on TimeoutException {

      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');
      log.e('Time out exception$url');

      return const Response(body: {
        "message": "Time out exception"
      }, statusCode: 400, statusText: '');
    } on http.ClientException {

      log.e('🐞🐞🐞 Error Alert Client Exception 🐞🐞🐞');
      log.e('client exception hitted');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert Client Exception');
    } catch (e) {

      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');
      log.e('❌❌❌ unlisted error received');
      log.e("❌❌❌ $e");

      return const Response(body: {
        "message": "Something went wrong"
      }, statusCode: 400, statusText: "Something went wrong");
    }
  }

  /// ========================= MultiPart Request =====================
  Future<Response> multipartRequest(
      {required String url,
        required String reqType,
        bool isBasic = false,
        required Map<String, String> body,
        required List<MultipartBody> multipartBody,
      }) async {
    try {

      /// ======================- Check Internet ===================

      if (!await connectionChecker.isConnected) {
        log.i('|📍📍📍|----------------- [[ GET ]] method GET Internet Issue, URL $url -----------------|📍📍📍|');
        return Response(statusCode: 503, body: {"status": false, "message": noInternetConnection}, statusText: noInternetConnection);
      }
      log.i('|📍📍📍|----------------- [[ GET ]] method details start -----------------|📍📍📍|');
      log.i(url);

      final request = http.MultipartRequest(
        reqType,
        Uri.parse(url),
      )..fields.addAll(body)..headers.addAll(isBasic ? basicHeaderInfo() : await bearerHeaderInfo());

      if (multipartBody.isNotEmpty) {
        multipartBody.forEach((element) async {
          if (element.file.path.isEmpty) {
            return;
          }
          debugPrint("path : ${element.file.path}");

          var mimeType = lookupMimeType(element.file.path);

          debugPrint("MimeType================$mimeType");

          var multipartImg = await http.MultipartFile.fromPath(
            element.key,
            element.file.path,
            contentType: MediaType.parse(mimeType!),
          );
          request.files.add(multipartImg);
        });
      }

      var response = await request.send().timeout(const Duration(seconds: 120));
      var jsonData = await http.Response.fromStream(response);

      log.d("Body => ${jsonData.body}");
      log.d("Status Code => ${response.statusCode}");

      log.i('|📒📒📒|-----------------[[ GET ]] method response end -----------------|📒📒📒|');
      var decodeBody = jsonDecode(jsonData.body);

      return Response(
        body: decodeBody,
        statusCode: response.statusCode,
      );
    }  on SocketException {

      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert on Socket Exception');
    } on TimeoutException {

      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');
      log.e('Time out exception$url');

      return const Response(body: {
        "message": "Time out exception"
      }, statusCode: 400, statusText: '');
    } on http.ClientException {

      log.e('🐞🐞🐞 Error Alert Client Exception 🐞🐞🐞');
      log.e('client exception hitted');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert Client Exception');
    } catch (e) {

      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');
      log.e('❌❌❌ unlisted error received');
      log.e("❌❌❌ $e");

      return const Response(body: {
        "message": "Something went wrong"
      }, statusCode: 400, statusText: "Something went wrong");
    }
  }

  Future<Response> delete(
      {required String url,
        bool isBasicHeader = false,
        int code = 200,
        required Map<String, String> body,
        int duration = 30,
      }) async {

    /// ======================- Check Internet ===================

    if (!await connectionChecker.isConnected) {
      log.i('|📍📍📍|----------------- [[ GET ]] method GET Internet Issue, URL $url -----------------|📍📍📍|');
      return Response(statusCode: 503, body: {"status": false, "message": noInternetConnection}, statusText: noInternetConnection);
    }
    log.i('|📍📍📍|----------------- [[ GET ]] method details start -----------------|📍📍📍|');
    log.i(url);
    log.i(body);

    try {

      final response = await http.delete(Uri.parse(url),
        headers: await bearerHeaderInfoForDelete(),
        body: body,
      ).timeout(Duration(seconds: duration));


      log.d("Body => ${response.body}");
      log.d("Status Code => ${response.statusCode}");

      log.i('|📒📒📒|-----------------[[ GET ]] method response end -----------------|📒📒📒|');

      if (response.statusCode == code) {
        final decodeBody = jsonDecode(response.body);
        return Response(
          body: decodeBody,
          statusCode: response.statusCode,
        );
      } else {

        log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');
        log.e('unknown error hitted in status code  ${jsonDecode(response.body)}');

        return Response(
          body: jsonDecode(response.body),
          statusCode: response.statusCode,
        );
      }
    }  on SocketException {

      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert on Socket Exception');
    } on TimeoutException {

      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');
      log.e('Time out exception$url');

      return const Response(body: {
        "message": "Time out exception"
      }, statusCode: 400, statusText: '');
    } on http.ClientException {

      log.e('🐞🐞🐞 Error Alert Client Exception 🐞🐞🐞');
      log.e('client exception hitted');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert Client Exception');
    } catch (e) {

      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');
      log.e('❌❌❌ unlisted error received');
      log.e("❌❌❌ $e");

      return const Response(body: {
        "message": "Something went wrong"
      }, statusCode: 400, statusText: "Something went wrong");
    }
  }

  Future<Response> put(
      {required String url,
        bool? isBasic,
        required Map<String, dynamic> body,
        int code = 202,
        int duration = 30,
      }) async {
    try {

      /// ======================- Check Internet ===================

      if (!await connectionChecker.isConnected) {
        log.i('|📍📍📍|----------------- [[ GET ]] method GET Internet Issue, URL $url -----------------|📍📍📍|');
        return Response(statusCode: 503, body: {"status": false, "message": noInternetConnection}, statusText: noInternetConnection);
      }
      log.i('|📍📍📍|----------------- [[ GET ]] method details start -----------------|📍📍📍|');
      log.i(url);

      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: isBasic! ? basicHeaderInfo() : await bearerHeaderInfo(),
      ).timeout(Duration(seconds: duration));

      log.d("Body => ${response.body}");
      log.d("Status Code => ${response.statusCode}");

      log.i('|📒📒📒|-----------------[[ GET ]] method response end -----------------|📒📒📒|');

      if (response.statusCode == code) {
        final decodeBody = jsonDecode(response.body);
        return Response(
          body: decodeBody,
          statusCode: response.statusCode,
        );
      } else {

        log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');
        log.e('unknown error hitted in status code  ${jsonDecode(response.body)}');

        return Response(
          body: jsonDecode(response.body),
          statusCode: response.statusCode,
        );
      }
    }  on SocketException {

      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert on Socket Exception');
    } on TimeoutException {

      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');
      log.e('Time out exception$url');

      return const Response(body: {
        "message": "Time out exception"
      }, statusCode: 400, statusText: '');
    } on http.ClientException {

      log.e('🐞🐞🐞 Error Alert Client Exception 🐞🐞🐞');
      log.e('client exception hitted');

      return const Response(body: {
        "message": "Issue with your Server"
      }, statusCode: 400, statusText: 'Error Alert Client Exception');
    } catch (e) {

      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');
      log.e('❌❌❌ unlisted error received');
      log.e("❌❌❌ $e");

      return const Response(body: {
        "message": "Something went wrong"
      }, statusCode: 400, statusText: "Something went wrong");
    }
  }
}

class MultipartBody {
  String key;
  File file;
  MultipartBody(this.key, this.file);
}