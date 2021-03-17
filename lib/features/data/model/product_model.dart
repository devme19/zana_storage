import 'package:zana_storage/features/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class ProductModel extends ProductEntity{


    ProductModel({
        int categoryId,
        String categoryName,
        String createdAt,
        int currencyId,
        String currencyIso,
        String currencySymbol,
        String currencyTitle,
        int discount,
        int id,
        int invoiceId,
        String note,
        String price,
        int productId,
        String productName,
        int quantity,
        String realPrice,
        String tax,
        int taxId,
        String totalPrice,
        String updatedAt,
    }
        ):super(
        categoryId:categoryId,
        categoryName:categoryName,
        createdAt:createdAt,
        currencyId:currencyId,
        currencyIso:currencyIso,
        currencySymbol:currencySymbol,
        currencyTitle:currencyTitle,
        discount:discount,
        id:id,
        invoiceId:invoiceId,
        note:note,
        price:price,
        productId:productId,
        productName:productName,
        quantity:quantity,
        realPrice:realPrice,
        tax:tax,
        taxId:taxId,
        totalPrice:totalPrice,
        updatedAt:updatedAt,

    );

    factory ProductModel.fromJson(Map<String, dynamic> json) {
        return ProductModel(
            categoryId: json['category_id'],
            categoryName: json['category_name'],
            createdAt: json['created_at'],
            currencyId: json['currency_id'],
            currencyIso: json['currency_iso'],
            currencySymbol: json['currency_symbol'],
            currencyTitle: json['currency_title'],
            discount: json['discount'], 
            id: json['id'], 
            invoiceId: json['invoice_id'],
            note: json['note'] ,
            price: json['price'], 
            productId: json['product_id'],
            productName: json['product_name'],
            quantity: json['quantity'], 
            realPrice: json['real_price'],
            tax: json['tax'], 
            taxId: json['tax_id'],
            totalPrice: json['total_price'],
            updatedAt: json['updated_at'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category_id'] = this.categoryId;
        data['category_name'] = this.categoryName;
        data['created_at'] = this.createdAt;
        data['currency_id'] = this.currencyId;
        data['currency_iso'] = this.currencyIso;
        data['currency_symbol'] = this.currencySymbol;
        data['currency_title'] = this.currencyTitle;
        data['discount'] = this.discount;
        data['id'] = this.id;
        data['invoice_id'] = this.invoiceId;
        data['price'] = this.price;
        data['product_id'] = this.productId;
        data['product_name'] = this.productName;
        data['quantity'] = this.quantity;
        data['real_price'] = this.realPrice;
        data['tax'] = this.tax;
        data['tax_id'] = this.taxId;
        data['total_price'] = this.totalPrice;
        data['updated_at'] = this.updatedAt;
        data['note'] = this.note;
        return data;
    }
}