import 'dart:convert';


List<ECardRewardsModel> eCardRewardsModelFromJson(String str) =>
    List<ECardRewardsModel>.from(json.decode(str).map((x) => ECardRewardsModel.fromJson(x)));
String ECardRewardsModelToJson(List<ECardRewardsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ECardRewardsModel {
  ECardRewardsModel({
    required this.program_id,
    required this.program_title,
    required this.img_url,
    required this.vctnc,
    required this.vcDescription,
    required this.MerchantLogoSettings,
    required this.ProgramTitleSettings,
    required this.LogoURL,
    required this.FontColor,
    required this.amt_to_purchase,
  });

  var program_id;
  var program_title;
  var img_url;
  var vctnc;
  var vcDescription;
  var MerchantLogoSettings;
  var ProgramTitleSettings;
  var LogoURL;
  var FontColor;
  var amt_to_purchase;


  factory ECardRewardsModel.fromJson(Map<String, dynamic> json) => ECardRewardsModel(
    program_id: json["program_id"],
    program_title: json["program_title"],
    img_url: json["img_url"],
    vctnc: json["vctnc"],
    vcDescription: json["vcDescription"],
    MerchantLogoSettings: json["MerchantLogoSettings"],
    ProgramTitleSettings: json["ProgramTitleSettings"],
    LogoURL: json["LogoURL"],
    FontColor: json["FontColor"],
    amt_to_purchase: json["amt_to_purchase"],

  );

  Map<String, dynamic> toJson() => {
    "program_id": program_id,
    "program_title": program_title,
    "img_url": img_url,
    "vctnc": vctnc,
    "vcDescription": vcDescription,
    "MerchantLogoSettings": MerchantLogoSettings,
    "ProgramTitleSettings": ProgramTitleSettings,
    "LogoURL": LogoURL,
    "FontColor": FontColor,
    "amt_to_purchase":amt_to_purchase,



  };


}