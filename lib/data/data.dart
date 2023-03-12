import 'package:clothing_ecommerce/data/constants/image_constants.dart';

class IntroItem {
  final String title;
  final String icon;
  final String description;

  IntroItem(
      {required this.title, required this.icon, required this.description});
}

List<IntroItem> introItems = [
  IntroItem(
      title: "Select Items",
      description:
          "Explore the top deals and offers that are currently available in your local area..",
      icon: intro1
      ),
  IntroItem(
      title: "Purchase",
      description:
          "Purchase your product using online payment services or you can cash on delivery.",
      icon: intro2),
  IntroItem(
      title: "Delivery",
      description:
          "Our online ordering system is designed to be simple, fast, and efficient for your convenience.",
      icon: intro3),
];
