import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../model/slider_drama.dart';
import '../item_slider.dart';

class HomeHeader extends StatelessWidget {
  final List<SliderDrama> sliders;
  const HomeHeader({
    required this.sliders,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (sliders.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider.builder(
      itemCount: sliders.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final SliderDrama sliderDrama = sliders[index];

        if (sliderDrama.isEmpty) return const SizedBox.shrink();

        return ItemSlider(item: sliderDrama);
      },
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        autoPlay: false,
        clipBehavior: Clip.none,
      ),
    );
  }
}
