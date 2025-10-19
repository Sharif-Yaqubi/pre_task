import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pre_interview_task/model/product.dart';
import 'package:pre_interview_task/model/product_state.dart';
import 'package:pre_interview_task/repository/product_repository.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductRepository productRepository;

  ProductNotifier({required this.productRepository})
    : super(const ProductState());

  Future<void> loadProducts() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final productsResponse = await productRepository.getProducts();

      state = state.copyWith(
        products: productsResponse.products,
        isLoading: false,
      );
      applyFilters();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load products: $e',
      );
    }
  }

  Future<void> loadCategories() async {
    try {
      final categories = await productRepository.getCategories();
      state = state.copyWith(categories: categories);
    } catch (e) {
      state = state.copyWith(error: 'Failed to load categories: $e');
    }
  }

  void setCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
    applyFilters();
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    applyFilters();
  }

  void addLocalProduct(Product product) {
    final updatedLocalProducts = [...state.localProducts, product];
    state = state.copyWith(localProducts: updatedLocalProducts);
    applyFilters();
  }

  void removeLocalProduct(int id) {
    final updatedLocalProducts =
        state.localProducts.where((p) => p.id != id).toList();
    state = state.copyWith(localProducts: updatedLocalProducts);
    applyFilters();
  }

  void clearFilters() {
    state = state.copyWith(
      selectedCategory: null,
      priceRange: const PriceRange(),
      searchQuery: '',
    );
    applyFilters();
  }

  void applyFilerForRate() {
    final filterAllProdcut = state.allProducts;

    final filterProduct =
        filterAllProdcut
            .where(
              (prodcuts) =>
                  prodcuts.rating >= state.priceRating.min &&
                  prodcuts.rating <= state.priceRating.max,
            )
            .toList();
    state = state.copyWith(filteredProducts: filterProduct);
  }

  void clearNewItem({required int id}) {
    final products = state.allProducts;
    products.removeWhere((ids) => ids.id == id);
    state = state.copyWith(products: products);

    applyFilters();
  }

  void applyFilters() {
    var filteredProducts = state.allProducts;

    if (state.selectedCategory != null) {
      filteredProducts =
          filteredProducts
              .where((product) => product.category == state.selectedCategory)
              .toList();
    }

    filteredProducts =
        filteredProducts
            .where(
              (product) =>
                  product.price >= state.priceRange.min &&
                  product.price <= state.priceRange.max,
            )
            .toList();

    if (state.searchQuery.isNotEmpty) {
      filteredProducts =
          filteredProducts
              .where(
                (product) =>
                    product.title.toLowerCase().contains(
                      state.searchQuery.toLowerCase(),
                    ) ||
                    product.brand.toLowerCase().contains(
                      state.searchQuery.toLowerCase(),
                    ) ||
                    product.category.toLowerCase().contains(
                      state.searchQuery.toLowerCase(),
                    ),
              )
              .toList();
    }

    state = state.copyWith(filteredProducts: filteredProducts);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
