import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/widgets/general_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        behavior:MyBehaviour(),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.padding * 2),
          child: Column(
            children: [
              SizedBox(
                height:  30.h,),
              SizedBox(
                height:  MediaQuery.of(context).size.height * .55,
                // color: Colors.red,
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
                          SizedBox(
                            height: 16.h,
                          ),
                          SvgPicture.asset(item.icon,
                              height:
                                  MediaQuery.of(context).size.height * .40),
                          SizedBox(
                            height: 16.h,
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
              _indicator(),
              SizedBox(
                height: 32.h,
              ),
              _buildButton()
            ],
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
        Column(
          children: [
            GeneralTextButton(
              marginH: 0,
              title: "Log In",
              borderRadius: 24.r,
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.loginRoute);
              },
            ),
            const SizedBox(
              height: AppSizes.padding * 2,
            ),
            GeneralElevatedButton(
              borderRadius: 24.r,
              marginH: 0,
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.registerRoute);
              },
              title: "Register",
            ),
          ],
        ),
      ],
    );
  }
}
