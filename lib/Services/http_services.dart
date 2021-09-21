import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_data/constant/constant.dart';
import 'package:http/http.dart' as http;

class Services {
  List<String>title = [];
  List<String>description = [];
  List<String>image = [];
  bool loading = true;

  shareFeelingsData() async {
    String Api = shareFeelingApi;


    var response = await http.get(Uri.parse(Api));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      for (int i = 0; i < jsonResponse['result'].length; i++) {
        title.add(jsonResponse['result'][i]['title']);
        description.add(jsonResponse['result'][i]['description']);
        image.add(jsonResponse['result'][i]['imgpath']);
      }

      loading = false;
      print(title.toString());
      print(description.toString());
      print(image.toString());
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

