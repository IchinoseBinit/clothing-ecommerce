import 'dart:developer';
import 'dart:ui' as ui;

import 'package:clothing_ecommerce/api/location_list_api.dart';
import 'package:clothing_ecommerce/data/app_urls.dart';
import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/data/response/api_response.dart';
import 'package:clothing_ecommerce/models/location_model.dart';
import 'package:clothing_ecommerce/providers/hive_database_helper.dart';
import 'package:clothing_ecommerce/screens/checkout/checkout_screen.dart';
import 'package:clothing_ecommerce/screens/map/map_screen.dart';
import 'package:clothing_ecommerce/utils/navigation_util.dart';
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
  final _locationListApi = LocationListApi();
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

  onCheckOut(context,
      {required String merchantName,
      required int merchantId,
      bool isFromDetail = false}) async {
    String? latitude = await DatabaseHelper().getBoxItem(key: "latitude");
    String? longitude = await DatabaseHelper().getBoxItem(key: "longitude");
    if (latitude == null && longitude == null) {
      AlertBottomSheet.showAlertBottomSheet(
        context,
        title: "Select location",
        description:
            "Please select your delivery location to checkout the cart item",
        iconImage: alert,
        cancelTitle: "Cancel",
        isCancelButton: true,
        okFunc: () {
          selectMap(context,
              merchantId: merchantId, merchantName: merchantName);
        },
        cancelFunc: () {
          Navigator.pop(context);
        },
      );
    } else {
      navigateReplacement(
          context,
          const CheckoutScreen(
            cartModel: [],
          ));
    }
  }

  setLocation({
    String? locationName,
    LatLng? address,
    bool saveLocation = false,
    bool isFromSelectCity = false,
    bool isPlaceId = false,
  }) async {
    String? deliveryAddress = await DatabaseHelper().getBoxItem(
      key: "deliveryAddress",
    );
    if (deliveryAddress == "") {
      deliveryAddress = null;
    }
    if (locationName != null) {
      // locations = await geo.locationFromAddress(locationName);

      final data = GoogleMapsPlaces(
        apiKey: AppUrl.apiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
        //from google_api_headers package
      );
      if (isPlaceId) {
        log(locationName, name: "is placeid");
        final detail = await data.getDetailsByPlaceId(locationName);
        final geometry = detail.result.geometry!;
        final lat = geometry.location.lat;
        final long = geometry.location.lng;
        locations = [
          geo.Location(
              latitude: lat, longitude: long, timestamp: DateTime.now())
        ];
      } else {
        log(locationName, name: "not place id");
        final detail = await data.searchByText(locationName);
        final geometryList = detail.results.where((element) => element
            .formattedAddress!
            .toLowerCase()
            .contains(locationName.split(",").last.toLowerCase()));
        final geometry = geometryList.first.geometry!;
        final lat = geometry.location.lat;
        final long = geometry.location.lng;
        locations = [
          geo.Location(
              latitude: lat, longitude: long, timestamp: DateTime.now())
        ];
      }

      setCoordinateDatabase(
          latitude: locations.last.latitude.toString(),
          longitude: locations.last.longitude.toString(),
          saveLocation: saveLocation);
      placemarks = await geo.placemarkFromCoordinates(
          locations.last.latitude, locations.last.longitude);
      if (isFromSelectCity) {
        subtitleAdd = locationName;
        stAdd = locationName +
            (deliveryAddress == null ? "" : ", $deliveryAddress");
      } else {
        stAdd = locationName +
            (deliveryAddress == null ? "" : ", $deliveryAddress");
        subtitleAdd =
            "${placemarks.first.subAdministrativeArea}, ${placemarks.first.country}";
      }
      log("New Location Set get Location Location Provider start !!!");
      log(locationName);
      log('${locations.last.latitude} ${locations.last.longitude}');
      log("New Location Set get Location Location Provider end !!!");
    }

    if (address != null) {
      setCoordinateDatabase(
          latitude: address.latitude.toString(),
          longitude: address.longitude.toString(),
          saveLocation: saveLocation);
      log("My Location");
      log('${address.latitude} ${address.longitude} using Address Model');
      await setPlacemark(
          deliveryAddress: deliveryAddress,
          latitude: address.latitude,
          longitude: address.longitude);
    }

    if (address == null && locationName == null) {
      await getUserCurrentLocation().then((value) async {
        setCoordinateDatabase(
            latitude: value.latitude.toString(),
            longitude: value.longitude.toString(),
            saveLocation: saveLocation);
        log("My Location");
        log('${value.latitude} ${value.longitude}');
        locations = [
          geo.Location(
              latitude: value.latitude,
              longitude: value.longitude,
              timestamp: DateTime.now())
        ];
        await setPlacemark(
            deliveryAddress: deliveryAddress,
            latitude: value.latitude,
            longitude: value.longitude);
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }
    notifyListeners();
  }

  setCoordinateDatabase(
      {required String latitude,
      required String longitude,
      required bool saveLocation}) async {
    if (saveLocation) {
      await DatabaseHelper().addBoxItem(key: "latitude", value: latitude);
      await DatabaseHelper().addBoxItem(key: "longitude", value: longitude);
    }
  }

  setPlacemark({
    required double latitude,
    required String? deliveryAddress,
    required double longitude,
  }) async {
    placemarks = await geo.placemarkFromCoordinates(latitude, longitude);

    subtitleAdd =
        "${placemarks.first.subAdministrativeArea}, ${placemarks.first.country}";
    stAdd =
        "${placemarks.first.street}, ${placemarks.first.subLocality}${placemarks.first.subLocality == "" ? "" : ", "}${placemarks.first.locality}${deliveryAddress == null ? "" : ", $deliveryAddress"}";
    log(stAdd.toString(), name: "Sraddress");
  }
}
