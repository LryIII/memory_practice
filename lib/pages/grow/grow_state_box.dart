import 'package:flutter/material.dart';

import '../../components/global.dart';

class GrowStateBox extends StatelessWidget {
  final String title;
  final String subtitle;
  GrowStateBox({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);
  final unitH=GlobalUnit().unitHeight;
  final unitW=GlobalUnit().unitWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (307.200 / 3.0 - 0.25)*unitW,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
