import 'package:flutter_batch_9_project/blocs/sales_invoice/sales_invoice_state.dart';
import 'package:flutter_batch_9_project/data/remote_data/sales_remote_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesInvoiceCubit extends Cubit<SalesInvoiceState> {

  late final SalesRemoteData salesRemoteData;

  SalesInvoiceCubit(
    this.salesRemoteData
  ) : super(const SalesInvoiceState());

  Future<void> loadData() async {
    emit(state.copyWith(loading: true));
    
    try {
      final response = await salesRemoteData.getSalesInvoices(
        page: 1,
        size: 1000
      );
      emit(state.copyWith(
        loading: false,
        salesInvoices: response
      ));
    } catch (e) {
      print('Error: $e');
      emit(state.copyWith(
        loading: false
      ));
    }
  }

}