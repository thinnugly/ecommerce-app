import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/pagination.dart';
import 'package:frontend/models/slider.dart';
import 'package:frontend/providers.dart';


class HomeSliderWidget extends ConsumerWidget {
  const HomeSliderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(child: _sliderList(ref));
  }

  Widget _sliderList(WidgetRef ref) {
    final sliders = ref.watch(
      slidersProvider(PaginationModel(page: 1, pageSize: 10)),
    );

    return sliders.when(
      data: (list) {
        if (list == null || list.isEmpty) {
          return Center(child: Text('No sliders available.'));
        }
        return imageCarousel(list);
      },
      error: (err, stack) {
        return Center(child: Text('Err: $err'));
      },
      loading: () => const SizedBox(
  height: 50,
  child: Center(child: CircularProgressIndicator()),
),

    );
  }

  Widget imageCarousel(List<SliderModel> sliderList) {
  return CarouselSlider(
    items: sliderList.map((model) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const SizedBox(height: 20, width: 20,),
            Expanded(
              child: Image.network(
                model.fullImagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ],
        ),
      );
    }).toList(),
    options: CarouselOptions(
      enlargeCenterPage: true,
      autoPlay: true,
      height: 210, // ajustado para acomodar o SizedBox (10px extra)
      autoPlayCurve: Curves.decelerate,
      enableInfiniteScroll: true,
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      viewportFraction: 0.8,
    ),
  );
}

}
