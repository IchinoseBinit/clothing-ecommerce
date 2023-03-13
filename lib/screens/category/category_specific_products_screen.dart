import 'package:clothing_ecommerce/data/response/status.dart';
import 'package:clothing_ecommerce/models/category_model.dart';
import 'package:clothing_ecommerce/providers/category_provider.dart';
import 'package:clothing_ecommerce/screens/home/home_screen.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/widgets/custom_appbar.dart';
import 'package:clothing_ecommerce/widgets/error_info_widget.dart';
import 'package:clothing_ecommerce/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategorySpecificProductsScreen extends StatefulWidget {
  final CategoryModel category;
  const CategorySpecificProductsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategorySpecificProductsScreen> createState() =>
      CategorySpecificProductsScreenState();
}

class CategorySpecificProductsScreenState
    extends State<CategorySpecificProductsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false)
        .fetchCategorySpecificProducts(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: widget.category.name),
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: MyBehaviour(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
              ),
              // color: AppColors.backgroundColor,
            ),
            padding: const EdgeInsets.only(
                left: AppSizes.paddingLg,
                right: AppSizes.paddingLg,
                top: AppSizes.paddingLg * 2),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Consumer<CategoryProvider>(
                  builder: (_, categoryProvider, __) {
                switch (categoryProvider.categoryProductList.status) {
                  case Status.ERROR:
                    return ErrorInfoWidget(
                      heightFactor: 2,
                      errorInfo: categoryProvider.categoryProductList.message
                          .toString(),
                    );
                  case Status.LOADING:
                    return const LoadingWidget();

                  case Status.COMPLETED:
                    if (categoryProvider.categoryProductList.data!.isEmpty) {
                      return const ErrorInfoWidget(
                        errorInfo:
                            "There is no item in this category. Please try another category.",
                        heightFactor: 2,
                      );
                    }
                    return GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          categoryProvider.categoryProductList.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.65,
                        crossAxisCount: 2,
                        crossAxisSpacing: AppSizes.paddingLg,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItem(
                            product: categoryProvider
                                .categoryProductList.data![index]);
                      },
                    );
                  default:
                    return const SizedBox.shrink();
                }
              }),
            ),
          ),
        ));
  }
}
