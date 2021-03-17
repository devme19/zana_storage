

import 'package:zana_storage/features/data/model/product_model2.dart';

class ProductTableEntity {
    int page;
    int pageSize;
    List<ProductModel2> products;
    String sortBy;
    int status;
    int total;

    ProductTableEntity({this.page, this.pageSize, this.products, this.sortBy, this.status, this.total});

    factory ProductTableEntity.fromJson(Map<String, dynamic> json) {
        return ProductTableEntity(
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