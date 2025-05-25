import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/application/notifier/product_filter_notifier.dart';
import 'package:frontend/application/notifier/product_notifier.dart';
import 'package:frontend/application/state/product_state.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/pagination.dart';
import 'package:frontend/api/api_service.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_filter.dart';

final categoriesProvider =
    FutureProvider.family<List<Category>?, PaginationModel>((
      ref,
      paginationModel,
    ) {
      final apiRepository = ref.watch(apiService);

      return apiRepository.getCategories(
        paginationModel.page,
        paginationModel.pageSize,
      );
    });

final productsProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>((
      ref,
      productFilterModel,
    ) {
      final apiRepository = ref.watch(apiService);

      return apiRepository.getProducts(productFilterModel);
    });

final productsFilterProvider =
    StateNotifierProvider<ProductFilterNotifier, ProductFilterModel>(
      (ref) => ProductFilterNotifier(),
    );

final productsNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductsState>(
      (ref) => ProductNotifier(
        ref.watch(apiService),
        ref.watch(productsFilterProvider),
      ),
    );
