import 'package:freezed_annotation/freezed_annotation.dart';

part 'paypal_order_response.freezed.dart';
part 'paypal_order_response.g.dart';

@freezed
class PaypalOrderResponse with _$PaypalOrderResponse {
  factory PaypalOrderResponse({
    required String approvalUrl,
  }) = _PaypalOrderResponse;

  factory PaypalOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$PaypalOrderResponseFromJson(json);
}
