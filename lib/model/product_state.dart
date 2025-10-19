import 'package:pre_interview_task/model/product.dart';

class ProductState {
  final List<Product> products;
  final List<Product> filteredProducts;
  final List<Category> categories;
  final String? selectedCategory;
  final PriceRange priceRange;
  final PriceRating priceRating;
  final String searchQuery;
  final List<Product> localProducts;
  final bool isLoading;
  final String? error;

  const ProductState({
    this.products = const [],
    this.filteredProducts = const [],
    this.categories = const [],
    this.priceRating= const PriceRating(),
    this.selectedCategory,
    this.priceRange = const PriceRange(),
    this.searchQuery = '',
    this.localProducts = const [],
    this.isLoading = false,
    this.error,
  });

  ProductState copyWith({
    List<Product>? products,
    List<Product>? filteredProducts,
    List<Category>? categories,
    String? selectedCategory,
    PriceRange? priceRange,
    String? searchQuery,
    List<Product>? localProducts,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      priceRange: priceRange ?? this.priceRange,
      searchQuery: searchQuery ?? this.searchQuery,
      localProducts: localProducts ?? this.localProducts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  // Get all products (API + local)
  List<Product> get allProducts => [...products, ...localProducts];
}
