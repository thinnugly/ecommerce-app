import 'package:flutter/material.dart';
import 'package:frontend/widgets/widget_home_categories.dart';
import 'package:frontend/widgets/widget_home_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const HomeCategoriesWidget(), // ProductCard(model: model)
          const HomeProductsWidget(),
        ],
      ),
    );
  }
}