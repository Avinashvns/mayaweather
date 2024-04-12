import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mayaweather/controller/maya_controller.dart';
import 'package:mayaweather/widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // instance of MayaController
  final MayaController controller = Get.put(MayaController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(

            () => controller.checkLoading().isTrue ?
            const Center(
              child: CircularProgressIndicator(),
            ) : ListView(
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(child: HeaderWidget(),),
                Text(controller.weatherModel.value.weather[0].id.toString()),

              ],
            )
        ),
      ),
    );
  }
}
