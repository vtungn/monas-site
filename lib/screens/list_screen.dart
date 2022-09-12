import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:monas_cart/screens/detail_screen.dart';
import 'package:monas_cart/services/gsheet.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  late GSheetService service;

  @override
  void initState() {
    service = GSheetService();
    super.initState();
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MasonryGridView.count(
                physics: const PageScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            DetailProductSreen(productId: '$index'),
                      ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Hero(
                              tag: 'thumbnail$index',
                              createRectTween: (Rect? begin, Rect? end) {
                                return MaterialRectCenterArcTween(
                                    begin: begin, end: end);
                              },
                              child: Image.asset('assets/images/$index.jpeg')),
                        ),
                        const SizedBox(height: 8),
                        const Text('Cotton sweatshirt'),
                        const SizedBox(height: 8),
                        const Text(
                          '170.000đ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
