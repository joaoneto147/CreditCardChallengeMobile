import 'package:credit_car_challenge/controllers/purchase_controller.dart';
import 'package:credit_car_challenge/widgets/item_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PurshasePage extends StatefulWidget {
  final int creditCardId;

  PurshasePage({Key key, this.creditCardId}) : super(key: key);

  @override
  _PurshasePageState createState() => _PurshasePageState();
}

class _PurshasePageState extends State<PurshasePage> {
  String _previousDate;

  @override
  Widget build(BuildContext context) {
    Provider.of<PurchasesController>(context, listen: false)
        .getPurchases(widget.creditCardId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Purchases",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Consumer<PurchasesController>(
              builder: (context, notifier, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,                  
                    children: <Widget>[
                      ItemMenuFilter(text: "Today", days: 1),
                      ItemMenuFilter(text: "Week", days: 7),
                      ItemMenuFilter(text: "Month", days: 30),
                      ItemMenuFilter(text: "3 Month", days: 90),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Consumer<PurchasesController>(
              builder: (context, notifier, child) {
                return Expanded(
                  child: notifier.purchases == null
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[  
                                getTitle(notifier.purchases[index].buyDate),                                
                                ItemList(
                                  title: notifier.purchases[index].storeName,
                                  subTitle: notifier.purchases[index].storeName,
                                  color: Colors.red,
                                  icon: Icon(Icons.shopping_basket),
                                  value:
                                      '+\$ ${notifier.purchases[index].value.toString()}',
                                ),
                              ],
                            );
                          },
                          itemCount: notifier.purchases.length,
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  getTitle(String dateTitle) {
    bool showTitle = _previousDate != dateTitle;    
    _previousDate = dateTitle;
    dateTitle = new DateFormat("MMMM d").format(DateTime.parse(dateTitle));
  
    return showTitle
        ? Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10), child: Text(dateTitle),)
        : Container();
  } 
}

class ItemMenuFilter extends StatelessWidget {
  final String text;
  final int days;

  ItemMenuFilter({Key key, this.text, this.days}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 60,
        height: 20,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        decoration: days ==
                Provider.of<PurchasesController>(context, listen: false)
                    .daysFilter
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.grey[600])
            : BoxDecoration(),
      ),
      onTap: () {
        Provider.of<PurchasesController>(context, listen: false)
            .setDaysFilter(days);
      },
    );
  }
}
