import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/models/cart_product.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';


@freezed
class Cart with _$Cart {
  factory Cart({
    required String userId,
    required List<CartProduct> products,
    required String cartId,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) =>
      _$CartFromJson(json);
}

extension CartExt on Cart {
  double get grandTotal {
    return products.map((e)=> e.product.productPrice * e.qty).fold(0, (p, c) => p + c);
  }
}
