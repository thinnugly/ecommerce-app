import 'package:flutter/material.dart';
import 'package:frontend/components/widget_custom_stepper.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/cart_product.dart';
import 'package:frontend/models/product.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    required this.model,
    this.onQtyUpdate,
    this.onItemRemove,
    super.key,
  });

  final CartProduct model;
  final Function? onQtyUpdate;
  final Function? onItemRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do produto com verificação segura
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                model.product.productImage != ""
                    ? model.product.fullImagePath
                    : "",
                height: 140,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 12),

            // Informações do produto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${Config.currency}${model.product.productPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 13,
                      color:
                          model.product.calculateDiscount > 0
                              ? Colors.red
                              : Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration:
                          model.product.productSalePrice > 0
                              ? TextDecoration.lineThrough
                              : null,
                      decorationColor:
                          model.product.calculateDiscount > 0
                              ? Colors.red
                              : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    model.product.calculateDiscount > 0
                        ? "${Config.currency}${model.product.productSalePrice}"
                        : "",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Stepper e botão remover
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomStepper(
                        lowerLimit: 1,
                        upperLimit: 20,
                        stepValue: 1,
                        iconSize: 18.0,
                        value: model.qty.toInt(),
                        onChanged: (value) {
                          final int newQty = value['qty'];
                          final String type = value['type'];
                          onQtyUpdate!(model, newQty, type);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () => onItemRemove!(model),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
