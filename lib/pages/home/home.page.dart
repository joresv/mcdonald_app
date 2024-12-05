import 'package:flutter/material.dart';
import 'package:mcdonald_app/models/product.dart';
import 'package:mcdonald_app/pages/home/components/product.component.dart';
import 'package:mcdonald_app/utils/app.colors.dart';
import 'package:mcdonald_app/utils/app.images.dart';
import 'package:mcdonald_app/widgets/svg.icon.dart';

final products = [
  Product("Milkshake", "20 Cups of different flavours", AppImages.h1),
  Product("Chicken Burger", "20 Cups of different flavours", AppImages.h2),
  Product("Chocolate Drinks", "20 Cups of different flavours", AppImages.h3),
  Product("Coffee Drinks", "20 Cups of different flavours", AppImages.h4),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Menu",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 30,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgIcon(
              AppImages.shoppingBag,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ProductComponent(products[index]));
        },
      ),
    );
  }
}
