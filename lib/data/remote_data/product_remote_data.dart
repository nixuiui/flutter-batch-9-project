import 'package:flutter_batch_9_project/data/remote_data/network_service/network_service.dart';
import 'package:flutter_batch_9_project/models/product_model.dart';

abstract class ProductRemoteData {
  Future<List<Product>> getProduct({
    int? page,
    int? size,
  });
}

class ProductRemoteDataImpl implements ProductRemoteData {
  final NetworkService _networkService;

  ProductRemoteDataImpl(this._networkService);

  @override
  Future<List<Product>> getProduct({
    int? page,
    int? size,
  }) async {
    try {
      final response = await _networkService.get(
        url: '/api/product/list',
        queryParameters: {
          'page': page ?? 1,
          'size': size ?? 10,
        },
      );

      return (response.data['data']['data'] as List).map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}