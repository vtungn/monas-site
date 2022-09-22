import 'package:monas_cart/model/index.dart';

class OrderItemModel {
  ProductModel product;
  Map<String, int> amountOfSize;

  OrderItemModel({
    required this.product,
    required this.amountOfSize,
  });

  Map<String, dynamic> get toJson {
    return {
      'productId': product.id,
      ...amountOfSize,
    };
  }
}

class OrderModel {
  List<OrderItemModel> items;
  OrderModel({
    required this.items,
  });

  List<Map> get toJson {
    return items.map((e) => e.toJson).toList();
  }
}
