import 'package:flutter_batch_9_project/data/remote_data/network_service/network_service.dart';
import 'package:flutter_batch_9_project/models/sales_model.dart';

import '../../models/order_model.dart';

abstract class SalesRemoteData {
  Future<List<SalesInvoice>> getSalesInvoices({
    int? page,
    int? size,
  });

  Future<void> postCreateSales(OrderModel data);

}

class SalesRemoteDataImpl implements SalesRemoteData {
  final NetworkService _networkService;

  SalesRemoteDataImpl(this._networkService);

  @override
  Future<List<SalesInvoice>> getSalesInvoices({
    int? page,
    int? size,
  }) async {
    try {
      final response = await _networkService.get(
        url: '/api/sales/list',
        queryParameters: {
          'page': page ?? 1,
          'size': size ?? 10,
        },
      );

      return (response.data['data']['data'] as List)
          .map((e) => SalesInvoice.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch sales invoices: $e');
    }
  }

  @override
  Future<void> postCreateSales(OrderModel data) async {
    try {
      await _networkService.post(
        url: '/api/sales/create',
        data: data.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to create sales invoice: $e');
    }
  }
}