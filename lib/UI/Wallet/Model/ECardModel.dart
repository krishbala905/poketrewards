import 'dart:convert';


List<ECardModel> eCardModelFromJson(String str) =>
    List<ECardModel>.from(json.decode(str).map((x) => ECardModel.fromJson(x)));
String ECardModelToJson(List<ECardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ECardModel {
  ECardModel({
    required this.expire_date,
    required this.program_id,
    required this.program_title,
    required this.img_url,
    required this.programExpiryDate,
    required this.program_type,
    required this.balance,
    required this.merchant_name,
    required this.member_id,
    required this.merchant_id,
    required this.country_index,
    required this.sub_type,
    required this.accept_status,
    required this.clickinformation,
    required this.purchase_date,
    required this.sent_to_friend,
    required this.img_url2,
    required this.LogoURL,
    required this.ProgramTitleSettings,
    required this.MerchantLogoSettings,
    required this.FontColor,

  });

  var expire_date;
  var program_id;
  var program_title;
  var img_url;
  var programExpiryDate;
  var program_type;
  var balance;
  var merchant_name;
  var member_id;
  var merchant_id;
  var country_index;
  var sub_type;
  var accept_status;
  var clickinformation;
  var purchase_date;
  var sent_to_friend;
  var img_url2;
  var LogoURL;
  var ProgramTitleSettings;
  var MerchantLogoSettings;
  var FontColor;


  factory ECardModel.fromJson(Map<String, dynamic> json) => ECardModel(
    program_id: json["program_id"],
    expire_date: json["expire_date"],
    program_title: json["program_title"],
    img_url: json["img_url"],
    programExpiryDate: json["programExpiryDate"],
    program_type: json["program_type"],
    balance: json["balance"],
    merchant_name: json["merchant_name"],
    member_id: json["member_id"],
    merchant_id: json["merchant_id"],
    country_index: json["country_index"],
    sub_type: json["sub_type"],
    accept_status: json["accept_status"],
    clickinformation: json["clickinformation"],
    purchase_date: json["purchase_date"],
    sent_to_friend: json["sent_to_friend"],
    img_url2: json["img_url2"],
    LogoURL: json["LogoURL"],
    ProgramTitleSettings: json["ProgramTitleSettings"],
    MerchantLogoSettings: json["MerchantLogoSettings"],
    FontColor: json["FontColor"],


  );

  Map<String, dynamic> toJson() => {
    "expire_date": expire_date,
    "program_id": program_id,
    "program_title": program_title,
    "img_url": img_url,
    "programExpiryDate": programExpiryDate,
    "program_type": program_type,
    "balance": balance,
    "merchant_name": merchant_name,
    "member_id": member_id,
    "merchant_id": merchant_id,
    "country_index": country_index,
    "sub_type": sub_type,
    "accept_status": accept_status,
    "clickinformation": clickinformation,
    "purchase_date": purchase_date,
    "sent_to_friend": sent_to_friend,
    "img_url2": img_url2,
    "LogoURL": LogoURL,
    "ProgramTitleSettings": ProgramTitleSettings,
    "MerchantLogoSettings": MerchantLogoSettings,
    "FontColor": FontColor,

  };


}