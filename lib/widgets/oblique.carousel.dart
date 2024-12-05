import 'dart:math' as math;

import 'package:flutter/material.dart';

class ObliqueCarousel extends StatefulWidget {
  final List<Widget> items;
  final double itemHeight;
  final double angleOffset;

  const ObliqueCarousel(
      {Key? key,
      required this.items,
      this.itemHeight = 200,
      this.angleOffset = 0.1})
      : super(key: key);

  @override
  _ObliqueCarouselState createState() => _ObliqueCarouselState();
}

class _ObliqueCarouselState extends State<ObliqueCarousel> {
  late double _currentIndex = 0;
  final double _itemWidth = 300;
  final double _itemHeight = 400;
  final double _angleOffset = 0.1;

  void _handleScroll(double offset) {
    setState(() {
      _currentIndex = offset / _itemWidth;
    });
  }

  double _calculateScale(int index) {
    double normalizedOffset = (_currentIndex - index).abs();
    return 1.0 - math.min(normalizedOffset, 1.0) * 0.2;
  }

  double _calculateAngle(int index) {
    double offset = _currentIndex - index;
    return offset * _angleOffset;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          _handleScroll(notification.metrics.pixels);
        }
        return false;
      },
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          double scale = _calculateScale(index);
          double angle = _calculateAngle(index);

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Ajuste la profondeur
              ..rotateY(angle * math.pi / 180),
            alignment: Alignment.center,
            child: SizedBox(
              width: _itemWidth,
              height: _itemHeight,
              child: Transform.scale(
                scale: scale,
                child: widget.items[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
