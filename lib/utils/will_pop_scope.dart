import 'package:flutter/material.dart';

class WillPopScopeClass {
  static Future<bool>? willPopCallback(BuildContext context) async {
    return false;

    // await showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         shape: const RoundedRectangleBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(20.0))),
    //         title: const Text('Exit App'),
    //         content: const Text('Do you want to exit an App?'),
    //         actions: [
    //           ElevatedButton(
    //             onPressed: () => Navigator.of(context).pop(false),
    //             style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.all(Colors.red),
    //               shape: MaterialStateProperty.all(
    //                 RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(20),
    //                 ),
    //               ),
    //             ),
    //             //return false when click on "NO"
    //             child: const Text('No'),
    //           ),
    //           ElevatedButton(
    //             onPressed: () => Navigator.of(context).pop(true),
    //             style: ButtonStyle(
    //               backgroundColor:
    //                   MaterialStateProperty.all(AppColors.primaryColor),
    //               shape: MaterialStateProperty.all(
    //                 RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(20),
    //                 ),
    //               ),
    //             ),
    //             child: const Text('Yes'),
    //           ),
    //         ],
    //       ),
    //     ) ??
    //     false;
  }
}
