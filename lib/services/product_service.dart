import 'package:crud_app/models/product_response.dart';
import 'package:dio/dio.dart';

class ProductService {
  final String baseUrl = 'https://crudcrud.com/api/3e3254019d6b4a33aca54c1e4a704832/products';

  Future<List<dynamic>> fetchProducts() async {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  Future<dynamic> detailProduct(String id) async {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      final response = await dio.get('$baseUrl/$id');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  Future<String> addProduct(Map<String, dynamic> datareq) async {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());

    try {
      final response = await dio.post(baseUrl, data: datareq);
      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  Future<void> updateProduct(Map<String, dynamic> product) async {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());

    try {
      final response = await dio.put('$baseUrl/${product['_id']}', data: product);
      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());

    try {
      final response = await dio.delete('$baseUrl/$productId');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
