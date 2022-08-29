import 'package:flutter/cupertino.dart';


import 'CommonUtils.dart';

class LanguageChangeProvider with ChangeNotifier{

  Locale _currentLocale = new Locale(CommonUtils.APPLICATIONLANGUAGECOUNTRY.toString());
  Locale get currentLocale => _currentLocale;

  Future<void> changeLocale (String _locale) async {
    this._currentLocale = new Locale(_locale);
    notifyListeners();

  }

}