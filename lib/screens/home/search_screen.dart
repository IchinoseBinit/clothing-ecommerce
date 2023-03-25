import 'dart:async';
import 'package:clothing_ecommerce/data/response/status.dart';
import 'package:clothing_ecommerce/providers/product_search_provider.dart';
import 'package:clothing_ecommerce/widgets/product_item.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/widgets/error_info_widget.dart';
import 'package:clothing_ecommerce/widgets/general_icon_button.dart';
import 'package:clothing_ecommerce/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '/styles/app_colors.dart';
import '/widgets/general_textfield.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({Key? key}) : super(key: key);

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final searchController = TextEditingController();
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(
                bottom: AppSizes.padding, top: AppSizes.padding),
            child: Row(

              children: [
                GeneralIconButton(
                    iconData: Icons.arrow_back_ios_outlined,
                    size: 45,
                    onPressed: () {
                      Navigator.pop(context);
                    }),

                    SizedBox(width: 8.w,),
                Expanded(
                  child: GeneralTextField(
                    hintText: "Search...",
                    // isDisabled: true,
                    controller: searchController,
                    obscureText: false,
                    prefixWidget:
                        const Icon(Icons.search, color: AppColors.greyColor),
                    borderColor: Colors.grey.shade200,
                    removePrefixIconDivider: true,
                    keywordType: TextInputType.text,
                    autofocus: true,
                    validate: (String value) {},
                    onFieldSubmit: () {},
                    textInputAction: TextInputAction.search,
                    onClickSuffixToggle: () {
                      searchController.clear();
                    },
                    suffixIcon: Provider.of<ProductSearchProvider>(context)
                            .showClearButton
                        ? Icons.cancel
                        : null,
                    suffixIconColor: AppColors.greyColor,
                    onChanged: (String value) {
                      Provider.of<ProductSearchProvider>(context, listen: false)
                          .setShowClearButton(value.isNotEmpty);
                      if (timer != null) {
                        timer!.cancel();
                      }
                      timer = Timer(const Duration(seconds: 1), () {
                        Provider.of<ProductSearchProvider>(context,
                                listen: false)
                            .fetchSearchProductList(value.toString());
                      });
                    },
                    onSave: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ),
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
              child: Consumer<ProductSearchProvider>(
                  builder: (_, productSearchProvider, __) {
                switch (productSearchProvider.productSearchList.status) {
                  case Status.ERROR:
                    return ErrorInfoWidget(
                      heightFactor: 2,
                      errorInfo: productSearchProvider
                          .productSearchList.message
                          .toString(),
                    );
                  case Status.LOADING:
                    return const LoadingWidget();

                  case Status.COMPLETED:
                    if (productSearchProvider
                        .productSearchList.data!.isEmpty) {
                      return const ErrorInfoWidget(
                        errorInfo: "Item not found. Please try another item.",
                        heightFactor: 2,
                      );
                    }
                    return GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productSearchProvider
                          .productSearchList.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.65,
                        crossAxisCount: 2,
                        crossAxisSpacing: AppSizes.paddingLg,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItem(
                            product: productSearchProvider
                                .productSearchList.data![index]);
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
