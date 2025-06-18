// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      orderID: json['_id'] as String,
      userId: json['userId'] as String,
      products:
          (json['products'] as List<dynamic>)
              .map((e) => OrderProduct.fromJson(e as Map<String, dynamic>))
              .toList(),
      grandTotal: (json['grandTotal'] as num).toInt(),
      orderStatus: json['orderStatus'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.orderID,
      'userId': instance.userId,
      'products': instance.products,
      'grandTotal': instance.grandTotal,
      'orderStatus': instance.orderStatus,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_$OrderProductImpl _$$OrderProductImplFromJson(Map<String, dynamic> json) =>
    _$OrderProductImpl(
      product: json['product'] as String,
      amount: (json['amount'] as num).toInt(),
      qty: (json['qty'] as num).toInt(),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$$OrderProductImplToJson(_$OrderProductImpl instance) =>
    <String, dynamic>{
      'product': instance.product,
      'amount': instance.amount,
      'qty': instance.qty,
      '_id': instance.id,
    };
