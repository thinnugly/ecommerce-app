// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/pagination.dart';
import 'package:frontend/models/slider.dart';
import 'package:frontend/providers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSliderWidget extends ConsumerStatefulWidget {
  const HomeSliderWidget({super.key});

  @override
  ConsumerState<HomeSliderWidget> createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends ConsumerState<HomeSliderWidget> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final sliders = ref.watch(
      slidersProvider(PaginationModel(page: 1, pageSize: 10)),
    );

    return sliders.when(
      data: (list) {
        if (list == null || list.isEmpty) {
          return const Center(child: Text('No sliders available.'));
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: list.length,
              itemBuilder: (context, index, realIndex) {
                final model = list[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(model.fullImagePath, fit: BoxFit.cover),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom:
                              32,
                          left: 16,
                          child: Text(
                            'No. ${index + 1} image',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 6,
                                  color: Colors.black45,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 0.85,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            AnimatedSmoothIndicator(
              activeIndex: _currentIndex,
              count: list.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.deepOrangeAccent,
                dotColor: Colors.grey.shade300,
              ),
              onDotClicked: (index) {
                _carouselController.animateToPage(index);
              },
            ),
          ],
        );
      },
      error: (err, stack) => Center(child: Text('Err: $err')),
      loading:
          () => const SizedBox(
            height: 210,
            child: Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
