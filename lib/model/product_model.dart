class ProductModel {
  String id;
  String? name;
  int? price;
  String? category;
  String? description;
  DateTime? feedbackDate;
  List<String>? images;
  ProductModel({
    required this.id,
    this.name,
    this.price,
    this.category,
    this.description,
    this.feedbackDate,
    this.images,
  });
}
