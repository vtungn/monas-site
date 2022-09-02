import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DetailProductSreen extends StatefulWidget {
  final String productId;
  const DetailProductSreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<DetailProductSreen> createState() => _DetailProductSreenState();
}

class _DetailProductSreenState extends State<DetailProductSreen> {
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
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, consectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elitconsectetur adipiscing elit. Sed ac egestas elit. Vestibulum blandit, arcu vel lacinia tincidunt, augue mauris suscipit sem, eget feugiat justo sapien ut magna. Morbi condimentum, nisi dignissim maximus efficitur, ex ex posuere ante, in tristique nunc felis id mauris. Phasellus mattis nisl eget venenatis commodo. Maecenas sollicitudin posuere velit, at aliquam sem placerat dictum. Curabitur ut auctor ante. Curabitur quis dolor pharetra, feugiat nunc tempor, dignissim quam. Maecenas rhoncus, orci at venenatis iaculis, lorem enim suscipit lorem, ut pellentesque ex velit quis tellus. In non ipsum sit amet tellus sodales ultricies et id mauris..'),
                              const SizedBox(height: 8),
                              const Text(
                                'Size',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.black12,
                                        foregroundColor: Colors.black,
                                        child: Text('S'),
                                      ),
                                      const SizedBox(width: 16),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.remove)),
                                      SizedBox(
                                          width: 50,
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            // decoration: inputNumberBorder(),
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      IconButton(
                                        highlightColor: Colors.black12,
                                        onPressed: () {},
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.black12,
                                        foregroundColor: Colors.black,
                                        child: Text('M'),
                                      ),
                                      const SizedBox(width: 16),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.remove)),
                                      SizedBox(
                                          width: 50,
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            // decoration: inputNumberBorder(),
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      OutlinedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add),
                                        label: Text(''),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const CircleAvatar(
                                    child: Text('L'),
                                    backgroundColor: Colors.black12,
                                    foregroundColor: Colors.black,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: appwidth,
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Add to cart')),
                      )
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
