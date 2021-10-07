import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:http/http.dart' as http;
import 'package:menu_flutter_get/data_handling/models/menu.dart';


import '../custom_colors.dart';


Future<String> fetchJson() async {
  return Future.delayed(Duration(seconds: 4), () => 'jsonText');
}

Future<Menu> loadJson() async {
  
  var menu = Menu.fromJson(jsonDecode(await rootBundle.loadString('data/capitano_6.10.2021.json')) );
  // var url = 'https://datadirectory-453ba.firebaseapp.com/dataDirectory/data/menu.json';
  // var data = await http.get(Uri.parse(url));
  // var menu = menuModelFromJson(data.body);
  // CustomColors.background = Color(int.parse(menu.colors.background));
  // CustomColors.shade = Color(int.parse(menu.colors.shade));
  // CustomColors.selected = Color(int.parse(menu.colors.selected));
  return menu;
}



