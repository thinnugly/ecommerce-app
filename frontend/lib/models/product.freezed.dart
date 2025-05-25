// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get productName => throw _privateConstructorUsedError;
  Category get category => throw _privateConstructorUsedError;
  String get productShortDescription => throw _privateConstructorUsedError;
  String? get productDescription => throw _privateConstructorUsedError;
  double get productPrice => throw _privateConstructorUsedError;
  double get productSalePrice => throw _privateConstructorUsedError;
  String get productSKU => throw _privateConstructorUsedError;
  String get productType => throw _privateConstructorUsedError;
  String get stockStatus => throw _privateConstructorUsedError;
  String get productImage => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    String productName,
    Category category,
    String productShortDescription,
    String? productDescription,
    double productPrice,
    double productSalePrice,
    String productSKU,
    String productType,
    String stockStatus,
    String productImage,
    String productId,
  });

  $CategoryCopyWith<$Res> get category;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? category = null,
    Object? productShortDescription = null,
    Object? productDescription = freezed,
    Object? productPrice = null,
    Object? productSalePrice = null,
    Object? productSKU = null,
    Object? productType = null,
    Object? stockStatus = null,
    Object? productImage = null,
    Object? productId = null,
  }) {
    return _then(
      _value.copyWith(
            productName:
                null == productName
                    ? _value.productName
                    : productName // ignore: cast_nullable_to_non_nullable
                        as String,
            category:
                null == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as Category,
            productShortDescription:
                null == productShortDescription
                    ? _value.productShortDescription
                    : productShortDescription // ignore: cast_nullable_to_non_nullable
                        as String,
            productDescription:
                freezed == productDescription
                    ? _value.productDescription
                    : productDescription // ignore: cast_nullable_to_non_nullable
                        as String?,
            productPrice:
                null == productPrice
                    ? _value.productPrice
                    : productPrice // ignore: cast_nullable_to_non_nullable
                        as double,
            productSalePrice:
                null == productSalePrice
                    ? _value.productSalePrice
                    : productSalePrice // ignore: cast_nullable_to_non_nullable
                        as double,
            productSKU:
                null == productSKU
                    ? _value.productSKU
                    : productSKU // ignore: cast_nullable_to_non_nullable
                        as String,
            productType:
                null == productType
                    ? _value.productType
                    : productType // ignore: cast_nullable_to_non_nullable
                        as String,
            stockStatus:
                null == stockStatus
                    ? _value.stockStatus
                    : stockStatus // ignore: cast_nullable_to_non_nullable
                        as String,
            productImage:
                null == productImage
                    ? _value.productImage
                    : productImage // ignore: cast_nullable_to_non_nullable
                        as String,
            productId:
                null == productId
                    ? _value.productId
                    : productId // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res> get category {
    return $CategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String productName,
    Category category,
    String productShortDescription,
    String? productDescription,
    double productPrice,
    double productSalePrice,
    String productSKU,
    String productType,
    String stockStatus,
    String productImage,
    String productId,
  });

  @override
  $CategoryCopyWith<$Res> get category;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? category = null,
    Object? productShortDescription = null,
    Object? productDescription = freezed,
    Object? productPrice = null,
    Object? productSalePrice = null,
    Object? productSKU = null,
    Object? productType = null,
    Object? stockStatus = null,
    Object? productImage = null,
    Object? productId = null,
  }) {
    return _then(
      _$ProductImpl(
        productName:
            null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                    as String,
        category:
            null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as Category,
        productShortDescription:
            null == productShortDescription
                ? _value.productShortDescription
                : productShortDescription // ignore: cast_nullable_to_non_nullable
                    as String,
        productDescription:
            freezed == productDescription
                ? _value.productDescription
                : productDescription // ignore: cast_nullable_to_non_nullable
                    as String?,
        productPrice:
            null == productPrice
                ? _value.productPrice
                : productPrice // ignore: cast_nullable_to_non_nullable
                    as double,
        productSalePrice:
            null == productSalePrice
                ? _value.productSalePrice
                : productSalePrice // ignore: cast_nullable_to_non_nullable
                    as double,
        productSKU:
            null == productSKU
                ? _value.productSKU
                : productSKU // ignore: cast_nullable_to_non_nullable
                    as String,
        productType:
            null == productType
                ? _value.productType
                : productType // ignore: cast_nullable_to_non_nullable
                    as String,
        stockStatus:
            null == stockStatus
                ? _value.stockStatus
                : stockStatus // ignore: cast_nullable_to_non_nullable
                    as String,
        productImage:
            null == productImage
                ? _value.productImage
                : productImage // ignore: cast_nullable_to_non_nullable
                    as String,
        productId:
            null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  _$ProductImpl({
    required this.productName,
    required this.category,
    required this.productShortDescription,
    this.productDescription,
    required this.productPrice,
    required this.productSalePrice,
    required this.productSKU,
    required this.productType,
    required this.stockStatus,
    required this.productImage,
    required this.productId,
  });

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String productName;
  @override
  final Category category;
  @override
  final String productShortDescription;
  @override
  final String? productDescription;
  @override
  final double productPrice;
  @override
  final double productSalePrice;
  @override
  final String productSKU;
  @override
  final String productType;
  @override
  final String stockStatus;
  @override
  final String productImage;
  @override
  final String productId;

  @override
  String toString() {
    return 'Product(productName: $productName, category: $category, productShortDescription: $productShortDescription, productDescription: $productDescription, productPrice: $productPrice, productSalePrice: $productSalePrice, productSKU: $productSKU, productType: $productType, stockStatus: $stockStatus, productImage: $productImage, productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(
                  other.productShortDescription,
                  productShortDescription,
                ) ||
                other.productShortDescription == productShortDescription) &&
            (identical(other.productDescription, productDescription) ||
                other.productDescription == productDescription) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
            (identical(other.productSalePrice, productSalePrice) ||
                other.productSalePrice == productSalePrice) &&
            (identical(other.productSKU, productSKU) ||
                other.productSKU == productSKU) &&
            (identical(other.productType, productType) ||
                other.productType == productType) &&
            (identical(other.stockStatus, stockStatus) ||
                other.stockStatus == stockStatus) &&
            (identical(other.productImage, productImage) ||
                other.productImage == productImage) &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productName,
    category,
    productShortDescription,
    productDescription,
    productPrice,
    productSalePrice,
    productSKU,
    productType,
    stockStatus,
    productImage,
    productId,
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product implements Product {
  factory _Product({
    required final String productName,
    required final Category category,
    required final String productShortDescription,
    final String? productDescription,
    required final double productPrice,
    required final double productSalePrice,
    required final String productSKU,
    required final String productType,
    required final String stockStatus,
    required final String productImage,
    required final String productId,
  }) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get productName;
  @override
  Category get category;
  @override
  String get productShortDescription;
  @override
  String? get productDescription;
  @override
  double get productPrice;
  @override
  double get productSalePrice;
  @override
  String get productSKU;
  @override
  String get productType;
  @override
  String get stockStatus;
  @override
  String get productImage;
  @override
  String get productId;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
