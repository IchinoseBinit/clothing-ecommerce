class MerchantCartInfo {
  late final int merchantId;
  late final String name;
  late final String logo;
  late final int locationId;
  late final double minimumOrder;
  late final int maxBookingUpfrontSelfcollection;
  late final int maxBookingUpfrontDelivery;
  late final List<int> closingDays;
  late final List bookingOptionsList;
  late final List closingDates;

  MerchantCartInfo(
      {required this.bookingOptionsList,
      required this.closingDays,
      required this.merchantId,
      required this.locationId,
      required this.logo,
      required this.maxBookingUpfrontDelivery,
      required this.maxBookingUpfrontSelfcollection,
      required this.minimumOrder,
      required this.name,
      required this.closingDates});
}
