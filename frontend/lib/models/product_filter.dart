import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/models/pagination.dart';

part 'product_filter.freezed.dart';

@freezed
class ProductFilterModel with _$ProductFilterModel {
  factory ProductFilterModel({
    required PaginationModel paginationModel,
    String? categoryId,
    String? sortBy,
    List<String>? productIds,
  }) = _ProductFilterModel;
}
