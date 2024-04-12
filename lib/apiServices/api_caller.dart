

import 'dart:convert';

import 'package:mayaweather/model/weather_model.dart';
import 'package:http/http.dart' as http;

class ApiCaller{

  WeatherModel? weatherModel;

  Future<WeatherModel> getData(lat,lon) async{
    var response =await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=b007b683fb7bad77392ba419766a08c7"));
    final result=jsonDecode(response.body);
    weatherModel = WeatherModel.fromJson(result);
    return weatherModel!;
  }

}