// ignore_for_file: avoid_unnecessary_containers, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/cart.dart';
import 'package:frontend/models/cart_product.dart';
import 'package:frontend/providers.dart';
import 'package:frontend/widgets/widget_cart_item.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      bottomNavigationBar:
          _checkoutButtonNavabar(), // Aqui é onde o botão de checkout é exibido
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Flexible(flex: 1, child: _cartList(ref))],
        ),
      ),
    );
  }

  Widget _buildCartItems(List<CartProduct> cartProduct, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: cartProduct.length,
      itemBuilder: (context, index) {
        return CartItemWidget(
          model: cartProduct[index],
          onQtyUpdate: (CartProduct model, qty, type) {
            final cartViewModel = ref.read(cartItemsProvider.notifier);
            cartViewModel.updateQty(model.product.productId, qty, type);
          },
          onItemRemove: (CartProduct model) {
            final cartViewModel = ref.read(cartItemsProvider.notifier);
            cartViewModel.removeCartItem(model.product.productId, model.qty);
          },
        );
      },
    );
  }

  Widget _cartList(WidgetRef ref) {
    final cartState = ref.watch(cartItemsProvider);

    if (cartState.cartModel == null) {
      return const LinearProgressIndicator(); 
    }

    if (cartState.cartModel!.products.isEmpty) {
      return const Center(
        child: Text("Cart Empty"),
      ); 
    }

    return _buildCartItems(
      cartState.cartModel!.products,
      ref,
    ); // Exibe os itens do carrinho
  }
}

class _checkoutButtonNavabar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(cartItemsProvider);

    // Aqui verificamos se o carrinho não está vazio
    if (cartProvider.cartModel != null &&
        cartProvider.cartModel!.products.isNotEmpty) {
      // Exibe o botão de checkout se o carrinho contiver produtos
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total ${Config.currency}${cartProvider.cartModel!.grandTotal.toString()}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Processed to Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Se o carrinho estiver vazio, retorna SizedBox para não ocupar espaço
    return const SizedBox();
  }
}
