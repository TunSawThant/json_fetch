import 'dart:convert';

import 'package:json_fetch/model/json_fetch.dart';
import 'package:http/http.dart' as http;

class ApiService{
  String url="https://unsplash.com/napi/photos/Q14J2k8VE3U/related";
  Future<JsonFetch> fetchData() async{
    http.Response response=await http.get('$url',headers: {"Accept": "application/json"});
    if(response.statusCode==200){
      var res=jsonDecode(response.body);
      return JsonFetch.fromJson(res);
    }
    else{
      return throw Exception('Network error');
    }

  }
}