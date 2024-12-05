import 'package:flutter/material.dart';
import 'package:mcdonald_app/utils/app.images.dart';
import 'package:mcdonald_app/widgets/curved.carousel.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurvedCarousel(
        items: [
          _buildCarouselItem(
            'Title',
            '25.0',
          ),
          _buildCarouselItem(
            'Title',
            '25.0',
          ),
          _buildCarouselItem(
            'Title',
            '25.0',
          ),
        ],
      ),
    );
  }
}

Widget _buildCarouselItem(String title, String price) {
  return Container(
    width: 300,
    height: 400,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Image.asset(
            AppImages.glass1,
            fit: BoxFit.contain,
          ),
        ),
      ],
    ),
  );
}
