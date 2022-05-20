import 'package:flutter/material.dart';

class Weatherwidget extends StatelessWidget {
  const Weatherwidget({
    Key? key,
    required this.value,
    required this.text,
    required this.unit,
    required this.imageUrl,
  }) : super(key: key);

  final String value;
  final String text;
  final String unit;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          height: 60.0,
          width: 60.0,
          decoration: const BoxDecoration(
            color: Color(0xffE0E8FB),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Image.asset(imageUrl),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          double.parse(value).round().toString() + unit,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
