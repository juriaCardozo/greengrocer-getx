class ItemModel {
  String imageURL;
  String itemName;
  String unit;
  String description;
  double price;

  ItemModel({
    required this.itemName,
    required this.imageURL,
    required this.description,
    required this.unit,
    required this.price,
  });
}
