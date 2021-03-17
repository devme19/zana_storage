import 'package:zana_storage/features/data/model/product_model2.dart';
import 'package:zana_storage/features/domain/entities/product_table_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class ProductTableModel extends ProductTableEntity {


    ProductTableModel ({
        int page,
        int pageSize,
        List<ProductModel2> products,
        String sortBy,
        int status,
        int total,}):
            super(
            page: page,
            pageSize: pageSize,
            products: products,
            sortBy: sortBy,
            status: status,
            total: total
        )
    ;

    factory ProductTableModel.fromJson(Map<String, dynamic> json) {
        return ProductTableModel(
            page: json['page'],
            pageSize: json['pagesize'],
            products: json['products'] != null ? (json['products'] as List).map((i) => ProductModel2.fromJson(i)).toList() : null,
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
        if (this.products != null) {
            data['products'] = this.products.map((v) => v.toJson()).toList();
        }
        return data;
    }
}
