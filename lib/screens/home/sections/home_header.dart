import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../model/show.dart';
import '../item_slider.dart';

class HomeHeader extends StatelessWidget {
  final List<Show> sliders;
  const HomeHeader({required this.sliders, super.key});

  @override
  Widget build(BuildContext context) {
    if (sliders.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider.builder(
      itemCount: sliders.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final Show sliderDrama = sliders[index];

        if (sliderDrama.isEmpty) return const SizedBox.shrink();

        return ItemSlider(
          heroId: 'slider-${sliderDrama.id}$index',
          item: sliderDrama,
        );
      },
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        autoPlay: true,
        clipBehavior: Clip.none,
      ),
    );
  }
}
