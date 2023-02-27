import 'dart:developer';

import 'package:flutter/cupertino.dart';

class MerchantModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  MerchantModel({this.count, this.next, this.previous, this.results});

  MerchantModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  BusinessInfo? businessInfo;
  List<Locations>? locations;

  Results({this.id, this.businessInfo, this.locations});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessInfo = json['business_info'] != null
        ? BusinessInfo.fromJson(json['business_info'])
        : null;
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (businessInfo != null) {
      data['business_info'] = businessInfo!.toJson();
    }
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessInfo {
  String? name;
  String? businessType;
  String? domain;
  String? description;

  BusinessInfo({this.name, this.businessType, this.domain, this.description});

  BusinessInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    businessType = json['business_type'];
    domain = json['domain'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['business_type'] = businessType;
    data['domain'] = domain;
    data['description'] = description;
    return data;
  }
}

class Locations {
  int? id;
  late bool isFavourite;
  String? name;
  String? contactNumber;
  String? contactEmail;
  String? city;
  String? postalCode;
  String? state;
  String? country;
  String? timezone;
  String? latitude;
  String? longitude;
  String? location;
  String? address;
  String? currency;
  String? website;
  bool? main;
  String? logo;
  String? locationCode;
  int? firstDayOfWeek;
  List<int>? closingDays;
  String? notificationEmail;
  String? notificationMobile;
  List? bookingOptionsList;
  String? minimumOrder;
  String? bookingUrl;
  List<String>? tagsList;
  List<Tags>? tags;
  String? banner;

  BookingOptions? bookingOptions;
  Locations(
      {this.id,
      this.name,
      this.isFavourite = false,
      this.contactNumber,
      this.contactEmail,
      this.city,
      this.postalCode,
      this.state,
      this.country,
      this.timezone,
      this.latitude,
      this.longitude,
      this.location,
      this.address,
      this.currency,
      this.website,
      this.main,
      this.logo,
      this.banner,
      this.locationCode,
      this.firstDayOfWeek,
      this.closingDays,
      this.notificationEmail,
      this.notificationMobile,
      this.bookingOptionsList,
      this.minimumOrder,
      this.bookingUrl,
      this.bookingOptions,
      this.tagsList});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isFavourite = false;
    name = json['name'];
    contactNumber = json['contact_number'];
    contactEmail = json['contact_email'];
    city = json['city'];
    postalCode = json['postal_code'];
    state = json['state'];
    country = json['country'];
    timezone = json['timezone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    address = json['address'];
    currency = json['currency'];
    website = json['website'];
    main = json['main'];

    logo = json['logo'] ?? "";
    banner = json["banner"] ?? "";

    locationCode = json['location_code'];
    firstDayOfWeek = json['first_day_of_week'];
    closingDays = json['closing_days'].cast<int>();
    notificationEmail = json['notification_email'];
    notificationMobile = json['notification_mobile'];
    bookingOptionsList = json['booking_options'] != null
        ? ((json['booking_options']) as Map).values.toList()
        : null;
    bookingOptions = json['booking_options'] != null
        ? BookingOptions.fromJson(json['booking_options'])
        : null;
    minimumOrder = json['minimum_order'];
    bookingUrl = json['booking_url'];
    if (json['tags'] != []) {
      tagsList =
          (json['tags'] as List).map((e) => e["tag"].toString()).toList();
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['contact_number'] = contactNumber;
    data['contact_email'] = contactEmail;
    data['city'] = city;
    data['postal_code'] = postalCode;
    data['state'] = state;
    data['country'] = country;
    data['timezone'] = timezone;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['address'] = address;
    data['currency'] = currency;
    data['website'] = website;
    data['main'] = main;
    data['logo'] = logo;
    data['location_code'] = locationCode;
    data['first_day_of_week'] = firstDayOfWeek;
    data['closing_days'] = closingDays;
    data['notification_email'] = notificationEmail;
    data['notification_mobile'] = notificationMobile;
    if (bookingOptions != null) {
      data['booking_options'] = bookingOptions!.toJson();
    }
    data['minimum_order'] = minimumOrder;
    data['booking_url'] = bookingUrl;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  setIsFav() {
    isFavourite = !isFavourite;
  }
}

class BookingOptions {
  String? selfCollection;
  String? delivery;

  BookingOptions({this.selfCollection, this.delivery});

  BookingOptions.fromJson(Map<String, dynamic> json) {
    selfCollection = json['self_collection'] ?? "";
    delivery = json['delivery'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['self_collection'] = selfCollection ?? "";
    data['delivery'] = delivery ?? "";
    return data;
  }
}

class Tags {
  int? id;
  String? tag;

  Tags({this.id, this.tag});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag'] = this.tag;
    return data;
  }
}
