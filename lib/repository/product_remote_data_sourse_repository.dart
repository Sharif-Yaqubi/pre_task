import 'package:dio/dio.dart';
import 'package:pre_interview_task/const/app_base_url.dart';
import 'package:pre_interview_task/model/product.dart';

abstract class ProductRemoteDataSourceRepository {
  Future<ProductsResponse> getProducts();
  Future<List<Category>> getCategories();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSourceRepository {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<ProductsResponse> getProducts() async {
    try {
      final response = await dio.get(
        '${AppBaseUrl.baseUrl}${AppBaseUrl.productsEndpoint}',
      );
      return ProductsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load products: ${e.message}');
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await dio.get(
        '${AppBaseUrl.baseUrl}${AppBaseUrl.categoriesEndpoint}',
      );
      return (response.data as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to load categories: ${e.message}');
    }
  }
}
