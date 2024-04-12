

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mayaweather/page/home_page.dart';

void main(){
  runApp(
    GetMaterialApp(
      home: HomeScreen(),
      title: "Maya Weather",
      debugShowCheckedModeBanner: false,
    )
  );
}