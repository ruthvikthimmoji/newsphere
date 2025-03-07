import 'package:flutter/material.dart';
import 'package:news_sphere/common/widgets/widget_tree.dart';
import 'package:news_sphere/presentation/auth/login_page.dart';

import '../../core/configs/images/app_images.dart';

class GetStartedPage2 extends StatelessWidget {
  const GetStartedPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
              child: Image.asset(
            AppImages.startBG,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
            fit: BoxFit.cover,
          )),

          // Main content with SafeArea
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // News Collage or Carousel
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      _newsImage('assets/images/news1.jpg'),
                      _newsImage('assets/images/news2.jpg'),
                      _newsImage('assets/images/news3.jpg'),
                      _newsImage('assets/images/news4.jpg')
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Text Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "All your news, personalised and in one place\nstay informed effortlessly!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Get Started Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => WidgetTree()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create news images
  Widget _newsImage(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        path,
        fit: BoxFit.cover,
      ),
    );
  }
}
