// order_model.dart

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  factory OrderModel({
    @JsonKey(name: '_id') required String orderID,
    required String userId,
    required List<OrderProduct> products,
    required int grandTotal,
    required String orderStatus,
    required String createdAt,
    required String updatedAt,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

@freezed
class OrderProduct with _$OrderProduct {
  factory OrderProduct({
    required String product, // ID do produto referenciado
    required int amount,
    required int qty,
    @JsonKey(name: '_id') required String id, // ID do item no array
  }) = _OrderProduct;

  factory OrderProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderProductFromJson(json);
}
