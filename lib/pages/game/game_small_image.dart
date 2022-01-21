import 'package:flutter/material.dart';

class SmallImage extends StatelessWidget {
  final void Function()? onTap;
  final String imageUrl;
  const SmallImage({
    required this.onTap,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110.0*618.0/772.0,
        width: 110,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            )
        ),
      ),
    );
  }
}

