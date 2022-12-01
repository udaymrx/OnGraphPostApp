import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

import 'app_exception.dart';

// Base Class for API Client

// ignore: avoid_classes_with_only_static_members
mixin APIClient {
  // Base URL for App
  static const baseUrl = "recipiesocialapp.herokuapp.com";

  // converting String response to Json response
  static dynamic returnResponse(http.Response response) {
    developer.log("${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(response.body);
        developer.log(responseJson.toString());

        // If there is error, throw exception
        if (responseJson["error"]) {
          throw NotFoundException();
        }
        return responseJson;
      case 201:
        final responseJson = json.decode(response.body);
        developer.log(responseJson.toString());

        // If there is error, throw exception
        if (!responseJson["error"]) {
          throw NotFoundException();
        }
        return responseJson;
      case 400:
        throw BadRequestException();
      case 401:
        final responseJson = json.decode(response.body);
        final String fst = responseJson['message'].toString()[0];
        final String message = responseJson['message']
            .toString()
            .replaceFirst(fst, fst.toUpperCase());
        throw UnauthorisedException(message);
      case 403:
        throw UnauthorisedException();
      case 404:
        final responseJson = json.decode(response.body);
        final String fst = responseJson['message'].toString()[0];
        final String message = responseJson['message']
            .toString()
            .replaceFirst(fst, fst.toUpperCase());
        throw NotFoundException(message);
      case 500:
        throw ServerException('Internal Server Error !');
      case 502:
        throw ServerException('Bad Gateway !');
      default:
        throw ServerException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
