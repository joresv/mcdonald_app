import 'package:flutter/material.dart';
import 'package:mcdonald_app/models/product.dart';
import 'package:mcdonald_app/pages/carousel/carousel.page.dart';
import 'package:mcdonald_app/utils/app.colors.dart';
import 'package:mcdonald_app/utils/app.images.dart';
import 'package:mcdonald_app/widgets/svg.icon.dart';

class ProductComponent extends StatelessWidget {
  const ProductComponent(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CarouselPage(),
        ));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 145,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(.1),
                  blurRadius: 10,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        product.name,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontSize: 22,
                                ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(product.description),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: SvgIcon(AppImages.arrowRight))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: -50,
            child: Image.asset(
              product.image,
              height: 200,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
