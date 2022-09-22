import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:monas_cart/model/order_model.dart';

const bothostAPI = 'https://nodered.monas.fashion';

class MonasService {
  Future<bool> sendToBotMonas(
    dynamic user,
    OrderModel order,
  ) async {
    try {
      var body = {
        'user': user,
        'order': order.toJson,
      };
      var bodyEncode = jsonEncode(body);
      await http.post(Uri.parse('$bothostAPI/newOrderWeb'), body: bodyEncode);
      return true;
    } catch (e) {
      return false;
    }
  }
}
