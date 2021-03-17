import 'package:zana_storage/features/domain/entities/init_entity.dart';

class InitModel extends InitEntity{
    InitModel({
      List<Option> options,
      int status,
    }):super(
      options: options,
      status: status
    );

    factory InitModel.fromJson(Map<String, dynamic> json) {
        return InitModel(
            options: json['options'] != null ? (json['options'] as List).map((i) => Option.fromJson(i)).toList() : null, 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['status'] = this.status;
        if (this.options != null) {
            data['options'] = this.options.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Option {
    List<Category> categories;
    List<Currency> currencies;
    List<InvStatuse> inv_statuses;
    List<PaymentType> payment_types;
    List<Taxe> taxes;

    Option({this.categories, this.currencies, this.inv_statuses, this.payment_types, this.taxes});

    factory Option.fromJson(Map<String, dynamic> json) {
        return Option(
            categories: json['categories'] != null ? (json['categories'] as List).map((i) => Category.fromJson(i)).toList() : null, 
            currencies: json['currencies'] != null ? (json['currencies'] as List).map((i) => Currency.fromJson(i)).toList() : null, 
            inv_statuses: json['inv_statuses'] != null ? (json['inv_statuses'] as List).map((i) => InvStatuse.fromJson(i)).toList() : null, 
            payment_types: json['payment_types'] != null ? (json['payment_types'] as List).map((i) => PaymentType.fromJson(i)).toList() : null, 
            taxes: json['taxes'] != null ? (json['taxes'] as List).map((i) => Taxe.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.categories != null) {
            data['categories'] = this.categories.map((v) => v.toJson()).toList();
        }
        if (this.currencies != null) {
            data['currencies'] = this.currencies.map((v) => v.toJson()).toList();
        }
        if (this.inv_statuses != null) {
            data['inv_statuses'] = this.inv_statuses.map((v) => v.toJson()).toList();
        }
        if (this.payment_types != null) {
            data['payment_types'] = this.payment_types.map((v) => v.toJson()).toList();
        }
        if (this.taxes != null) {
            data['taxes'] = this.taxes.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Currency {
    String created_at;
    int id;
    String iso_code;
    String symbol;
    String title;
    String updated_at;

    Currency({this.created_at, this.id, this.iso_code, this.symbol, this.title, this.updated_at});

    factory Currency.fromJson(Map<String, dynamic> json) {
        return Currency(
            created_at: json['created_at'] ,
            id: json['id'], 
            iso_code: json['iso_code'], 
            symbol: json['symbol'], 
            title: json['title'], 
            updated_at: json['updated_at'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['iso_code'] = this.iso_code;
        data['symbol'] = this.symbol;
        data['title'] = this.title;
        data['created_at'] = this.created_at;
        data['updated_at'] = this.updated_at;
        return data;
    }
}

class Category {
    int add_by;
    String created_at;
    String icon;
    int id;
    Object parentid;
    int storeid;
    String title;
    String updated_at;

    Category({this.add_by, this.created_at, this.icon, this.id, this.parentid, this.storeid, this.title, this.updated_at});

    factory Category.fromJson(Map<String, dynamic> json) {
        return Category(
            add_by: json['add_by'], 
            created_at: json['created_at'], 
            icon: json['icon'],
            id: json['id'], 
            parentid: json['parentid'],
            storeid: json['storeid'], 
            title: json['title'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['add_by'] = this.add_by;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['storeid'] = this.storeid;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        data['icon'] = this.icon;
        data['parentid'] = this.parentid;
        return data;
    }
}

class PaymentType {
    int active;
    String create_at;
    int id;
    String title;
    String updated_at;

    PaymentType({this.active, this.create_at, this.id, this.title, this.updated_at});

    factory PaymentType.fromJson(Map<String, dynamic> json) {
        return PaymentType(
            active: json['active'], 
            create_at: json['create_at'], 
            id: json['id'], 
            title: json['title'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['active'] = this.active;
        data['create_at'] = this.create_at;
        data['id'] = this.id;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        return data;
    }
}

class InvStatuse {
    int active;
    String created_at;
    int id;
    String title;
    String updated_at;

    InvStatuse({this.active, this.created_at, this.id, this.title, this.updated_at});

    factory InvStatuse.fromJson(Map<String, dynamic> json) {
        return InvStatuse(
            active: json['active'], 
            created_at: json['created_at'], 
            id: json['id'], 
            title: json['title'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['active'] = this.active;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        return data;
    }
}

class Taxe {
    int active;
    String created_at;
    int id;
    int storeid;
    int tax;
    String title;
    String updated_at;

    Taxe({this.active, this.created_at, this.id, this.storeid, this.tax, this.title, this.updated_at});

    factory Taxe.fromJson(Map<String, dynamic> json) {
        return Taxe(
            active: json['active'], 
            created_at: json['created_at'], 
            id: json['id'], 
            storeid: json['storeid'], 
            tax: json['tax'], 
            title: json['title'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['active'] = this.active;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['storeid'] = this.storeid;
        data['tax'] = this.tax;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        return data;
    }
}