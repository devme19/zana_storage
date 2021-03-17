import 'package:zana_storage/features/data/model/invoice_model.dart';
import 'package:zana_storage/features/domain/entities/invoice_table_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class InvoiceTableModel extends InvoiceTableEntity{


    InvoiceTableModel({
        List<InvoiceModel> invoices,
        String page,
        String pageSize,
        String sortBy,
        int status,
        int total,
    }):super(
        invoices: invoices,
        page: page,
        pageSize: pageSize,
        sortBy: sortBy,
        status: status,
        total: total
    );

    factory InvoiceTableModel.fromJson(Map<String, dynamic> json) {
        return InvoiceTableModel(
            invoices: json['invoices'] != null ? (json['invoices'] as List).map((i) => InvoiceModel.fromJson(i)).toList() : null,
            page: json['page'], 
            pageSize: json['pagesize'],
            sortBy: json['sortby'],
            status: json['status'], 
            total: json['total'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['page'] = this.page;
        data['pagesize'] = this.pageSize;
        data['sortby'] = this.sortBy;
        data['status'] = this.status;
        data['total'] = this.total;
        if (this.invoices != null) {
            data['invoices'] = this.invoices.map((v) => v.toJson()).toList();
        }
        return data;
    }
}