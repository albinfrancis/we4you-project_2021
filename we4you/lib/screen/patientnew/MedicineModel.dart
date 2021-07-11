class Product {
  String id;
  String price;
  String name;
  String img;
  int qty;

  Product({this.id, this.price, this.name, this.img, this.qty});

  Product.fromMap(Map snapshot, String id, int qty)
      : id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['medicinename'] ?? '',
        img = snapshot['image'] ?? '',
        qty = qty ?? '';

  toJson() {
    return {
      "id": id,
      "price": price,
      "medicinename": name,
      "image": img,
      "qty": qty,
    };
  }
}
