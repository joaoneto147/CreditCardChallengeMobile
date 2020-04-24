import 'package:credit_car_challenge/controllers/page_controller.dart';
import 'package:credit_car_challenge/model/credit_card_model.dart';
import 'package:credit_car_challenge/widgets/content_board.dart';
import 'package:credit_car_challenge/widgets/item_page.dart';
import 'package:credit_car_challenge/widgets/my_app_bar.dart';
import 'package:credit_car_challenge/widgets/panel_top.dart';
import 'package:credit_car_challenge/widgets/panel_top_two.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
    Provider.of<PageControllerApp>(context, listen: false).hideSheet();
    Provider.of<PageControllerApp>(context, listen: false).getCreditCardsUser();
  }

  var creditCard = CreditCard(
      holder: "Kraig C. Johnson",
      number: "XXXX XXXX XXXX XXXX",
      securityCode: 123);

  @override
  Widget build(BuildContext context) {
    Provider.of<PageControllerApp>(context, listen: false).hideSheet();
    Provider.of<PageControllerApp>(context, listen: false).getCreditCardsUser();
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Consumer<PageControllerApp>(
            builder: (context, notifier, child) => AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: notifier.spec >= 0.8 ? 0 : 1,
              child: MyAppBar(),
            ),
          ),
          PanelTop(),
          PanelTopTwo(),
          Consumer<PageControllerApp>(
            builder: (context, notifier, child) => notifier.creditCardsUser ==
                    null
                ? Center(child: CircularProgressIndicator())
                : Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.12),
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).size.height * 0.12 -
                        MediaQuery.of(context).padding.top,
                    child: PageView.builder(
                      physics:
                          Provider.of<PageControllerApp>(context, listen: false)
                                      .currentIndex !=
                                  -1
                              ? NeverScrollableScrollPhysics()
                              : BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        Provider.of<PageControllerApp>(context, listen: false)
                            .setPageIndex(index);
                      },
                      controller: _pageController,
                      itemBuilder: (context, position) {
                        return ItemPage(
                          creditCard: notifier.creditCardsUser[position],
                          index: position,
                          color: Colors.pink,
                          imageURL:
                              'https://us.123rf.com/450wm/grebeshkovmaxim/grebeshkovmaxim1805/grebeshkovmaxim180500202/100769321-colorful-smooth-gradient-color-background-design-for-your-project-design-.jpg?ver=6',
                          operadoraURL:
                              'https://1000marcas.net/wp-content/uploads/2019/12/MasterCard-Logo.png',
                        );
                      },
                      itemCount: notifier.creditCardsUser.length,
                    ),
                  ),
          ),
          Consumer<PageControllerApp>(
            builder: (context, value, child) {
              bool isHide =
                  Provider.of<PageControllerApp>(context, listen: false).isHide;
              return AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: isHide ? 0 : 1,
                child: SlidingSheet(
                  elevation: 1,
                  cornerRadius: 3,
                  listener: (state) {
                    Provider.of<PageControllerApp>(context, listen: false)
                        .setState(state);
                    Provider.of<PageControllerApp>(context, listen: false)
                        .setProgress(state.progress);
                  },
                  color: ThemeData.dark().primaryColor,
                  controller:
                      Provider.of<PageControllerApp>(context, listen: false)
                          .sheetController,
                  snapSpec: SnapSpec(
                    snap: true,
                    snappings: [0.35, 1.0, 1.0],
                    positioning: SnapPositioning.relativeToSheetHeight,
                  ),
                  builder: (context, state) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.height * 0.035,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: GestureDetector(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Dashboard",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(getIconSheet(value.sheetController))
                                  ],
                                ),
                                onTap: () {
                                  if (value.sheetController.state != null &&
                                      value.sheetController.state.extent > 0.80)
                                    value.sheetController.collapse();
                                  else
                                    value.sheetController.expand();
                                },
                              ),
                            ),
                            Consumer<PageControllerApp>(
                                builder: (context, notifier, child) {
                              return ContentBoard(
                                  creditCardId: notifier.creditCardsUser == null ? 0 : notifier
                                      .creditCardsUser[notifier.index].id);
                            })
                          ],
                        ));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData getIconSheet(SheetController sheetController) {
    IconData iconReturn;
    if (sheetController.state == null) {
      iconReturn = Icons.keyboard_arrow_up;
    } else {
      if (sheetController.state.extent < 0.80)
        iconReturn = Icons.keyboard_arrow_up;
      else
        iconReturn = Icons.keyboard_arrow_down;
    }

    return iconReturn;
  }
}
