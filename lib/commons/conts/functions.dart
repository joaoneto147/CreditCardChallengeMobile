formatterCreditCardNumber(String creditCardNumber){
  var creditCardNumberReturn = "";
  for (var i = 0; i < creditCardNumber.length; i++) {
    if (i == 4 || i == 8 || i == 12)
      creditCardNumberReturn += "   ";

    creditCardNumberReturn += creditCardNumber[i];
  }

  return creditCardNumberReturn;
}