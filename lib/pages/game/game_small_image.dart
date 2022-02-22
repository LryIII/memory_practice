import 'package:flutter/material.dart';

import '../../components/global.dart';

class SmallImage extends StatelessWidget {
  final void Function()? onTap;
  final String imageUrl;
  final int state;
  final double unitH=GlobalUnit().unitHeight;
  final double unitW=GlobalUnit().unitWidth;
  SmallImage({
    required this.onTap,
    required this.imageUrl,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(state==0){
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 110.0*618.0/772.0*unitH,
          width: 110*unitW,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    if(state==1){
      return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 110.0*618.0/772.0*unitH,
          width: 110*unitW,
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(0, 0),
                child: Container(
                  height: 110.0*618.0/772.0*0.95*unitH,
                  width: 110*0.95*unitW,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blue,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment(1,-1),
                child: Icon(
                  Icons.done_outline,
                  color: Colors.blue,
                  size: 23.0,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 110.0*618.0/772.0*unitH,
        width: 110*unitW,
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, 0),
              child: Container(
                height: 110.0*618.0/772.0*0.95*unitH,
                width: 110*0.95*unitW,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.red,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment(1,-1),
              child: Icon(
                Icons.clear,
                color: Colors.red,
                size: 23.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

