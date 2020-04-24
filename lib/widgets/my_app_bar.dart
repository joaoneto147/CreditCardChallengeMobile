import 'package:community_material_icon/community_material_icon.dart';
import 'package:credit_car_challenge/controllers/credit_card_controller.dart';
import 'package:credit_car_challenge/controllers/page_controller.dart';
import 'package:credit_car_challenge/pages/credit_card_add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08 +
          MediaQuery.of(context).padding.top,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                Provider.of<PageControllerApp>(context, listen: false)
                    .setCurrentIndex(-1);
                await Provider.of<PageControllerApp>(context, listen: false)
                    .hideSheet();
              },
            ),
            IconButton(
              icon: Icon(CommunityMaterialIcons.credit_card_plus),
              onPressed: () {
                Navigator.push(
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
