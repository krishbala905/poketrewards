// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// ` LOGIN`
  String get login {
    return Intl.message(
      ' LOGIN',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get lang_uage {
    return Intl.message(
      'Language',
      name: 'lang_uage',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN BY EMAIL`
  String get loginby {
    return Intl.message(
      'LOGIN BY EMAIL',
      name: 'loginby',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN WITH EMAIL`
  String get loginwith {
    return Intl.message(
      'LOGIN WITH EMAIL',
      name: 'loginwith',
      desc: '',
      args: [],
    );
  }

  /// `ENGLISH`
  String get english {
    return Intl.message(
      'ENGLISH',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more_appbar {
    return Intl.message(
      'More',
      name: 'more_appbar',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP WITH EMAIL`
  String get signupwithemail {
    return Intl.message(
      'SIGN UP WITH EMAIL',
      name: 'signupwithemail',
      desc: '',
      args: [],
    );
  }

  /// `CONNECT WITH FACEBOOK`
  String get connectwithfb {
    return Intl.message(
      'CONNECT WITH FACEBOOK',
      name: 'connectwithfb',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feed_back {
    return Intl.message(
      'Feedback',
      name: 'feed_back',
      desc: '',
      args: [],
    );
  }

  /// `Tell Your Friends`
  String get tell_your_friends {
    return Intl.message(
      'Tell Your Friends',
      name: 'tell_your_friends',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message(
      'Privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions `
  String get termsandconditions {
    return Intl.message(
      'Terms & Conditions ',
      name: 'termsandconditions',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe / Unsubscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe / Unsubscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Signout`
  String get signout {
    return Intl.message(
      'Signout',
      name: 'signout',
      desc: '',
      args: [],
    );
  }

  /// `By Signing you to agree the`
  String get Bysigningyoutoagreethe {
    return Intl.message(
      'By Signing you to agree the',
      name: 'Bysigningyoutoagreethe',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsofservice {
    return Intl.message(
      'Terms of Service',
      name: 'termsofservice',
      desc: '',
      args: [],
    );
  }

  /// `&`
  String get and {
    return Intl.message(
      '&',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// ` Privacy Policy`
  String get privacypolicy {
    return Intl.message(
      ' Privacy Policy',
      name: 'privacypolicy',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `E-wallet`
  String get e_wallet {
    return Intl.message(
      'E-wallet',
      name: 'e_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Whats On`
  String get whatson {
    return Intl.message(
      'Whats On',
      name: 'whatson',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notify {
    return Intl.message(
      'Notification',
      name: 'notify',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'cs'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
