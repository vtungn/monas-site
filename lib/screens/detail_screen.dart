// ignore: depend_on_referenced_packages
import 'dart:js' as js;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:monas_cart/screens/widgets/index.dart';

class DetailProductSreen extends StatefulWidget {
  final String productId;
  const DetailProductSreen({Key? key, required this.productId})
      : super(key: key);

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
    if ((sAmount + mAmount + lAmount) < 5) {
      telegramjs['MainButton'].callMethod('hide', []);
    } else {
      telegramjs['MainButton'].callMethod('show', []);
      telegramjs['MainButton'].callMethod('onClick', [
        () {
          telegramjs.callMethod('close', []);
        }
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appHeight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  reverse: false,
                  enlargeCenterPage: true,
                  aspectRatio: 1,
                ),
                items: [0, 1, 2].map((i) {
                  var fakeId = i + int.parse(widget.productId);
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Hero(
                              tag: 'thumbnail$fakeId',
                              child:
                                  Image.asset('assets/images/$fakeId.jpeg')));
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
                                children: const [
                                  Text(
                                    'Corduroy cap',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '170.000đ 1234567890',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, consectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elit.'),
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
