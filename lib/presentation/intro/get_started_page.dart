import 'package:flutter/material.dart';
import 'package:news_sphere/core/configs/images/app_images.dart';

import 'courosel_card.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            AppImages.startBG,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
            fit: BoxFit.cover,
          )),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CarouselCard(index: 0),
                SizedBox(
                  height: 80.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 40.0,
                  child: Center(
                    child: Text(
                      "Get Started",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
