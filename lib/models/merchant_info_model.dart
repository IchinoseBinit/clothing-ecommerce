import '/data/extensions/decimal_round_off.dart';

class MerchantInfoModel {
  MerchantInfoModel({
    required this.id,
    required this.name,
    required this.businessType,
    required this.contactNumber,
    required this.registrationNo,
    required this.domain,
    required this.tax,
    required this.commission,
    required this.isActive,
    required this.locations,
    required this.closingDates,
  });
  late final int id;
  late final String name;
  late final String businessType;
  late final String contactNumber;
  late final String registrationNo;
  late final String domain;
  late final String key;
  late final String tax;
  late final String commission;
  late final bool isActive;
  late final List<Locations> locations;
  late final ClosingDates closingDates;

  MerchantInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    businessType = json['business_type'];
    contactNumber = json['contact_number'];
    registrationNo = json['registration_no'];
    domain = json['domain'];
    key = json['key'];
    tax = json['tax'];
    commission = json['commission'];
    isActive = json['is_active'];
    locations =
        List.from(json['locations']).map((e) => Locations.fromJson(e)).toList();
    closingDates = ClosingDates.fromJson(json['closing_dates']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['business_type'] = businessType;
    _data['contact_number'] = contactNumber;
    _data['registration_no'] = registrationNo;
    _data['domain'] = domain;
    _data['key'] = key;
    _data['tax'] = tax;
    _data['commission'] = commission;
    _data['is_active'] = isActive;
    _data['locations'] = locations.map((e) => e.toJson()).toList();
    _data['closing_dates'] = closingDates.toJson();
    return _data;
  }
}

class Locations {
  Locations({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.contactEmail,
    required this.city,
    required this.postalCode,
    required this.state,
    required this.country,
    required this.timezone,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.address,
    required this.currency,
    required this.website,
    required this.main,
    required this.logo,
    required this.locationCode,
    required this.firstDayOfWeek,
    required this.minBookingInAdvanceSelfcollection,
    required this.maxBookingUpfrontSelfcollection,
    required this.minBookingInAdvanceDelivery,
    required this.maxBookingUpfrontDelivery,
    required this.closingDays,
    required this.notificationEmail,
    required this.notificationMobile,
    required this.bookingOptions,
    required this.minimumOrder,
    required this.bookingUrl,
    required this.tags,
    required this.banner,
    this.bookingOptionsList,
  });
  late final int id;
  late final String name;
  late final String contactNumber;
  late final String contactEmail;
  late final String city;
  late final String postalCode;
  late final String state;
  late final String country;
  late final String timezone;
  late final String latitude;
  late final String longitude;
  late final String location;
  late final String address;
  late final String currency;
  late final String website;
  late final bool main;
  late final String logo;
  late final String locationCode;
  late final int firstDayOfWeek;
  late final int minBookingInAdvanceSelfcollection;
  late final int maxBookingUpfrontSelfcollection;
  late final int minBookingInAdvanceDelivery;
  late final int maxBookingUpfrontDelivery;
  late final List<int> closingDays;
  late final String notificationEmail;
  late final String notificationMobile;
  late final BookingOptions bookingOptions;
  late final List? bookingOptionsList;
  late final double minimumOrder;
  late final String bookingUrl;
  late final List<Tags> tags;
  late final String banner;

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    logo = json['logo'] == null ? "" : json["logo"];
    banner = json["banner"] ?? "";
    locationCode = json['location_code'];
    firstDayOfWeek = json['first_day_of_week'];
    minBookingInAdvanceSelfcollection =
        json['min_booking_in_advance_selfcollection'];
    maxBookingUpfrontSelfcollection =
        json['max_booking_upfront_selfcollection'];
    minBookingInAdvanceDelivery = json['min_booking_in_advance_delivery'];
    maxBookingUpfrontDelivery = json['max_booking_upfront_delivery'];
    closingDays = List.castFrom<dynamic, int>(json['closing_days']);
    notificationEmail = json['notification_email'];
    notificationMobile = json['notification_mobile'];
    bookingOptions = json['booking_options'] != null
        ? BookingOptions.fromJson(json['booking_options'])
        : BookingOptions(selfCollection: "", delivery: "");
    minimumOrder = parseDoubleToFixedPrecision(json['minimum_order']);
    bookingUrl = json['booking_url'];
    bookingOptionsList = json['booking_options'] != null
        ? ((json['booking_options']) as Map).values.toList()
        : [];
    bookingOptionsList!.sort((a, b) => a.toString().compareTo(b.toString()));
    tags = List.from(json['tags']).map((e) => Tags.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['contact_number'] = contactNumber;
    _data['contact_email'] = contactEmail;
    _data['city'] = city;
    _data['postal_code'] = postalCode;
    _data['state'] = state;
    _data['country'] = country;
    _data['timezone'] = timezone;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['location'] = location;
    _data['address'] = address;
    _data['currency'] = currency;
    _data['website'] = website;
    _data['main'] = main;
    _data['logo'] = logo;
    _data['location_code'] = locationCode;
    _data['first_day_of_week'] = firstDayOfWeek;
    _data['min_booking_in_advance_selfcollection'] =
        minBookingInAdvanceSelfcollection;
    _data['max_booking_upfront_selfcollection'] =
        maxBookingUpfrontSelfcollection;
    _data['min_booking_in_advance_delivery'] = minBookingInAdvanceDelivery;
    _data['max_booking_upfront_delivery'] = maxBookingUpfrontDelivery;
    _data['closing_days'] = closingDays;
    _data['notification_email'] = notificationEmail;
    _data['notification_mobile'] = notificationMobile;
    _data['booking_options'] = bookingOptions.toJson();
    _data['minimum_order'] = minimumOrder;
    _data['booking_url'] = bookingUrl;
    _data['tags'] = tags.map((e) => e.toJson()).toList();
    return _data;
  }
}

class BookingOptions {
  BookingOptions({
    required this.selfCollection,
    required this.delivery,
  });
  late final String selfCollection;
  late final String delivery;

  BookingOptions.fromJson(Map<String, dynamic> json) {
    selfCollection = json['self_collection'] ?? "";
    delivery = json['delivery'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['self_collection'] = selfCollection;
    _data['delivery'] = delivery;
    return _data;
  }
}

class Tags {
  Tags({
    required this.id,
    required this.tag,
  });
  late final int id;
  late final String tag;

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['tag'] = tag;
    return _data;
  }
}

class ClosingDates {
  ClosingDates({
    required this.selfCollection,
    required this.delivery,
  });
  late final List<dynamic> selfCollection;
  late final List<dynamic> delivery;

  ClosingDates.fromJson(Map<String, dynamic> json) {
    selfCollection = List.castFrom<dynamic, dynamic>(json['self_collection']);
    delivery = List.castFrom<dynamic, dynamic>(json['delivery']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['self_collection'] = selfCollection;
    _data['delivery'] = delivery;
    return _data;
  }
}
