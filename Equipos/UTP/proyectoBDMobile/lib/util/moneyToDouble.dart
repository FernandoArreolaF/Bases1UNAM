double moneyToDouble(String money){
  String newString = money.substring(1);
  return double.parse(newString);
}