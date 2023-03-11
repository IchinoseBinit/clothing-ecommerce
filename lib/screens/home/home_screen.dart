import 'package:clothing_ecommerce/data/app_urls.dart';
import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // List category=lis
  List<String> images = [
    AppUrl.staticImage,
    AppUrl.staticImage,
    AppUrl.staticImage,
    AppUrl.staticImage,
    AppUrl.staticImage,
    AppUrl.staticImage,
    AppUrl.staticImage,
    AppUrl.staticImage,
    AppUrl.staticImage,
  ];

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
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Image.asset(
                            appbarBgImage,
                            fit: BoxFit.cover,
                          )),
                      Container(
                        height: 1000,
                        color: AppColors.backgroundColor,
                      )
                    ],
                  ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            EachAppbarButton(iconData: Icons.menu_outlined),
                            EachAppbarButton(
                                iconData: Icons.shopping_bag_outlined),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.paddingLg * 2,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: AppSizes.paddingLg),
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
                        padding:
                            const EdgeInsets.only(left: AppSizes.paddingLg),
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
                            borderRadius: BorderRadius.circular(32.r),
                            color: AppColors.backgroundColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingLg,
                          ),
                          child: GridView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: images.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.62,
                              crossAxisCount: 2,
                              crossAxisSpacing: AppSizes.paddingLg,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                      height: 220,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Image.network(
                                        images[index],
                                        fit: BoxFit.cover,
                                      )),
                                  const SizedBox(
                                    height: AppSizes.padding,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Winter Jacket",
                                            style: bodyText.copyWith(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: AppSizes.padding / 1.7,
                                          ),
                                          Text(
                                            "\$129.00",
                                            style: subTitleText.copyWith(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          //TODO: add to cart logic
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(
                                              AppSizes.padding),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.r),
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
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
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
