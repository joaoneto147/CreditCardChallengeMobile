import 'package:credit_car_challenge/controllers/credit_card_controller.dart';
import 'package:credit_car_challenge/model/credit_card_model.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PageControllerApp extends ChangeNotifier {
  int _index = 0;
  int _currentIndex = -1;
  bool _isFlipped = false;
  double _progress = 0;
  double _spec = 0.2;
  SheetState _sheetState;
  bool _isHide = false;
  
  List<CreditCard> _creditCardsUser;

  final SheetController _sheetController = SheetController();

  PageControllerApp() {
    _sheetController.hide();
  }

  bool get isHide => _isHide;
  double get progress => _progress;
  double get spec => _spec;
  SheetState get sheetState => _sheetState;

  int get index => _index;
  int get currentIndex => _currentIndex;
  bool get isFlipped => _isFlipped;
  SheetController get sheetController => _sheetController;
  List<CreditCard> get creditCardsUser => _creditCardsUser;

  setPageIndex(int value) {
    _index = value;
    notifyListeners();
  }

  setCurrentIndex(int value) {
    _currentIndex = value;
    if (_currentIndex == -1) {
      _isFlipped = false;
    }
    notifyListeners();
  }

  setisFlipped(bool value) {
    _isFlipped = value;
    notifyListeners();
  }

  setProgress(double value) {
    _progress = value;
    notifyListeners();
  }

  setState(SheetState value) {
    _sheetState = value;
    if (_sheetState.isHidden) {
      setCurrentIndex(-1);
    }
    _spec = _sheetState.extent;      
    notifyListeners();
  }

  hideSheet() async {
    await _sheetController.hide();
    _isHide = true;
    notifyListeners();
  }

  showSheet() async {
    _isHide = false;  
    await _sheetController.show();
    notifyListeners(); 
  }

  getCreditCardsUser() async{
    var creditCardController = CreditCardController();
    _creditCardsUser = await creditCardController.getCreditCards();
    notifyListeners();
  }

  // addCreditCardsUser(CreditCard creditCard){
  //   _creditCardsUser = _creditCardsUser ?? List<CreditCard>();
  //   _creditCardsUser.add(creditCard);
  //   notifyListeners();
  // }
}
