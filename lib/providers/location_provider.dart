import 'dart:developer';
import 'dart:ui' as ui;

import 'package:clothing_ecommerce/api/location_api.dart';
import 'package:clothing_ecommerce/data/app_urls.dart';
import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/data/response/api_response.dart';
import 'package:clothing_ecommerce/models/location_model.dart';
import 'package:clothing_ecommerce/providers/hive_database_helper.dart';
import 'package:clothing_ecommerce/screens/checkout/checkout_screen.dart';
import 'package:clothing_ecommerce/screens/map/map_screen.dart';
import 'package:clothing_ecommerce/utils/navigation_util.dart';
import 'package:clothing_ecommerce/utils/show_toast.dart';
import 'package:clothing_ecommerce/widgets/alert_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class LocationProvider with ChangeNotifier {
  final _locationListApi = LocationApi();
  String stAdd = "Please select your delivery address";
  String subtitleAdd = "";
  bool isLoading = true;
  bool isNearbySearchLoading = false;
  late List<geo.Location> locations;
  List<geo.Placemark> placemarks = [];
  ApiResponse<List<LocationModel>> locationList = ApiResponse.loading();

  setLocationList(ApiResponse<List<LocationModel>> response) {
    locationList = response;
    notifyListeners();
  }

  Future<void> fetchLocationList() async {
    await _locationListApi.fetchLocationListApi().then((value) {
      setLocationList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setLocationList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> addAddress(
    BuildContext context, {
    required String name,
    required double longitude,
    required double latitude,
  }) async {
    Map body = {"name": name, "longitude": longitude, "latitude": latitude};
    _locationListApi.addAddressApi(body).then((value) async {
      showToast(value["message"]);
     
    }).onError((error, stackTrace) {
      showToast(error.toString());
    });
  }

  setloading({bool? value, bool noNotifier = false}) {
    isLoading = value ?? !isLoading;
    if (!noNotifier) notifyListeners();
  }

  setNearByloading({bool? value, bool noNotifier = false}) {
    isNearbySearchLoading = value ?? !isNearbySearchLoading;
    if (!noNotifier) notifyListeners();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      log(error.toString(), name: "Error: ");
    });

    return await Geolocator.getCurrentPosition();
  }

  Future<void> selectMap(
    context, {
    required String merchantName,
    required int merchantId,
  }) async {
    LatLng? selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => MapScreen(),
          settings: const RouteSettings(name: "MapScreen")),
    );
    if (selectedLocation != null) {
      await navigateReplacement(
          context,
          const CheckoutScreen(
            cartModel: [],
          ));
    }
  }

  setLocation(
    BuildContext context, {
    required String locationName,
    required LatLng address,
  }) async {
    log("My Location");
    log('${address.latitude} ${address.longitude} using Address Model');
    await setPlacemark(context,
        locationName: locationName,
        latitude: address.latitude,
        longitude: address.longitude);
    notifyListeners();
  }

  setPlacemark(
    context, {
    required String locationName,
    required double latitude,
    required double longitude,
  }) async {
    
    placemarks = await geo.placemarkFromCoordinates(latitude, longitude);

    subtitleAdd =
        "${placemarks.first.subAdministrativeArea}, ${placemarks.first.country}";
    stAdd =
        "${placemarks.first.street}, ${placemarks.first.subLocality}${placemarks.first.subLocality == "" ? "" : ", "}${placemarks.first.locality}";
    log(stAdd.toString(), name: "Sraddress");
   
    await addAddress(context,
        name: locationName, longitude: longitude, latitude: latitude);
         fetchLocationList();
  }
}
