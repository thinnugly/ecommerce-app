// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paypal_order_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaypalOrderResponse _$PaypalOrderResponseFromJson(Map<String, dynamic> json) {
  return _PaypalOrderResponse.fromJson(json);
}

/// @nodoc
mixin _$PaypalOrderResponse {
  String get approvalUrl => throw _privateConstructorUsedError;

  /// Serializes this PaypalOrderResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaypalOrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaypalOrderResponseCopyWith<PaypalOrderResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaypalOrderResponseCopyWith<$Res> {
  factory $PaypalOrderResponseCopyWith(
    PaypalOrderResponse value,
    $Res Function(PaypalOrderResponse) then,
  ) = _$PaypalOrderResponseCopyWithImpl<$Res, PaypalOrderResponse>;
  @useResult
  $Res call({String approvalUrl});
}

/// @nodoc
class _$PaypalOrderResponseCopyWithImpl<$Res, $Val extends PaypalOrderResponse>
    implements $PaypalOrderResponseCopyWith<$Res> {
  _$PaypalOrderResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaypalOrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? approvalUrl = null}) {
    return _then(
      _value.copyWith(
            approvalUrl:
                null == approvalUrl
                    ? _value.approvalUrl
                    : approvalUrl // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaypalOrderResponseImplCopyWith<$Res>
    implements $PaypalOrderResponseCopyWith<$Res> {
  factory _$$PaypalOrderResponseImplCopyWith(
    _$PaypalOrderResponseImpl value,
    $Res Function(_$PaypalOrderResponseImpl) then,
  ) = __$$PaypalOrderResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String approvalUrl});
}

/// @nodoc
class __$$PaypalOrderResponseImplCopyWithImpl<$Res>
    extends _$PaypalOrderResponseCopyWithImpl<$Res, _$PaypalOrderResponseImpl>
    implements _$$PaypalOrderResponseImplCopyWith<$Res> {
  __$$PaypalOrderResponseImplCopyWithImpl(
    _$PaypalOrderResponseImpl _value,
    $Res Function(_$PaypalOrderResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaypalOrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? approvalUrl = null}) {
    return _then(
      _$PaypalOrderResponseImpl(
        approvalUrl:
            null == approvalUrl
                ? _value.approvalUrl
                : approvalUrl // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaypalOrderResponseImpl implements _PaypalOrderResponse {
  _$PaypalOrderResponseImpl({required this.approvalUrl});

  factory _$PaypalOrderResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaypalOrderResponseImplFromJson(json);

  @override
  final String approvalUrl;

  @override
  String toString() {
    return 'PaypalOrderResponse(approvalUrl: $approvalUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaypalOrderResponseImpl &&
            (identical(other.approvalUrl, approvalUrl) ||
                other.approvalUrl == approvalUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, approvalUrl);

  /// Create a copy of PaypalOrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaypalOrderResponseImplCopyWith<_$PaypalOrderResponseImpl> get copyWith =>
      __$$PaypalOrderResponseImplCopyWithImpl<_$PaypalOrderResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaypalOrderResponseImplToJson(this);
  }
}

abstract class _PaypalOrderResponse implements PaypalOrderResponse {
  factory _PaypalOrderResponse({required final String approvalUrl}) =
      _$PaypalOrderResponseImpl;

  factory _PaypalOrderResponse.fromJson(Map<String, dynamic> json) =
      _$PaypalOrderResponseImpl.fromJson;

  @override
  String get approvalUrl;

  /// Create a copy of PaypalOrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaypalOrderResponseImplCopyWith<_$PaypalOrderResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
