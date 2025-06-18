import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/api/api_service.dart';
import 'package:frontend/application/state/cart_state.dart';
import 'package:frontend/models/cart_product.dart';

class CartNotifier extends StateNotifier<CartState> {
  final APIService _apiService;

  CartNotifier(this._apiService) : super(const CartState()) {
    getCartItems();
  }

  Future<void> getCartItems() async {
    state = state.copyWith(isLoading: true);
    logger.i("Carregando os itens do carrinho...");

    final cartData = await _apiService.getCart();
    if (cartData != null) {
      logger.i("Carrinho carregado: ${cartData.products.length} produtos.");
      state = state.copyWith(cartModel: cartData);
    } else {
      logger.i("Falha ao carregar os itens do carrinho.");
    }

    state = state.copyWith(isLoading: false);
  }

  Future<void> addCartItem(productId, qty) async {
    await _apiService.addCartItem(productId, qty);
    await getCartItems();
  }

  Future<void> removeCartItem(productId, qty) async {
    logger.i("Iniciando remoção de item: $productId, qty: $qty");

    // Chamada à API
    final success = await _apiService.removeCartItem(productId, qty);

    if (success != true) {
      logger.i("Falha ao remover item do servidor.");
      return;
    }

    // Verifica se o item existe no estado
    final cartItems = state.cartModel?.products ?? [];
    final isCartItemExist = cartItems.any(
      (element) => element.product.productId == productId,
    );

    if (!isCartItemExist) {
      logger.i("Item $productId não encontrado no estado local.");
      return;
    }

    // Clonar profundamente os itens
    List<CartProduct> updatedProducts =
        cartItems
            .map((p) => CartProduct(qty: p.qty, product: p.product))
            .toList();

    // Remover item
    updatedProducts.removeWhere((item) => item.product.productId == productId);
    logger.i("Produto $productId removido da lista local.");

    // Atualizar estado
    final updatedCartModel = state.cartModel!.copyWith(
      products: updatedProducts,
    );
    state = state.copyWith(cartModel: updatedCartModel);

    logger.i(
      "Estado atualizado com produtos: ${updatedProducts.map((e) => e.product.productId).toList()}",
    );
  }

  Future<void> updateQty(productId, qty, type) async {
    // Encontrar o item que precisa ser atualizado
    var cartItem = state.cartModel!.products.firstWhere(
      (element) => element.product.productId == productId,
    );

    // Criar uma cópia da lista de produtos
    List<CartProduct> updatedProducts = List.from(state.cartModel!.products);

    if (type == "-") {
      // Remover item do servidor
      await _apiService.removeCartItem(productId, 1);

      if (cartItem.qty > 1) {
        // Atualizar a quantidade do item no carrinho
        CartProduct updatedCartItem = CartProduct(
          qty: cartItem.qty - 1,
          product: cartItem.product,
        );

        // Substituir o item antigo pelo novo item com a quantidade atualizada
        updatedProducts[updatedProducts.indexOf(cartItem)] = updatedCartItem;
      } else {
        // Se a quantidade for 1, removemos o item
        updatedProducts.remove(cartItem);
      }
    } else {
      // Adicionar item ao servidor
      await _apiService.addCartItem(productId, 1);

      // Atualizar a quantidade do item no carrinho
      CartProduct updatedCartItem = CartProduct(
        qty: cartItem.qty + 1,
        product: cartItem.product,
      );

      // Substituir o item antigo pelo novo item com a quantidade atualizada
      updatedProducts[updatedProducts.indexOf(cartItem)] = updatedCartItem;
    }

    // Criar um novo estado com a lista atualizada
    state = state.copyWith(
      cartModel: state.cartModel!.copyWith(products: updatedProducts),
    );

    logger.i(
      "Estado atualizado com produtos: ${updatedProducts.map((e) => e.product.productId).toList()}",
    );
  }

  void clearCart() {
    state = state.copyWith(
      cartModel: state.cartModel?.copyWith(products: []),
    );
  }
}
