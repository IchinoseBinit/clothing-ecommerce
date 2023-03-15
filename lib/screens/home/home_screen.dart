import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/data/constants/routes_name.dart';
import 'package:clothing_ecommerce/data/response/status.dart';
import 'package:clothing_ecommerce/models/category_model.dart';
import 'package:clothing_ecommerce/providers/cart_provider.dart';
import 'package:clothing_ecommerce/providers/category_provider.dart';
import 'package:clothing_ecommerce/providers/product_list_provider.dart';
import 'package:clothing_ecommerce/screens/category/category_specific_products_screen.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/utils/navigation_util.dart';
import 'package:clothing_ecommerce/widgets/error_info_widget.dart';
import 'package:clothing_ecommerce/widgets/general_icon_button.dart';
import 'package:clothing_ecommerce/widgets/general_loading_barrier.dart';
import 'package:clothing_ecommerce/widgets/general_textfield.dart';
import 'package:clothing_ecommerce/widgets/loading_widget.dart';
import 'package:clothing_ecommerce/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductListProvider>(context, listen: false).fetchProductList();
    Provider.of<CategoryProvider>(context, listen: false).fetchCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: ScrollConfiguration(
            behavior: MyBehaviour(),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                      height: 360,
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Center(
                                  child: Text(
                                    "Welcome".toUpperCase(),
                                    style: bodyText.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  "Niraj",
                                  style: subTitleText.copyWith(
                                    color: AppColors.textDarkColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            GeneralIconButton(
                                iconData: Icons.shopping_bag_outlined,
                                onPressed: () {
                                  navigateNamed(context, RoutesName.cartRoute);
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.paddingLg * 2,
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: AppSizes.paddingLg),
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
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingLg),
                        child: GeneralTextField(
                          hintText: "Search...",
                          readonly: true,
                          // isDisabled: true,
                          onTap: () {
                            navigateNamed(
                                context, RoutesName.productSearchRoute);
                          },
                          obscureText: false,
                          prefixWidget: const Icon(Icons.search,
                              color: AppColors.greyColor),
                          borderColor: Colors.grey.shade200,
                          removePrefixIconDivider: true,
                          keywordType: TextInputType.text,
                          validate: (String value) {},
                          onFieldSubmit: () {},
                          textInputAction: TextInputAction.search,
                          onClickSuffixToggle: () {},
                          onChanged: (value) {},
                          onSave: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.paddingLg * 1.2,
                      ),
                      Consumer<CategoryProvider>(builder: (_, provider, __) {
                        switch (provider.categoryList.status) {
                          case Status.LOADING:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case Status.COMPLETED:
                            if (provider.categoryList.data!.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSizes.paddingLg),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: provider.categoryList.data!
                                        .map((e) => EachCategoryItem(model: e))
                                        .toList()),
                              ),
                            );
                          default:
                            break;
                        }
                        return const SizedBox.shrink();
                      }),
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
                            child: Consumer<ProductListProvider>(
                                builder: (_, listProvider, __) {
                              switch (listProvider.productList.status) {
                                case Status.ERROR:
                                  return const ErrorInfoWidget(
                                    heightFactor: 2,
                                  );
                                case Status.LOADING:
                                  return const LoadingWidget();

                                case Status.COMPLETED:
                                  if (listProvider.productList.data!.isEmpty) {
                                    return const ErrorInfoWidget(
                                      errorInfo:
                                          "Merchant has no item. Try again after sometimes.",
                                      heightFactor: 2,
                                    );
                                  }
                                  return GridView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        listProvider.productList.data!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.65,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: AppSizes.paddingLg,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ProductItem(
                                          product: listProvider
                                              .productList.data![index]);
                                    },
                                  );
                                default:
                                  return const SizedBox.shrink();
                              }
                            }),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        if (Provider.of<CartProvider>(context).loading)
          const GeneralLoadingBarrier()
      ],
    );
  }
}

class EachCategoryItem extends StatelessWidget {
  final CategoryModel model;
  const EachCategoryItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigate(context, CategorySpecificProductsScreen(category: model));
      },
      child: Container(
        margin: const EdgeInsets.only(right: AppSizes.paddingLg / 1.6),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingLg, vertical: AppSizes.padding * 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius * 4),
          color: AppColors.lightPrimaryColor,
        ),
        child: Text(
          model.name,
          style: smallText.copyWith(color: AppColors.darkPrimaryColor),
        ),
      ),
    );
  }
}
