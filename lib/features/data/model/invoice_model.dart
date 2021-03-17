import 'package:zana_storage/features/data/model/customer_model.dart';
import 'package:zana_storage/features/data/model/product_model.dart';
import 'package:zana_storage/features/domain/entities/invoice_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class InvoiceModel extends InvoiceEntity{


    InvoiceModel({
        addBy,
        cost,
        createdAt,
        customer,
        customerType,
        customerId,
        description,
        discount,
        id,
        invoiceId,
        paid,
        paidAt,
        paymentType,
        products,
        realTotal,
        realTotalp,
        status,
        storeId,
        updatedAt
    }):super(
        addBy: addBy,
        cost: cost,
        createdAt: createdAt,
        customer:customer,
        customerType:customerType,
        customerId:customerId,
        description:description,
        discount:discount,
        id:id,
        invoiceId:invoiceId,
        paid:paid,
        paidAt:paidAt,
        paymentType:paymentType,
        products:products,
        realTotal:realTotal,
        realTotalp:realTotalp,
        status:status,
        storeId:storeId,
        updatedAt:updatedAt,
    );

    factory InvoiceModel.fromJson(Map<String, dynamic> json) {
        var js = json['invoice'];
        if(js == null)
            js = json;
        return InvoiceModel(
            addBy: js['add_by'],
            cost: js['cost'],
            createdAt: js['created_at'],
            customer: js['customer'] != null ? CustomerModel.fromJson(js['customer']) : null,
            customerType: js['customer_type'],
            customerId: js['customerid'],
            description: js['description'],
            discount: js['discount'],
            id: js['id'],
            invoiceId: js['invoiceid'],
            paid: js['paid'],
            paidAt: js['paid_at'],
            paymentType: js['payment_type'],
            products: js['products'] != null ? (js['products'] as List).map((i) => ProductModel.fromJson(i)).toList() : null,
            realTotal: js['real_total'],
            realTotalp: js['real_totalp'] != null ? RealTotalp.fromJson(js['real_totalp']) : null,
            status: js['status'],
            storeId: js['storeid'],
            updatedAt: js['updated_at'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['add_by'] = this.addBy;
        data['cost'] = this.cost;
        data['created_at'] = this.createdAt;
        data['customer_type'] = this.customerType;
        data['customerid'] = this.customerId;
        data['description'] = this.description;
        data['discount'] = this.discount;
        data['id'] = this.id;
        data['invoiceid'] = this.invoiceId;
        data['paid'] = this.paid;
        data['payment_type'] = this.paymentType;
        data['real_total'] = this.realTotal;
        data['status'] = this.status;
        data['storeid'] = this.storeId;
        data['updated_at'] = this.updatedAt;
        data['paid_at'] = this.paidAt;
        data['customer'] = this.customer;
        if (this.products != null) {
            data['products'] = this.products.map((v) => v.toJson()).toList();
        }
        data['real_totalp'] = this.realTotalp;
        return data;
    }
}

class RealTotalp {
    EUR eUR;

    RealTotalp({this.eUR});

    factory RealTotalp.fromJson(Map<String, dynamic> json) {
        return RealTotalp(
            eUR: json['eUR'] != null ? EUR.fromJson(json['eUR']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.eUR != null) {
            data['eUR'] = this.eUR.toJson();
        }
        return data;
    }
}

class EUR {
    double cost;
    String symbol;
    int total;

    EUR({this.cost, this.symbol, this.total});

    factory EUR.fromJson(Map<String, dynamic> json) {
        return EUR(
            cost: json['cost'], 
            symbol: json['symbol'], 
            total: json['total'], 
        );
    }
    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cost'] = this.cost;
        data['symbol'] = this.symbol;
        data['total'] = this.total;
        return data;
    }
}