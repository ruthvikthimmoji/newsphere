import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_sphere/data/courosel_data/caurosel_data.dart';

class CarouselCard extends StatelessWidget {
  final int index;
  const CarouselCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: couroselData.length,
            options: CarouselOptions(
              height: 300.0,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              final heading = couroselData[index]['heading'] ?? "No headline";
              final desc =
                  couroselData[index]['description'] ?? "No description";
              return Card(
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        heading,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
