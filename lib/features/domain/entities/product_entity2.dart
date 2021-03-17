class ProductEntity2{
  int id;
  String title;
  String qrCode;
  String image;
  String category;
  String sku;
  String price;
  int quantity;
  String symbol;
  bool isExpanded = false;
  ProductEntity2({
    this.id,
    this.title,
    this.qrCode,
    this.image,
    this.category,
    this.sku,
    this.price,
    this.quantity,
    this.symbol
  });
}