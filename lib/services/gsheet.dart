import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:monas_cart/model/product_model.dart';

const getNewInAPI =
    'https://script.google.com/macros/s/AKfycbyBjunPVxpw5zDwZEdj9ov-5IRvmUJEWhcKeqoAlSlwjYx1e8gxnRJnUYzxmciqKU33-Q/exec';

class GSheetService {
  Future<List<ProductModel>> getNewIn() async {
    http.Response data = await http.get(Uri.parse(getNewInAPI));
    dynamic jsonAppData = convert.jsonDecode(data.body);
    final List<ProductModel> productListData = [];

    for (dynamic data in jsonAppData) {
      ProductModel meetingData = ProductModel(
        id: data['id'],
        name: data['name'],
        price: data['price'] == '' ? 0 : data['price'],
        category: data['category'],
        description: data['description'],
        feedbackDate: data['feedbackDate'] != ''
            ? DateTime.parse(data['feedbackDate'])
            : null,
        images:
            data['images'].map<String>((image) => image.toString()).toList(),
      );
      productListData.add(meetingData);
    }
    return productListData;
  }
}
