import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/components/product_card.dart';
import 'package:frontend/models/pagination.dart';
import 'package:frontend/models/product_filter.dart';
import 'package:frontend/models/product_sort.dart';
import 'package:frontend/providers.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String? categoryId;
  String? categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductFilters(categoryId: categoryId, categoryName: categoryName),
            Flexible(flex: 1, child: _ProductList()),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    categoryId = arguments['categoryId'];
    categoryName = arguments['categoryName'];

    super.didChangeDependencies();
  }
}

class _ProductFilters extends ConsumerWidget {
  final _sortByOptions = [
    ProductSortModel(value: "createdAt", label: "Latest"),
    ProductSortModel(value: "-productPrice", label: "Price: High to Low"),
    ProductSortModel(value: "productPrice", label: "Price: Low to High"),
  ];

  _ProductFilters({Key? key, this.categoryName, this.categoryId});

  final String? categoryId;
  final String? categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterProvider = ref.watch(productsFilterProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(productsNotifierProvider.notifier).refreshProducts();
      },
      child: Container(
        height: 51,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                categoryName!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: PopupMenuButton(
                onSelected: (sortBy) {
                  ProductFilterModel filterModel = ProductFilterModel(
                    paginationModel: PaginationModel(page: 0, pageSize: 10),
                    categoryId: filterProvider.categoryId,
                    sortBy: sortBy.toString(),
                  );
                  ref
                      .read(productsFilterProvider.notifier)
                      .setProductFilter(filterModel);
        
                  ref.read(productsNotifierProvider.notifier).getProducts();
                },
                initialValue: filterProvider.sortBy,
                itemBuilder: (BuildContext context) {
                  return _sortByOptions.map((item) {
                    return PopupMenuItem(
                      value: item.value,
                      child: Text(item.label!),
                    );
                  }).toList();
                },
                icon: const Icon(Icons.filter_list_alt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsNotifierProvider);

    if (productsState.products.isEmpty) {
      if (!productsState.hasNext && !productsState.isLoading) {
        return const Center(child: Text("No products available."));
      }
      return const LinearProgressIndicator();
    }

    return Column(
      children: [
        Flexible(
          flex: 1,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(productsState.products.length, (index) {
              return ProductCard(model: productsState.products[index]
              );
            }),
          ),
        ),
      ],
    );
  }
}
