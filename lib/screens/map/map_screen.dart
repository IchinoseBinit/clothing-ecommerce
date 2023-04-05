import 'dart:developer';
import 'dart:io';

import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/providers/hive_database_helper.dart';
import 'package:clothing_ecommerce/providers/location_provider.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/widgets/alert_bottom_sheet.dart';
import 'package:clothing_ecommerce/widgets/general_elevated_button.dart';
import 'package:clothing_ecommerce/widgets/general_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  LatLng? initialLocation;

  MapScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  final addressController = TextEditingController();
  late Uint8List userMarkerbitmap;
  late Uint8List merchantMarkerbitmap;
  late GoogleMapController mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  String locationTop = "";
  String locationMiddle = "";
  String locationBottom = "";
  String? deliveryAddress;
  bool isInit = true;

  BuildContext? myContext;

  void _selectLocation(LatLng position) async {
    mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 18));
    _pickedLocation = position;
    // await DatabaseHelper()
    //     .addBoxItem(key: "latitude", value: position.latitude.toString());
    // await DatabaseHelper()
    //     .addBoxItem(key: "longitude", value: position.longitude.toString());
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      if (Platform.isIOS) {
        if (!await Permission.location.isGranted) {
          if (!await Permission.location.request().isGranted) {
            if (context.mounted) {
              AlertBottomSheet.showAlertBottomSheet(context,
                  iconImage: alert,
                  isDismissible: false,
                  enableDrag: false,
                  title: "Handle Permisson",
                  description:
                      "Please press OK to accept the required permission in settings",
                  okFunc: () async {
                if (await Permission.location.request().isGranted) {
                  Navigator.pop(context);
                } else {
                  await openAppSettings().whenComplete(() async {
                    if (await Permission.location.isGranted) {
                      Navigator.pop(context);
                    } else {
                      SystemNavigator.pop();
                    }
                  });
                }
              }, isCancelButton: false);
            }
          }
        }
      }
      _initCall();
    }
  }

  _initCall() async {
    Provider.of<LocationProvider>(context, listen: false)
        .setloading(value: true, noNotifier: true);
    String latitude = await DatabaseHelper().getBoxItem(key: "latitude");
    String longitude = await DatabaseHelper().getBoxItem(key: "longitude");

    widget.initialLocation =
        LatLng(double.parse(latitude), double.parse(longitude));
    _pickedLocation = LatLng(double.parse(latitude), double.parse(longitude));
    userMarkerbitmap =
        await Provider.of<LocationProvider>(context, listen: false)
            .getBytesFromAsset(userMarker, (90.w).toInt());

    Provider.of<LocationProvider>(context, listen: false)
        .setloading(value: false);
    isInit = false;
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          //   leading: InkWell(
          //     onTap: () {
          //       mapController.dispose();
          //       Navigator.of(context).pop();
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: AppSizes.paddingLg),
          //       child: Icon(
          //         Icons.arrow_back_ios,
          //         color: Colors.black,
          //         size: 24.r,
          //       ),
          //     ),
          //   ),
          // actions: [
          //   if (widget.isSelecting)
          //     IconButton(
          //       onPressed: _pickedLocation == null
          //           ? null
          //           : () {
          //               Navigator.of(context).pop(_pickedLocation);
          //             },
          //       icon: const Icon(
          //         Icons.check,
          //         color: Colors.black,
          //         size: 32,
          //       ),
          //     )
          // ],
          // ),
          body: Provider.of<LocationProvider>(
            context,
          ).isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    GoogleMap(
                        // polylines: {
                        //   if (directions != null)
                        //     Polyline(
                        //       polylineId: const PolylineId('overview_polyline'),
                        //       color: Colors.red,
                        //       width: 5,
                        //       points: directions!.polylinePoints
                        //           .map((e) => LatLng(e.latitude, e.longitude))
                        //           .toList(),
                        //     ),
                        // },
                        zoomGesturesEnabled: true,
                        myLocationButtonEnabled: false,
                        // circles: widget.direction == null
                        //     ? {}
                        //     : {
                        //         Circle(
                        //           visible: true,
                        //           strokeWidth: 2,
                        //           strokeColor: Colors.blue,
                        //           circleId: const CircleId("free-delivery"),
                        //           center: LatLng(
                        //               widget.direction!.bounds.northeast.latitude,
                        //               widget.direction!.bounds.southwest.longitude),
                        //           radius: 200,
                        //           fillColor: Colors.blue.withOpacity(0.1),
                        //         ),
                        //         Circle(
                        //           strokeWidth: 5,
                        //           strokeColor: Colors.red,
                        //           circleId: const CircleId("delivery-raduis"),
                        //           center: LatLng(
                        //               widget.direction!.bounds.northeast.latitude,
                        //               widget.direction!.bounds.southwest.longitude),
                        //           radius: 3000,
                        //         ),
                        //       },
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        // cameraTargetBounds: merchantLocation == null
                        //     ? CameraTargetBounds.unbounded
                        //     : CameraTargetBounds(LatLngBounds(
                        //         northeast: LatLng(merchantLocation!.latitude+0.01,
                        //             merchantLocation!.longitude + 0.01),
                        //         southwest: LatLng(_pickedLocation!.latitude + 0.01,
                        //             _pickedLocation!.longitude + 0.01),
                        //       )),
                        onMapCreated: (controller) async {
                          //method called when map is created
                          mapController = controller;
                          Position position =
                              await Provider.of<LocationProvider>(context,
                                      listen: false)
                                  .getUserCurrentLocation();
                          mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(
                                  LatLng(position.latitude, position.longitude),
                                  18));
                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  position.latitude, position.longitude);
                          //get place name from lat and lang
                          locationTop =
                              "${placemarks.first.subLocality}${placemarks.first.subLocality == "" ? "" : ", "}${placemarks.first.locality}";
                          locationMiddle =
                              "${placemarks.first.street} ${placemarks.first.postalCode}, ${placemarks.first.country}";
                          locationBottom =
                              "${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}";

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        onCameraMove: (CameraPosition camPos) {
                          cameraPosition = camPos; //when map is dragging
                        },
                        onCameraIdle: () async {
                          //when map drag stops

                          if (cameraPosition?.target.latitude != null &&
                              cameraPosition?.target.longitude != null) {
                            List<Placemark> placemarks =
                                await placemarkFromCoordinates(
                                    cameraPosition!.target.latitude,
                                    cameraPosition!.target.longitude);

                            // await DatabaseHelper().addBoxItem(
                            //     key: "latitude",
                            //     value: cameraPosition!.target.latitude
                            //         .toString());
                            // await DatabaseHelper().addBoxItem(
                            //     key: "longitude",
                            //     value: cameraPosition!.target.longitude
                            //         .toString());
                            _pickedLocation = LatLng(
                                cameraPosition!.target.latitude,
                                cameraPosition!.target.longitude);
                            //get place name from lat and lang
                            locationTop =
                                "${placemarks.first.subLocality}${placemarks.first.subLocality == "" ? "" : ", "}${placemarks.first.locality}";
                            locationMiddle =
                                "${placemarks.first.street} ${placemarks.first.postalCode}, ${placemarks.first.country}";
                            locationBottom =
                                "${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}";
                            if (mounted) {
                              setState(() {});
                            }
                          }
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            widget.initialLocation!.latitude,
                            widget.initialLocation!.longitude,
                          ),
                          zoom: 14,
                        ),
                        // onTap: null,
                        onTap: _selectLocation,
                        // markers: (_pickedLocation == null && widget.isSelecting)
                        markers: {}),
                    Center(
                      //picker image on google map
                      child: Image.asset(
                        userMarker,
                        width: 42.r,
                      ),
                    ),
                    if (locationTop != "")
                      Positioned(
                        //widget to display location name
                        bottom: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Position position =
                                    await Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .getUserCurrentLocation();
                                mapController.animateCamera(
                                    CameraUpdate.newLatLngZoom(
                                        LatLng(position.latitude,
                                            position.longitude),
                                        18));
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(AppSizes.paddingLg),
                                child: FloatingActionButton(
                                  backgroundColor: AppColors.primaryColor,
                                  onPressed: null,
                                  child: Icon(Icons.my_location),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(AppSizes.padding),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppSizes.padding),
                                    child: Text(
                                      "Delivery Location",
                                      style: bodyText.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        userMarker,
                                        width: 40.r,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locationTop,
                                              style: bodyText.copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              locationMiddle,
                                              style: bodyText.copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              locationBottom,
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: AppSizes.padding,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppSizes.padding),
                                    child: GeneralTextField(
                                      controller: addressController,
                                      obscureText: false,
                                      keywordType: TextInputType.text,
                                      validate: (_) {},
                                      onFieldSubmit: (_) {},
                                      textInputAction: TextInputAction.go,
                                      onSave: (_) {},
                                      labelText: "Name",
                                      hintText: "Eg. Home, Work or Gym",
                                      fillColor: AppColors.inputColor,
                                      borderColor: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  GeneralElevatedButton(
                                    title: "Save Location",
                                    onPressed: () async {
                                      mapController.dispose();

                                      Navigator.of(context).pop({
                                        "location": _pickedLocation,
                                        "name": addressController.text
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Positioned(
                      top: AppSizes.padding * 6,
                      left: AppSizes.paddingLg,
                      right: AppSizes.paddingLg,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            mapController.dispose();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.padding),
                            child:
                                Icon(Icons.arrow_back_ios, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
