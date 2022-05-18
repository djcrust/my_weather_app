import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_weather_app/controller/controller.dart';
//import 'package:my_weather_app/models/city.dart';
import 'package:my_weather_app/models/constants.dart';

class Welcome extends GetView<HomeController> {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List<City> selectedCities = homeCtrl.getSelectedCities();

    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myConstants.secondaryColor,
        centerTitle: true,
        //title: Text('${selectedCities.length} selected'),
        title: const Text('0 selected'),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            }),
      ),
      body: Obx(
        () => SafeArea(
          child: ListView.builder(
            itemCount: controller.cities.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(left: 10, top: 20, right: 18),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: size.height * 0.08,
                width: size.width,
                decoration: BoxDecoration(
                  border: controller.cities[index].isSelected == true
                      ? Border.all(
                          color: myConstants.secondaryColor.withOpacity(0.6),
                          width: 2,
                        )
                      : Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: myConstants.primaryColor.withOpacity(.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setSelectedCity(index);
                      },
                      child: Image.asset(
                        controller.cities[index].isSelected == true
                            ? 'assets/checked.png'
                            : 'assets/unchecked.png',
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      controller.cities[index].city,
                      style: TextStyle(
                        fontSize: 16,
                        color: controller.cities[index].isSelected == true
                            ? myConstants.primaryColor
                            : Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myConstants.secondaryColor,
        child: const Icon(Icons.pin_drop),
        onPressed: () {},
      ),
    );
  }
}
