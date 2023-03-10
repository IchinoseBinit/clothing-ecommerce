import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/data/constants/routes_name.dart';
import '/data/response/status.dart';
import '/providers/auth_provider.dart';
import '/providers/intro_notifier.dart';
import '/providers/profile_provider.dart';
import '/screens/auth_screen/login_screen.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/navigation_util.dart';
import '/utils/will_pop_scope.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/error_info_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        Provider.of<ProfileProvider>(context, listen: false)
            .fetchProfileApi(noNotifer: false);
        isInit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          await WillPopScopeClass.willPopCallback(context) ?? false,
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: false,
          disableLeading: true,
          title: "Profile",
          automaticallyImplyLeading: false,
          actions: [],
        ),
        body: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
          child:
              Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
            switch (profileProvider.profileList.status) {
              case Status.ERROR:
                return const ErrorInfoWidget();

              case Status.LOADING:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case Status.COMPLETED:
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: AppColors.whiteColor,
                      padding: const EdgeInsets.only(
                        left: AppSizes.paddingLg,
                        right: AppSizes.paddingLg,
                        top: AppSizes.paddingLg,
                        bottom: AppSizes.padding * 4,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundColor: AppColors.lightestPrimaryColor,
                            child: Text(
                              profileProvider.profileList.data!.name
                                  .split(" ")
                                  .toList()
                                  .map((String e) => e[0])
                                  .toList()
                                  .join(),
                              style: bigTitleText.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileProvider.profileList.data!.name,
                                style: subTitleText.copyWith(
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                profileProvider.profileList.data!.email,
                                style: bodyText.copyWith(
                                    color: AppColors.textSoftGreyColor),
                              ),
                              Text(
                                profileProvider.profileList.data!.mobile,
                                style: bodyText.copyWith(
                                    color: AppColors.textSoftGreyColor),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                          context, RoutesName.editProfileRoute)
                                      .whenComplete(
                                    () => Provider.of<ProfileProvider>(context,
                                            listen: false)
                                        .fetchProfileApi(noNotifer: false),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.primaryColor,
                                      size: 18.r,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      "Edit Profile",
                                      style: bodyText.copyWith(
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.lock_outline),
                      onTap: () async {
                        Navigator.pushNamed(
                            context, RoutesName.changePasswordRoute);
                      },
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: AppSizes.padding / 2,
                          horizontal: AppSizes.paddingLg),
                      tileColor: Colors.white,
                      title: Text("Change Password", style: bodyText),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ),
                    const Divider(height: 0),
                    const Spacer(),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(
                        Icons.logout_outlined,
                        color: AppColors.emergencyTextColor,
                      ),
                      onTap: () async {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout(context);
                      },
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: AppSizes.padding / 2,
                          horizontal: AppSizes.paddingLg),
                      tileColor: Colors.white,
                      title: Text("Log Out", style: bodyText),
                    ),
                  ],
                );

              default:
                return const SizedBox.shrink();
            }
          }),
        ),
      ),
    );
  }
}
