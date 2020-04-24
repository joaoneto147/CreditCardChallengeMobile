import 'package:community_material_icon/community_material_icon.dart';
import 'package:credit_car_challenge/controllers/credit_card_controller.dart';
import 'package:credit_car_challenge/controllers/page_controller.dart';
import 'package:credit_car_challenge/controllers/purchase_controller.dart';
import 'package:credit_car_challenge/pages/credit_card_add.dart';
import 'package:credit_car_challenge/pages/purchase_add_page.dart';
import 'package:credit_car_challenge/pages/purchase_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item_dashboard.dart';

class ContentBoard extends StatelessWidget {
  final int creditCardId;

  const ContentBoard({Key key, this.creditCardId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ItemDashboard(
                iconData: Icons.add_shopping_cart,
                textItem: "Purchase",
                colorItem: Colors.lightGreen,
                callback: () => showDialog(
                  context: context,
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => PurchasesController(),
                    child: AlertDialog(
                      content: PurchaseAdd(),
                      elevation: 5,
                      backgroundColor: Colors.black,
                      contentPadding: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ItemDashboard(
                iconData: CommunityMaterialIcons.credit_card_plus,
                textItem: "Card",
                colorItem: Colors.orange[800],
                callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => CreditCardController(),
                        ),
                        ChangeNotifierProvider(
                            create: (context) => PageControllerApp())
                      ],
                      child: CreditCardAdd(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ItemDashboard(
                iconData: CommunityMaterialIcons.shopping,
                textItem: "Latest purchases",
                colorItem: Colors.deepPurple,
                callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => PurchasesController(),
                      child: PurshasePage(
                        creditCardId: creditCardId,
                      ),
                    ),
                  ),
                ),
              ),
              ItemDashboard(
                  iconData: CommunityMaterialIcons.poll,
                  textItem: "Spending chart"),
            ],
          )
        ],
      ),
    );
  }
}
