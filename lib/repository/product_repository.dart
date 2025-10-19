import 'package:pre_interview_task/model/product.dart';
import 'package:pre_interview_task/repository/product_remote_data_sourse_repository.dart';

abstract class ProductRepository {
  Future<ProductsResponse> getProducts();
  Future<List<Category>> getCategories();
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSourceRepository remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProductsResponse> getProducts() async =>
      await remoteDataSource.getProducts();

  @override
  Future<List<Category>> getCategories() async =>
      await remoteDataSource.getCategories();
}
