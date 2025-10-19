import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pre_interview_task/const/app_base_url.dart';
import 'package:pre_interview_task/model/product.dart';
import 'package:pre_interview_task/model/product_state.dart';
import 'package:pre_interview_task/repository/product_remote_data_sourse_repository.dart';
import 'package:pre_interview_task/repository/product_repository.dart';
import 'package:pre_interview_task/provider/product.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: AppBaseUrl.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
});

final productRemoteDataSourceProvider =
    Provider<ProductRemoteDataSourceRepository>(
      (ref) => ProductRemoteDataSourceImpl(ref.watch(dioProvider)),
    );

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.watch(productRemoteDataSourceProvider));
});

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
      final repository = ref.watch(productRepositoryProvider);
      final notifier = ProductNotifier(productRepository: repository);
      notifier.loadProducts();
      notifier.loadCategories();
      return notifier;
    });

final productsProvider = Provider<List<Product>>(
  (ref) => ref.watch(productNotifierProvider).filteredProducts,
);

final categoriesProvider = Provider<List<Category>>(
  (ref) => ref.watch(productNotifierProvider).categories,
);

final selectedCategoryProvider = Provider<String?>(
  (ref) => ref.watch(productNotifierProvider).selectedCategory,
);

final isLoadingProvider = Provider<bool>(
  (ref) => ref.watch(productNotifierProvider).isLoading,
);

final errorProvider = Provider<String?>(
  (ref) => ref.watch(productNotifierProvider).error,
);
