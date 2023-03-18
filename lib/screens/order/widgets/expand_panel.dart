import 'package:clothing_ecommerce/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class Expansionpanel extends StatefulWidget {
  Expansionpaneltate createState() => Expansionpaneltate();
}

class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  NewItem(this.isExpanded, this.header, this.body, this.iconpic);
}

class Expansionpaneltate extends State<Expansionpanel> {
  List<NewItem> items = <NewItem>[
    NewItem(
        false, // isExpanded ?
        '#d12d3i32dq3i', // header
        Row(children: <Widget>[Text("Demin Tshirt")]), // body
        const Icon(Icons.list_alt_outlined) // iconPic
        ),
  ];
  late ListView List_Criteria;
  Widget build(BuildContext context) {
    List_Criteria = ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((NewItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                      leading: item.iconpic,
                      title: Text(
                        item.header,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ));
                },
                isExpanded: item.isExpanded,
                body: Padding(
                    padding: const EdgeInsets.all(20.0),
                  child: item.body),
              );
            }).toList(),
          ),
        ),
      ],
    );
    Scaffold scaffold = Scaffold(
      appBar: CustomAppBar(
        title: "Order",
        disableLeading:true,
      ),
      body: List_Criteria,
    );
    return scaffold;
  }
}
