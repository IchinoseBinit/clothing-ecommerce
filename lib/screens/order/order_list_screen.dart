import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  OrderListScreenState createState() => OrderListScreenState();
}

class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  NewItem(
      {required this.isExpanded,
      required this.header,
      required this.body,
      required this.iconpic});
}

class OrderListScreenState extends State<OrderListScreen> {
  List<NewItem> items = <NewItem>[
    for (int i = 0; i < 10; i++)
      NewItem(
          isExpanded: false, // isExpanded ?
          header: '#${i}QWEGI1EHU22US', // header
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Demin Tshirt * 2", style: bodyText),
              SizedBox(
                height: 2.h,
              ),
              Text("New Fashain Pant * 3", style: bodyText),
              SizedBox(
                height: 2.h,
              ),
              const Divider(),
              SizedBox(
                height: 2.h,
              ),
              Text("Shipping Cost: 65", style: bodyText),
              SizedBox(
                height: 2.h,
              ),
              Text("Sub Total: Rs.3000", style: bodyText),
              SizedBox(
                height: 2.h,
              ),
              Text("Total: Rs.3065", style: bodyText),
            ],
          ), // body
          iconpic: const Icon(Icons.list_alt_outlined) // iconPic
          ),
  ];
  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = Scaffold(
      appBar: CustomAppBar(
        title: "Order",
        disableLeading: true,
      ),
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingLg),
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  items[index].isExpanded = !items[index].isExpanded;
                });
              },
              children: items.map((NewItem item) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                        leading: item.iconpic,
                        title: Text(
                          item.header,
                          textAlign: TextAlign.left,
                          style:
                              subTitleText.copyWith(fontWeight: FontWeight.w500),
                        ));
                  },
                  isExpanded: item.isExpanded,
                  body: Padding(
                    padding: const EdgeInsets.only(
                      left: AppSizes.paddingLg,
                      right: AppSizes.paddingLg,
                      bottom: AppSizes.paddingLg,
                    ),
                    child: item.body,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
    return scaffold;
  }
}
