
class Urls {
  static const bool staging = false;
  static const String mainUrl = staging
      ? "https://myfood.indulgemall.com/"
      : "https://myfood.indulgemall.com/";
  static const String merchantListing = "${mainUrl}country/nepal";
  static const String merchantUrl = "${mainUrl}country";
  static const String profileUrl = "${mainUrl}customers/profile/";
  static const String orderUrl = "${mainUrl}customers/orders/";
  static const String loginUrl = "${mainUrl}customers/login";
  static const String registerUrl = "${mainUrl}customers/signup";
  static const String lostpasswordUrl = "${mainUrl}accounts/password/reset/";
  static const String rhinoUrl = "https://rhinopass.com/";

 
}
