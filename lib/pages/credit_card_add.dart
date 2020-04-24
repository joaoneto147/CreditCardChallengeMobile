import 'dart:math';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:credit_car_challenge/commons/conts/functions.dart';
import 'package:credit_car_challenge/controllers/credit_card_controller.dart';
import 'package:credit_car_challenge/framework/flip_card.dart';
import 'package:credit_car_challenge/model/credit_card_model.dart';
import 'package:credit_car_challenge/widgets/item_page.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class CreditCardAdd extends StatefulWidget {
  @override
  _CreditCardAddState createState() => _CreditCardAddState();
}

class _CreditCardAddState extends State<CreditCardAdd> {
  var isFlipped = false;
  var angle = 2.0;

  var creditCard = CreditCard(
      holder: "Your name", number: "XXXX XXXX XXXX XXXX", securityCode: 000);

  var _numberCardController = TextEditingController();
  var _holderController = TextEditingController();
  var _securityCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Transform.rotate(
                  angle: pi / 2,
                  child: Center(
                    child: Container(
                      height: 370,
                      width: 300,
                      child: FlippableBox(
                        front: FrontCard(
                          creditCard: creditCard,
                          operadoraURL:
                              "https://1000marcas.net/wp-content/uploads/2019/12/MasterCard-Logo.png",
                          imageURL:
                              "https://us.123rf.com/450wm/grebeshkovmaxim/grebeshkovmaxim1805/grebeshkovmaxim180500202/100769321-colorful-smooth-gradient-color-background-design-for-your-project-design-.jpg?ver=6",
                          color: Colors.pink,
                        ),
                        back: BackCard(
                          Colors.pink,
                          creditCard: creditCard,
                        ),
                        isFlipped: isFlipped,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    isFlipped = !isFlipped;
                    angle = angle == 2.0 ? 1.0 : 2.0;
                  });
                },
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 240,
                    child: TextFormField(
                      autofocus: false,
                      controller: _numberCardController,
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                      decoration: InputDecoration(
                        prefixIcon: Icon(CommunityMaterialIcons.card_bulleted),
                        contentPadding: EdgeInsets.zero,
                        labelText: "Number",
                      ),
                      style: TextStyle(fontSize: 20),
                      onChanged: (_controller) {
                        setState(() {
                          creditCard.number =
                              formatterCreditCardNumber(_controller.toString());
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: TextFormField(
                      autofocus: false,
                      controller: _securityCodeController,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      decoration: InputDecoration(
                          prefixIcon:
                              Icon(CommunityMaterialIcons.card_bulleted),
                          contentPadding: EdgeInsets.zero,
                          labelText: "S.Code"),
                      style: TextStyle(fontSize: 20),
                      onChanged: (_controller) {
                        setState(() {
                          creditCard.securityCode = int.parse(_controller);
                        });
                      },
                    ),
                  )
                ],
              ),
              TextFormField(
                autofocus: false,
                maxLengthEnforced: true,
                controller: _holderController,
                keyboardType: TextInputType.text,
                maxLength: 21,
                decoration: InputDecoration(
                  prefixIcon: Icon(CommunityMaterialIcons.card_bulleted),
                  contentPadding: EdgeInsets.zero,
                  hintText: "Holder",
                ),
                style: TextStyle(fontSize: 20),
                onChanged: (_controller) {
                  setState(() {
                    creditCard.holder = _controller.toString();
                  });
                },
              ),
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.5],
                    colors: [
                      Colors.deepPurple,
                      Colors.purple,
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Save card",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Icon(CommunityMaterialIcons.credit_card_plus,
                          color: Colors.white, size: 35),
                    ],
                  ),
                  onPressed: () => saveCreditCard(
                    context,
                    new CreditCard(
                      flag: "MasterCard",
                      number: _numberCardController.text,
                      holder: _holderController.text,
                      limit: 15000,
                      securityCode: int.parse(_securityCodeController.text),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  saveCreditCard(context, newCreditCard) async {
    CreditCard creditCard =
        await Provider.of<CreditCardController>(context, listen: false)
            .addCreditCard(newCreditCard);

    showToast(
        Provider.of<CreditCardController>(context, listen: false).responseAddCreditCard,
        position: ToastPosition.top);

    if (creditCard != null)       
      Navigator.pop(context);  
  }
}
