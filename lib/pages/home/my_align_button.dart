import 'package:flutter/material.dart';

class AlignImageButton extends StatelessWidget {
  final Alignment alignment;
  final String imageUrl;
  final void Function()? onTap;
  const AlignImageButton({
    required this.alignment,
    required this.onTap,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child:GestureDetector(
        child: SizedBox(
          height: 70*0.85,
          width: 245*0.85,
          child: Image(
            image: AssetImage(imageUrl),
            fit: BoxFit.fill,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
