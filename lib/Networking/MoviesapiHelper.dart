import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:movies/Networking/MovieException.dart';

class ApiHelper{
  String baseURl="https://api.themoviedb.org/3/";
  Future<dynamic> get(String url) async{
    var responseJson;
    try
    {
      final response=await http.get(baseURl+url);
      responseJson=_returnResponse(response);
    }
    on SocketException{
    }
    return responseJson;
  }
 dynamic _returnResponse(http.Response response) {
    switch(response.statusCode)
    {
      case 200:
        var responseJson=json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Error occurred ${response.statusCode}');
    }
 }
}