import 'dart:developer';
import 'dart:ui' as ui;

import 'package:clothing_ecommerce/api/location_api.dart';
import 'package:clothing_ecommerce/data/extensions/decimal_round_off.dart';
import 'package:clothing_ecommerce/data/response/api_response.dart';
import 'package:clothing_ecommerce/models/location_model.dart';
import 'package:clothing_ecommerce/screens/checkout/checkout_screen.dart';
import 'package:clothing_ecommerce/screens/map/map_screen.dart';
import 'package:clothing_ecommerce/utils/navigation_util.dart';
import 'package:clothing_ecommerce/utils/show_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  final _locationListApi = LocationApi();
  String tempStAdd = "Please select your delivery address";
  String stAdd = "Please select your delivery address";
  bool isLoading = true;
  late List<geo.Location> locations;
  List<geo.Placemark> placemarks = [];
  ApiResponse<List<LocationModel>> locationList = ApiResponse.loading();

  setLocationList(ApiResponse<List<LocationModel>> response) {
    locationList = response;
    notifyListeners();
  }

  resetData() {
    tempStAdd = "Please select your delivery address";
    stAdd = "Please select your delivery address";
  }

  Future<void> fetchLocationList() async {
    resetData();
    await _locationListApi.fetchLocationListApi().then((value) {
      List<LocationModel> selectedDefault = value
          .where(
            (element) => element.defaultVal,
          )
          .toList();
      if (selectedDefault.isNotEmpty) {
        stAdd = selectedDefault.first.address;
      }
      setLocationList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setLocationList(ApiResponse.error(error.toString()));
    });
  }

  setSelected(int index) {
    if (!locationList.data![index].isSelected) {
      for (LocationModel locationModel in locationList.data!) {
        locationModel.setSelect(val: false);
      }
    }

    locationList.data![index].setSelect();
    stAdd = locationList.data![index].address;
    notifyListeners();
  }

  Future<void> setAddress(
    BuildContext context, {
    required String name,
    required String address,
    required double longitude,
    required double latitude,
    int? id,
    required bool isUpdateAddress,
  }) async {
    Map body = {
      "name": name,
      "longitude": longitude.toPrecision(5),
      "latitude": latitude.toPrecision(5),
      "address": address,
    };
    await _locationListApi
        .setAddressApi(context,
            id: id, body: body, isUpdateAddress: isUpdateAddress)
        .then((value) {
      showToast(value["message"]);
    }).onError((error, stackTrace) {
      showToast(error.toString());
    });
  }

  setloading({bool? value, bool noNotifier = false}) {
    isLoading = value ?? !isLoading;
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
    required bool isUpdateAddress,
    required LatLng address,
    int? id,
  }) async {
    log("My Location");
    log('${address.latitude} ${address.longitude} using Address Model');
    placemarks =
        await geo.placemarkFromCoordinates(address.latitude, address.longitude);
    tempStAdd =
        "${placemarks.first.street}, ${placemarks.first.subLocality}${placemarks.first.subLocality == "" ? "" : ", "}${placemarks.first.locality}";
    log(tempStAdd.toString(), name: "Sraddress");

    await setAddress(context,
        id: id,
        isUpdateAddress: isUpdateAddress,
        address: tempStAdd,
        name: locationName,
        longitude: address.longitude,
        latitude: address.latitude);
    fetchLocationList();
    // notifyListeners();
  }
}
