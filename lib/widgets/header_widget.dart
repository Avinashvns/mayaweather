

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mayaweather/controller/maya_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final MayaController controller = Get.put(MayaController(),permanent: true);
  String city="";

  String date =DateFormat("yMMMMd").format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress(controller.getLatitude().value, controller.getLongitude().value);
  }

  getAddress(lati,longi)async{
    List<Placemark> placemarks =await placemarkFromCoordinates(lati, longi);
    Placemark place = placemarks[0];
    print(place);
    setState(() {
      city=place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          alignment: Alignment.topLeft,
          child: Text(city,style: TextStyle(fontSize: 34,height: 2),),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(date,style: TextStyle(fontSize: 18,height: 1.5),),
        ),
      ],
    );
  }
}
