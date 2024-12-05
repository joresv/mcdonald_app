import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class CurvedCarousel extends StatefulWidget {
  final List<Widget> items;
  final int visibleItems;
  final bool infiniteScroll;
  final double scaleFactor;
  final double spacing;

  const CurvedCarousel({
    Key? key,
    required this.items,
    this.visibleItems = 3,
    this.infiniteScroll = false,
    this.scaleFactor = 0.8,
    this.spacing = 20.0,
  }) : super(key: key);

  @override
  State<CurvedCarousel> createState() => _CurvedCarouselState();
}

class _CurvedCarouselState extends State<CurvedCarousel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CarouselPhysics _carouselPhysics;
  double _offset = 0.0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _carouselPhysics = CarouselPhysics();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offset += details.primaryDelta!;
      _calculateCurrentIndex();
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0.0;
    if (velocity.abs() >= 100.0) {
      _animateToNextItem(velocity < 0);
    } else {
      _snapToNearestItem();
    }
  }

  void _calculateCurrentIndex() {
    final itemHeight = MediaQuery.of(context).size.height / widget.visibleItems;
    _currentIndex = (_offset / itemHeight).round().abs() % widget.items.length;
    if (!widget.infiniteScroll) {
      _currentIndex = _currentIndex.clamp(0, widget.items.length - 1);
    }
  }

  void _animateToNextItem(bool forward) {
    final itemHeight = MediaQuery.of(context).size.height / widget.visibleItems;
    final targetOffset = forward ? _offset - itemHeight : _offset + itemHeight;

    final simulation =
        _carouselPhysics.createSpringSimulation(_offset, targetOffset);
    _controller.animateWith(simulation);

    setState(() {
      _offset = targetOffset;
      _calculateCurrentIndex();
    });
  }

  void _snapToNearestItem() {
    final itemHeight = MediaQuery.of(context).size.height / widget.visibleItems;
    final targetOffset = ((_offset / itemHeight).round() * itemHeight);

    final simulation =
        _carouselPhysics.createSpringSimulation(_offset, targetOffset);
    _controller.animateWith(simulation);

    setState(() {
      _offset = targetOffset;
      _calculateCurrentIndex();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          painter: CurvedCarouselPainter(
            items: widget.items,
            offset: _offset,
            visibleItems: widget.visibleItems,
            scaleFactor: widget.scaleFactor,
            spacing: widget.spacing,
            infiniteScroll: widget.infiniteScroll,
          ),
          child: CarouselItemBuilder(
            items: widget.items,
            offset: _offset,
            visibleItems: widget.visibleItems,
            scaleFactor: widget.scaleFactor,
            spacing: widget.spacing,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCarouselItems() {
    final List<Widget> items = [];
    final itemHeight = MediaQuery.of(context).size.height / widget.visibleItems;

    for (int i = 0; i < widget.items.length; i++) {
      final itemOffset = _offset + (i * itemHeight);
      final scale = _calculateScale(itemOffset);
      final position = _calculatePosition(itemOffset);

      items.add(
        Positioned(
          top: position.dy,
          left: position.dx,
          child: Transform.scale(
            scale: scale,
            child: widget.items[i],
          ),
        ),
      );
    }

    return items;
  }

  double _calculateScale(double itemOffset) {
    final viewportHeight = MediaQuery.of(context).size.height;
    final normalizedOffset = (itemOffset / viewportHeight).abs();
    return 1.0 - (normalizedOffset * (1.0 - widget.scaleFactor));
  }

  Offset _calculatePosition(double itemOffset) {
    final viewportWidth = MediaQuery.of(context).size.width;
    final viewportHeight = MediaQuery.of(context).size.height;
    final normalizedOffset = (itemOffset / viewportHeight).abs();

    // Calculate curved path
    final x = viewportWidth / 2 + (sin(normalizedOffset * pi) * widget.spacing);
    final y = itemOffset;

    return Offset(x, y);
  }
}

class CarouselPhysics {
  final SpringDescription _springDescription = const SpringDescription(
    mass: 1.0,
    stiffness: 100.0,
    damping: 20.0,
  );

  SpringSimulation createSpringSimulation(double start, double end) {
    return SpringSimulation(
      _springDescription,
      start,
      end,
      0.0, // initial velocity
    );
  }
}

class CurvedCarouselPainter extends CustomPainter {
  final List<Widget> items;
  final double offset;
  final int visibleItems;
  final double scaleFactor;
  final double spacing;
  final bool infiniteScroll;

  CurvedCarouselPainter({
    required this.items,
    required this.offset,
    required this.visibleItems,
    required this.scaleFactor,
    required this.spacing,
    required this.infiniteScroll,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    path.moveTo(size.width / 2, 0);

    for (double t = 0; t <= 1.0; t += 0.01) {
      final x = size.width / 2 + sin(t * pi) * spacing;
      final y = t * size.height;
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CarouselItemBuilder extends StatelessWidget {
  final List<Widget> items;
  final double offset;
  final int visibleItems;
  final double scaleFactor;
  final double spacing;

  const CarouselItemBuilder({
    Key? key,
    required this.items,
    required this.offset,
    required this.visibleItems,
    required this.scaleFactor,
    required this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildCarouselItems(context),
    );
  }

  List<Widget> _buildCarouselItems(BuildContext context) {
    final List<Widget> itemWidgets = [];
    final itemHeight = MediaQuery.of(context).size.height / visibleItems;

    for (int i = 0; i < items.length; i++) {
      final itemOffset = offset + (i * itemHeight);
      final scale = _calculateScale(context, itemOffset);
      final position = _calculatePosition(context, itemOffset);

      itemWidgets.add(
        Positioned(
          top: position.dy,
          left: position.dx,
          child: Transform.scale(
            scale: scale,
            child: items[i],
          ),
        ),
      );
    }

    return itemWidgets;
  }

  double _calculateScale(BuildContext context, double itemOffset) {
    final viewportHeight = MediaQuery.of(context).size.height;
    final normalizedOffset = (itemOffset / viewportHeight).abs();
    return 1.0 - (normalizedOffset * (1.0 - scaleFactor));
  }

  Offset _calculatePosition(BuildContext context, double itemOffset) {
    final viewportWidth = MediaQuery.of(context).size.width;
    final viewportHeight = MediaQuery.of(context).size.height;
    final normalizedOffset = (itemOffset / viewportHeight).abs();

    final x = viewportWidth / 2 + (sin(normalizedOffset * pi) * spacing);
    final y = itemOffset;

    return Offset(x, y);
  }
}
