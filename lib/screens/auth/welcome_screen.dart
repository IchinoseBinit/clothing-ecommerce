import 'package:clothing_ecommerce/widgets/general_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/data/constants/routes_name.dart';
import '/data/data.dart';
import '/providers/hive_database_helper.dart';
import '/widgets/general_elevated_button.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController controller = PageController();
  int currentPageValue = 0;
  bool isIntro = false;

  @override
  void initState() {
    super.initState();
    preference();
  }

  void preference() async {
    await DatabaseHelper().addBoxItem(key: "hideIntro", value: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: 600.h,
              padding: const EdgeInsets.all(AppSizes.padding),
              child: Column(
                children: [
                  SizedBox(
                    height: 450.h,
                    // color: Colors.red,
                    child: ScrollConfiguration(
                      behavior: const MaterialScrollBehavior()
                          .copyWith(overscroll: false),
                      child: PageView.builder(
                          controller: controller,
                          itemCount: introItems.length,
                          onPageChanged: (value) {
                            currentPageValue = value;
                            setState(() {});
                          },
                          itemBuilder: (BuildContext context, int index) {
                            IntroItem item = introItems[index];
                            return Column(
                              children: [
                                Image.asset(item.icon),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: bigTitleText.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  item.description,
                                  style: bodyText.copyWith(
                                    color: AppColors.textSoftGreyColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  _indicator(),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _indicator() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < introItems.length; i++)
                if (i == currentPageValue) ...[lineIndicator(true, i)] else
                  lineIndicator(false, i),
            ],
          );
        });
  }

  Widget lineIndicator(bool isActive, int i) {
    return InkWell(
      onTap: () {
        controller.animateToPage(i,
            duration: const Duration(milliseconds: 10), curve: Curves.bounceIn);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 30),
        padding: const EdgeInsets.only(left: 10),
        width: isActive ? 50 : 20,
        child: Divider(
          thickness: isActive ? 6 : 4,
          color: isActive
              ? AppColors.primaryColor
              : AppColors.primaryColor.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GeneralTextButton(
                marginH: 0,
                title: "Log In",
                borderRadius: 24.r,
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.loginRoute);
                },
              ),
            ),
            const SizedBox(
              width: AppSizes.padding,
            ),
            Expanded(
              child: GeneralElevatedButton(
                borderRadius: 24.r,
                marginH: 0,
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.registerRoute);
                },
                title: "Register",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
        GestureDetector(
          child: Text(
            "Skip to Home",
            style: bodyText.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, RoutesName.navigationRoute);
          },
        ),
      ],
    );
  }
}
