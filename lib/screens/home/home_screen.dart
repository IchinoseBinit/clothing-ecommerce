import 'package:clothing_ecommerce/data/app_urls.dart';
import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:clothing_ecommerce/screens/product_detail/product_detail_screen.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String productDesc =
    "Flowy,Comfy Fabric in Medium Weight much Heavier than Normal Chiffon,Antistatic. Fashion Vintage HIGH WAIST Culottes Loose Wide Leg Flattering Pants,Zip Closure with Hook and Eye,Back Elastic Real Waistband with Belt Loops,Front Pleats ,Back Darts,Side Slant Pockets";

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  // List category=lis
  List<ProductModel> productList = List.generate(
      10,
      (index) => ProductModel(
          id: 1,
          name: "Demin Jeans",
          description: productDesc,
          price: 2000,
          image: AppUrl.staticImage,
          category: 1,
          quantity: 1,
          createdAt: DateTime.now().toString(),
          updatedAt: DateTime.now().toString()));

  List<String> categoryList = [
    "For Women",
    "For Men",
    "Kids",
    "Shirts Collection",
    "Pants Collection",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('App Bar!'),
      //   flexibleSpace: Image(
      //     image: AssetImage(appbarBgImage),
      //     fit: BoxFit.cover,
      //   ),
      //   backgroundColor: Colors.transparent,
      //   toolbarHeight: 200,
      //   automaticallyImplyLeading: false,
      //   // disableLeading: true,
      // ),
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.asset(
                    appbarBgImage,
                    fit: BoxFit.cover,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSizes.paddingLg * 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingLg),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Center(
                              child: Text(
                                "Welcome".toUpperCase(),
                                style: smallText.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "Niraj",
                              style: bodyText.copyWith(
                                color: AppColors.textDarkColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // EachAppbarButton(iconData: Icons.menu_outlined),
                        const EachAppbarButton(
                            iconData: Icons.shopping_bag_outlined),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.paddingLg * 2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: AppSizes.paddingLg),
                    width: .30.sh,
                    child: Text(
                      "Find the best cloths for you",
                      style: bigTitleText.copyWith(
                          height: 0.95,
                          fontWeight: FontWeight.bold,
                          fontSize: 26.sp),
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.paddingLg * 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSizes.paddingLg),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: categoryList
                              .map((e) => EachCategoryItem(label: e))
                              .toList()),
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.paddingLg * 1.2,
                  ),
                  ScrollConfiguration(
                    behavior: MyBehaviour(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.r),
                          topRight: Radius.circular(32.r),
                        ),
                        color: AppColors.backgroundColor,
                      ),
                      padding: const EdgeInsets.only(
                          left: AppSizes.paddingLg,
                          right: AppSizes.paddingLg,
                          top: AppSizes.paddingLg * 2),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.65,
                            crossAxisCount: 2,
                            crossAxisSpacing: AppSizes.paddingLg,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return ProductItem(product: productList[index]);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: add going to detail logic as named route
        navigate(context, ProductDetailScreen(product: product));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: AppSizes.padding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: bodyText.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: AppSizes.padding / 1.7,
                  ),
                  Text(
                    "Rs.${product.price}",
                    style: subTitleText.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  //TODO: add to cart logic
                },
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.padding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: AppColors.iconBtnBgColor,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class EachAppbarButton extends StatelessWidget {
  final IconData iconData;
  const EachAppbarButton({
    super.key,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: add to cart logic
      },
      child: Container(
        padding: const EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.greyColor,
        ),
        child: Icon(
          iconData,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}

class EachCategoryItem extends StatelessWidget {
  final String label;
  const EachCategoryItem({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: AppSizes.paddingLg / 1.6),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingLg, vertical: AppSizes.padding * 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius * 4),
        color: AppColors.lightPrimaryColor,
      ),
      child: Text(label),
    );
  }
}
