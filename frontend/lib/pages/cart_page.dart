// ignore_for_file: avoid_unnecessary_containers, camel_case_types, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/cart.dart';
import 'package:frontend/models/cart_product.dart';
import 'package:frontend/pages/success_page.dart';
import 'package:frontend/providers.dart';
import 'package:frontend/widgets/widget_cart_item.dart';
import 'package:frontend/api/api_service.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:frontend/pages/paypal_webview_page.dart';

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
      return const Center(child: Text("Cart Empty"));
    }

    return _buildCartItems(
      cartState.cartModel!.products,
      ref,
    ); // Exibe os itens do carrinho
  }
}

Future<void> openPaypalUrl(String url) async {
  final Uri paypalUrl = Uri.parse(url);

  try {
    await launchUrl(paypalUrl, mode: LaunchMode.externalApplication);
  } catch (e) {
    throw Exception('Erro ao abrir o link do PayPal: $e');
  }
}

class _checkoutButtonNavabar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(cartItemsProvider);

    if (cartProvider.cartModel == null ||
        cartProvider.cartModel!.products.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
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
              GestureDetector(
                child: const Text(
                  "Proccess to Check",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  final scaffold = ScaffoldMessenger.of(context);
                  scaffold.showSnackBar(
                    const SnackBar(content: Text('Processando pagamento...')),
                  );

                  try {
                    final order = await ref.read(apiService).createOrder();
                    if (order == null) throw Exception('Falha ao criar pedido');

                    final paypal = await ref
                        .read(apiService)
                        .createPaypalOrder(order.orderID);
                    if (paypal == null) {
                      throw Exception('Falha ao criar pagamento PayPal');
                    }

                    await openPaypalUrl(paypal.approvalUrl);

                    scaffold.showSnackBar(
                      const SnackBar(
                        content: Text('Depois de pagar, volte para a app.'),
                      ),
                    );

                    // Verificação automática por 1 minuto (a cada 5 segundos)
                    const totalChecks = 12; // 60s / 5s
                    for (int i = 0; i < totalChecks; i++) {
                      await Future.delayed(const Duration(seconds: 5));

                      final status =
                          await ref.read(apiService).getPaymentStatus(order.orderID);
                          logger.i(status);
                      if (status == 'COMPLETED') {
                        await ref.read(apiService).clearCartByUserId();
                        ref.read(cartItemsProvider.notifier).clearCart();

                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SuccessPage(),
                            ),
                          );
                        }
                        return;
                      }
                    }

                    // Após 1 minuto, mostra diálogo de verificação manual
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text('Pagamento pendente'),
                              content: const Text(
                                'Ainda não detectamos o pagamento.\n\nSe já pagou, clique abaixo para verificar novamente.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();

                                    final status =
                                        await ref
                                            .read(apiService)
                                            .getPaymentStatus(order.orderID);
                                    if (status == 'COMPLETED') {
                                      await ref
                                          .read(apiService)
                                          .clearCartByUserId();
                                      ref
                                          .read(cartItemsProvider.notifier)
                                          .clearCart();

                                      if (context.mounted) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const SuccessPage(),
                                          ),
                                        );
                                      }
                                    } else {
                                      scaffold.showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Pagamento ainda não confirmado.',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Verificar pagamento manualmente',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancelar'),
                                ),
                              ],
                            ),
                      );
                    }
                  } catch (e) {
                    scaffold.showSnackBar(
                      SnackBar(content: Text('Erro, peguei: ${e.toString()}')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
