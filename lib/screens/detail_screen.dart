// ignore: depend_on_referenced_packages
import 'dart:convert';
import 'dart:js' as js;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:monas_cart/model/index.dart';
import 'package:monas_cart/model/order_model.dart';
import 'package:monas_cart/screens/widgets/index.dart';
import 'package:monas_cart/services/monas_service.dart';

class DetailProductSreen extends StatefulWidget {
  final ProductModel product;
  const DetailProductSreen({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailProductSreen> createState() => _DetailProductSreenState();
}

class _DetailProductSreenState extends State<DetailProductSreen> {
  int sAmount = 0;
  int mAmount = 0;
  int lAmount = 0;
  int xlAmount = 0;
  late js.JsObject telegramjs;
  @override
  void initState() {
    // window.Telegram.WebApp
    if (kIsWeb) {
      telegramjs = js.JsObject.fromBrowserObject(js.context['Telegram']);
      telegramjs = telegramjs['WebApp'];
      telegramjs['BackButton'].callMethod('hide', []);
    }
    super.initState();
  }

  void shouldShowAddtoCart() {
    if ((sAmount + mAmount + lAmount) <= 5) {
      telegramjs['MainButton'].callMethod('hide', []);
    } else {
      telegramjs['MainButton'].callMethod('show', []);
      telegramjs['MainButton'].callMethod('onClick', [
        () async {
          String initData = telegramjs['initData'];
          var data = initData.split('&');
          var userData =
              data.firstWhere((element) => element.startsWith('user'));
          var userDecode = Uri.decodeQueryComponent(userData);
          var userJson = jsonDecode(userDecode.substring(5));
          if (await submitToMonas(userJson)) {
            telegramjs.callMethod('close', []);
          } else {
            telegramjs.callMethod('showAlert', ['Lỗi bot']);
          }
        }
      ]);
    }
  }

  Future<bool> submitToMonas(dynamic user) async {
    var monasService = MonasService();
    OrderModel order = OrderModel(items: [
      OrderItemModel(product: widget.product, amountOfSize: {
        's': sAmount,
        'm': mAmount,
        'l': lAmount,
        'xl': xlAmount,
      })
    ]);
    return monasService.sendToBotMonas(user, order);
  }

  @override
  Widget build(BuildContext context) {
    var appHeight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    var product = widget.product;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  // viewportFraction: 1,
                  enableInfiniteScroll: false,
                  reverse: false,
                  // enlargeCenterPage: true,
                  aspectRatio: 1,
                ),
                items: product.images!.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Hero(
                              tag:
                                  product.images![0] == image ? product.id : '',
                              child: Image.network(image)));
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                height: appHeight / 1.7,
                width: appwidth,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${product.price}.000đ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(product.description ?? ''),
                              const SizedBox(height: 8),
                              const Text(
                                'Size',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 16,
                                        child: Text(
                                          'S',
                                          style: TextStyle(
                                              color: sAmount == 0
                                                  ? Colors.black45
                                                  : Colors.blue[900],
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      NumberCounter(
                                        onChanged: (number) {
                                          setState(() {
                                            sAmount = number;
                                          });
                                          shouldShowAddtoCart();
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 16,
                                        child: Text(
                                          'M',
                                          style: TextStyle(
                                              color: mAmount == 0
                                                  ? Colors.black45
                                                  : Colors.blue[900],
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      NumberCounter(
                                        onChanged: (number) {
                                          setState(() {
                                            mAmount = number;
                                          });
                                          shouldShowAddtoCart();
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 16,
                                        child: Text(
                                          'L',
                                          style: TextStyle(
                                              color: lAmount == 0
                                                  ? Colors.black45
                                                  : Colors.blue[900],
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      NumberCounter(
                                        onChanged: (number) {
                                          setState(() {
                                            lAmount = number;
                                          });
                                          shouldShowAddtoCart();
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  if ((sAmount + mAmount + lAmount) <= 5)
                                    const Text(
                                      '*Lưu ý: vui lòng đặt từ 5 sản phẩm',
                                      style: TextStyle(color: Colors.black),
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       var res = await submitToMonas({
                      //         'id': '448931642',
                      //         'first_name': 'tung',
                      //         'last_name': 'lastName',
                      //         'username': 'userName',
                      //         'is_premium': true,
                      //       });
                      //       print('done: $res');
                      //     },
                      //     child: const Text('add cart'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
