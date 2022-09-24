import 'dart:convert';

import 'package:poketrewards/UI/Wallet/Ecards/ECardRewardsModel.dart';
import 'package:poketrewards/UI/Wallet/Model/ECardDetailsLocationModel.dart';
import 'package:poketrewards/UI/Wallet/Model/ECardDetailsModel.dart';


class ECardAllDetailsModel {
  List<ECardRewardsModel> Rewards;
  List<ECardDetailsModel> CardData;
  List<ECardDetailsLocationModel> Locations;
  var AboutUs;


  ECardAllDetailsModel({

    required this.Rewards,
    required this.CardData,
    required this.Locations,
    required this.AboutUs,
  });





  factory ECardAllDetailsModel.fromJson(Map<String, dynamic> json) => ECardAllDetailsModel(
    Rewards: json["Rewards"],
    CardData: json["CardData"],
    Locations: json["Locations"],
    AboutUs: json["AboutUs"],

  );

  Map<String, dynamic> toJson() => {
    "Rewards": Rewards,
    "CardData": CardData,
    "Locations": Locations,
    "AboutUs": AboutUs,
  };


}