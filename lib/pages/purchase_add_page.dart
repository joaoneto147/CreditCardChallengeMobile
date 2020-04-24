import 'package:community_material_icon/community_material_icon.dart';
import 'package:credit_car_challenge/controllers/purchase_controller.dart';
import 'package:credit_car_challenge/model/purchase_model.dart';
import 'package:credit_car_challenge/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseAdd extends StatelessWidget {
  final _storeNameController = TextEditingController();
  final _buyDateController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = Provider.of<PurchasesController>(context);
    return MediaQuery.removeViewInsets(
      context: context,
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      child: Container(
        height: 200,
        width: 400,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: MyCustomTextFormField(
                  icon: Icon(CommunityMaterialIcons.shopping),
                  hint: "Store name",
                  controller: _storeNameController,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: MyCustomTextFormField(
                      icon: Icon(CommunityMaterialIcons.calendar_search),
                      hint: "Buy date",
                      controller: _buyDateController,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 2,
                    child: MyCustomTextFormField(
                      icon: Icon(CommunityMaterialIcons.coin),
                      hint: "Value",
                      controller: _buyDateController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MyCustomButton(
                    textButton: "Add",
                    iconButton: Icons.add_circle,
                    colorButton: Colors.green,
                    callback: () => addPurshase(
                      purchaseProvider,
                      Purchase(
                        buyDate: _buyDateController.text,
                        creditCardId: 2,
                        value: double.tryParse(_valueController.text),
                        storeName: _storeNameController.text,
                      ),
                    ),
                  ),
                  MyCustomButton(
                    textButton: "Cancel",
                    iconButton: Icons.cancel,
                    colorButton: Colors.red,
                    callback: () => cancel(context),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void addPurshase(PurchasesController purchaseProvider, Purchase purchase) async {
    // var result = await Provider.of<PurchasesController>(context, listen: false)
    //     .addPurchase(purchase);

    var result = await purchaseProvider.addPurchase(purchase);

    if (result) {}
  }

  void cancel(context) {
    Navigator.of(context).pop();
  }
}

class MyCustomButton extends StatelessWidget {
  final String textButton;
  final IconData iconButton;
  final Color colorButton;
  final VoidCallback callback;

  const MyCustomButton(
      {Key key,
      this.textButton,
      this.iconButton,
      this.colorButton,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: colorButton,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              textButton,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            Icon(iconButton, color: Colors.white, size: 35),
          ],
        ),
        onPressed: callback,
      ),
    );
  }
}
