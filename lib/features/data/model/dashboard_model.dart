import 'package:zana_storage/features/domain/entities/dashboard_entity.dart';

class DashboardModel extends DashboardEntity{


    DashboardModel({
      int customers,
      int customers_month,
      int invoices,
      int invoices_month,
      TotalPriceToday total_price_today,
      TotalPriceYesterday total_price_yesterday,
    }):super(
      invoices: invoices,
      customers: customers,
      customers_month: customers_month,
      invoices_month: invoices_month,
      total_price_today: total_price_today,
      total_price_yesterday: total_price_yesterday
    );

    factory DashboardModel.fromJson(Map<String, dynamic> json) {
        json = json["data"];
        return DashboardModel(
            customers: json['customers'], 
            customers_month: json['customers_month'], 
            invoices: json['invoices'], 
            invoices_month: json['invoices_month'], 
            total_price_today: TotalPriceToday.fromJson(json['total_price_today']),
            total_price_yesterday: TotalPriceYesterday.fromJson(json['total_price_yesterday']),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['customers'] = this.customers;
        data['customers_month'] = this.customers_month;
        data['invoices'] = this.invoices;
        data['invoices_month'] = this.invoices_month;
        if (this.total_price_today != null) {
            data['total_price_today'] = this.total_price_today.toJson();
        }
        if (this.total_price_yesterday != null) {
            data['total_price_yesterday'] = this.total_price_yesterday.toJson();
        }
        return data;
    }
}

class TotalPriceToday {
    int aED;
    int eUR;
    int uSD;

    TotalPriceToday({this.aED, this.eUR, this.uSD});

    factory TotalPriceToday.fromJson(Map<String, dynamic> json) {
        return TotalPriceToday(
            aED: json['aED'], 
            eUR: json['eUR'], 
            uSD: json['uSD'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['aED'] = this.aED;
        data['eUR'] = this.eUR;
        data['uSD'] = this.uSD;
        return data;
    }
}

class TotalPriceYesterday {
    int aED;
    double eUR;
    int uSD;

    TotalPriceYesterday({this.aED, this.eUR, this.uSD});

    factory TotalPriceYesterday.fromJson(Map<String, dynamic> json) {
        return TotalPriceYesterday(
            aED: json['aED'], 
            eUR: json['eUR'], 
            uSD: json['uSD'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['aED'] = this.aED;
        data['eUR'] = this.eUR;
        data['uSD'] = this.uSD;
        return data;
    }
}