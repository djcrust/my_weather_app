import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_weather_app/controller/controller.dart';
import 'package:my_weather_app/models/constants.dart';
import 'package:my_weather_app/ui/welcome.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({Key? key}) : super(key: key);

  //Create a shader linear gradient
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    Constants myyConstants = Constants();

    return Scaffold(
      backgroundColor: myyConstants.secondaryColor,
      appBar: AppBar(
        title: Text(homeCtrl.objTest1.location.name),
        centerTitle: true,
        backgroundColor: myyConstants.secondaryColor,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Get.to(() => Welcome());
              },
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Stack(),
    );
  }
}
