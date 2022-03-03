import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.8,
        backgroundColor: const Color.fromARGB(0xff, 246, 246, 246),
        title: const Text(
          "关于我们",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height:double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(0xff, 246, 246, 246),
        ),
        child:Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/about.png'
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
