import 'package:zana_storage/features/data/model/dashboard_model.dart';

class DashboardEntity{
  int customers;
  int customers_month;
  int invoices;
  int invoices_month;
  TotalPriceToday total_price_today;
  TotalPriceYesterday total_price_yesterday;
  DashboardEntity({
    this.customers,
    this.customers_month,
    this.invoices,
    this.invoices_month,
    this.total_price_today,
    this.total_price_yesterday});
}