import 'package:flutter/material.dart';
import 'package:mcdonald_app/widgets/curved.carousel.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurvedCarousel(
        items: [
          Container(
            color: Colors.red,
            child: Text('Item 1'),
          ),
          Container(
            color: Colors.green,
            child: Text('Item 2'),
          ),
          Container(
            color: Colors.yellow,
            child: Text('Item 3'),
          ),
        ],
      ),
    );
  }
}
