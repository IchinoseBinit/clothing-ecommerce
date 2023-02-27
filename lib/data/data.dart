class IntroItem {
  final String title;
  final String icon;
  final String description;

  IntroItem(
      {required this.title, required this.icon, required this.description});
}

List<IntroItem> introItems = [
  IntroItem(
      title: "Welcome \n to RhinoPass",
      description:
          "Quick Commerce is the next-generation of e-commerce, and as the name suggests, it's all about speed and efficiency.",
      icon: "assets/intro1.png"),
  IntroItem(
      title: "Discover store \n near you",
      description:
          "We have simplified the process of finding merchants in your area by providing you with easy-to-use tools to locate nearby merchants.",
      icon: "assets/intro2.png"),
  IntroItem(
      title: "Order your \n favourites",
      description:
          "Explore the top deals and offers that are currently available in your local area.",
      icon: "assets/intro3.png"),
  IntroItem(
      title: "Pick Up or \n Delivery",
      description:
          "Our online ordering system is designed to be simple, fast, and efficient for your convenience.",
      icon: "assets/intro4.png"),
];
