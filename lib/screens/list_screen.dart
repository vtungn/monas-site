import 'dart:js' as js;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:monas_cart/model/index.dart';
import 'package:monas_cart/screens/detail_screen.dart';
import 'package:monas_cart/services/gsheet.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  late GSheetService service;
  late js.JsObject telegramjs;
  @override
  void initState() {
    service = GSheetService();
    super.initState();
    if (kIsWeb) {
      var telegram = js.JsObject.fromBrowserObject(js.context['Telegram']);
      telegramjs = telegram['WebApp'];
      telegramjs.callMethod('expand', []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // cart order

          // search bar
          const Text(
            'Những sản phẩm mới nè',
            style: TextStyle(fontSize: 24),
          ),
          // list
          FutureBuilder<List<ProductModel>>(
              future: service.getNewIn(),
              builder: (context, listAsync) {
                if (listAsync.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text('Monas'));
                }
                if (listAsync.hasError) {
                  return const Text('Lỗi hệ thống');
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      itemCount: listAsync.data!.length,
                      itemBuilder: (context, index) {
                        var data = listAsync.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  DetailProductSreen(product: data),
                            ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Hero(
                                    tag: data.id,
                                    createRectTween: (Rect? begin, Rect? end) {
                                      return MaterialRectCenterArcTween(
                                          begin: begin, end: end);
                                    },
                                    // child: NetworkImage(data.images![0]))),
                                    child: Image.network(data.images![0])),
                              ),
                              const SizedBox(height: 8),
                              Text(data.name ?? ''),
                              const SizedBox(height: 8),
                              Text(
                                '${data.price}.000đ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              })
        ],
      ),
    ));
  }
}
