import 'package:zana_storage/features/data/model/customer_model.dart';
import 'package:zana_storage/features/domain/entities/customer_table_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class CustomerTableModel extends CustomerTableEntity{

    CustomerTableModel({
      List<CustomerModel> customers,
      int page,
      int pageSize,
      String sortBy,
      int status,
      int total,
    }):super(
      customers: customers,
      page: page,
      pageSize: pageSize,
      sortBy: sortBy,
      status: status,
      total: total
    );
    factory CustomerTableModel.fromJson(Map<String, dynamic> json) {
        return CustomerTableModel(
            customers: json['customers'] != null ? (json['customers'] as List).map((i) => CustomerModel.fromJson(i)).toList() : null,
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
        if (this.customers != null) {
            data['customers'] = this.customers.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

// class Customer {
//     int add_by;
//     String address;
//     String created_at;
//     Object deleted_at;
//     String family;
//     int id;
//     String mobile;
//     String name;
//     String phone;
//     String postal_code;
//     int store_id;
//     String updated_at;
//
//     Customer({this.add_by, this.address, this.created_at, this.deleted_at, this.family, this.id, this.mobile, this.name, this.phone, this.postal_code, this.store_id, this.updated_at});
//
//     factory Customer.fromJson(Map<String, dynamic> json) {
//         return Customer(
//             add_by: json['add_by'],
//             address: json['address'],
//             created_at: json['created_at'],
//             deleted_at: json['deleted_at'],
//             family: json['family'],
//             id: json['id'],
//             mobile: json['mobile'],
//             name: json['name'],
//             phone: json['phone'],
//             postal_code: json['postal_code'],
//             store_id: json['store_id'],
//             updated_at: json['updated_at'],
//         );
//     }
//
//     Map<String, dynamic> toJson() {
//         final Map<String, dynamic> data = new Map<String, dynamic>();
//         data['add_by'] = this.add_by;
//         data['address'] = this.address;
//         data['created_at'] = this.created_at;
//         data['family'] = this.family;
//         data['id'] = this.id;
//         data['mobile'] = this.mobile;
//         data['name'] = this.name;
//         data['phone'] = this.phone;
//         data['postal_code'] = this.postal_code;
//         data['store_id'] = this.store_id;
//         data['updated_at'] = this.updated_at;
//         data['deleted_at'] = this.created_at;
//         return data;
//     }
// }