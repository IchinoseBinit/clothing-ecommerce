import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

import '/utils/navigation_util.dart';
import '/widgets/custom_appbar.dart';

class WebViewMapScreen extends StatefulWidget {
  final String userLatitude;
  final String userLongitude;
  final String merchantLatitude;
  final String merchantLongitude;
  const WebViewMapScreen(
      {super.key,
      required this.userLatitude,
      required this.userLongitude,
      required this.merchantLatitude,
      required this.merchantLongitude});

  @override
  State<WebViewMapScreen> createState() => _WebViewMapState();
}

class _WebViewMapState extends State<WebViewMapScreen> {
  bool isLoading = true;
  // final controller = WebViewController();
  // WebViewController getwebView() {
  //   controller.setJavaScriptMode(JavaScriptMode.unrestricted);
  //   controller.setBackgroundColor(Color(0x00000000));
  //   // controller.loadRequest(uri)
  //   controller.setNavigationDelegate(NavigationDelegate(
  //     onProgress: (progress) {
  //       CircularProgressIndicator();
  //     },
  //     onPageStarted: (url) {
  //       url =
  //           "https://www.google.com/maps/dir/${widget.userLatitude},${widget.userLongitude}/${widget.merchantLatitude},${widget.merchantLongitude}/@,,14z/data=!3m1!4b1!4m2!4m1!3e0";
  //     },
  //   ));
  //   return controller;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Direction",
          disableLeading: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: 24.r,
                Icons.close,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            WebView(
                onWebViewCreated: (controller) {
                  log("dada");
                  controller.runJavascript(
                      "document.getElementsByClassName('rR1a6d').style.visibility = 'hidden !important'");
                },
                onPageFinished: (url) {},
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (progress) {
                  if (progress == 100) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                initialUrl:
                    "https://www.google.com/maps/dir/${widget.userLatitude},${widget.userLongitude}/${widget.merchantLatitude},${widget.merchantLongitude}/@,,14z/data=!3m1!4b1!4m2!4m1!3e0"),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack()
          ],
        ));
  }
}
