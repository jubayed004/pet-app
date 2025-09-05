import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';

class TopBrandsCarousel extends StatelessWidget {
  const TopBrandsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 8,
        viewportFraction: 1.0,
      ),
      items: List.generate(
        5,
            (index) => ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: const CustomImage(
            imageSrc: "assets/images/topbrandsimage.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}