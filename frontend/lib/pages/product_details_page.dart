// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/components/widget_col_exp.dart';
import 'package:frontend/components/widget_custom_stepper.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/providers.dart';
import 'package:frontend/widgets/widget_related_products.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  ProductDetailsPageState createState() => ProductDetailsPageState();
}

class ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  String productId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Detail")),
      body: SingleChildScrollView(child: _productDetails(ref)),
    );
  }

  @override
  void didChangeDependencies() {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    productId = arguments["productId"];
    super.didChangeDependencies();
  }

  Widget _productDetails(WidgetRef ref) {
    final details = ref.watch(productDetailsProvider(productId));

    return details.when(
      data: (model) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_productDetailsUI(model!),
          RelatedProductsWidget(relatedProducts: model.relatedProducts!),
          SizedBox(
            height: 10,
          )
          ],
        );
      },

      error: (err, _) => Center(child: Text('Err: $err')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _productDetailsUI(Product model) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(model.fullImagePath, fit: BoxFit.fitHeight),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            model.productName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${Config.currency}${model.productPrice.toString()}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13,
                      color:
                          model.calculateDiscount > 0
                              ? Colors.red
                              : Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration:
                          model.productSalePrice > 0
                              ? TextDecoration.lineThrough
                              : null,
                      decorationColor:
                          model.calculateDiscount > 0 ? Colors.red : null,
                    ),
                  ),
                  Text(
                    model.calculateDiscount > 0
                        ? " ${model.productSalePrice.toString()}"
                        : "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Text(
                  "SHARE",
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
                label: const Icon(Icons.share, color: Colors.black, size: 20),
              ),
            ],
          ),
          Text(
            "Availability: ${model.stockStatus}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Product Code: ${model.productSKU}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomStepper(
                lowerLimit: 1,
                upperLimit: 20,
                stepValue: 1,
                iconSize: 22.0,
                value: 1,
                onChanged: (value){
                  
                },
              ),
              TextButton.icon(
                onPressed: () {

                }, 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                icon: const Icon(
                  Icons.shopping_basket,
                  color: Colors.white
                ),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
                )
            ],
          ),
          const SizedBox(height: 15),
          ColExpand(
            title: "SHORT DESCRIPTION",
            content: model.productShortDescription,
            )
        ],
      ),
    );
  }
}
