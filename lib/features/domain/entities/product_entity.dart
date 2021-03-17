class ProductEntity{
  int categoryId;
  String categoryName;
  String createdAt;
  int currencyId;
  String currencyIso;
  String currencySymbol;
  String currencyTitle;
  int discount;
  int id;
  int invoiceId;
  String note;
  String price;
  int productId;
  String productName;
  int quantity;
  String realPrice;
  String tax;
  int taxId;
  String totalPrice;
  String updatedAt;
  ProductEntity({
    this.categoryId,
    this.categoryName,
    this.createdAt,
    this.currencyId,
    this.currencyIso,
    this.currencySymbol,
    this.currencyTitle,
    this.discount,
    this.id,
    this.invoiceId,
    this.note,
    this.price,
    this.productId,
    this.productName,
    this.quantity,
    this.realPrice,
    this.tax,
    this.taxId,
    this.totalPrice,
    this.updatedAt,
  });
}