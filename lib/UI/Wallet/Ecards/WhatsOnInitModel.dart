import 'dart:convert';


List<WhatsOnInitModel> whatsOnInitModelFromJson(String str) =>
    List<WhatsOnInitModel>.from(json.decode(str).map((x) => WhatsOnInitModel.fromJson(x)));
String WhatsOnInitModelToJson(List<WhatsOnInitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class WhatsOnInitModel {
  WhatsOnInitModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryAction,
    required this.bannerType,
    required this.displayLabel,
    required this.details,
    required this.errorMessage,
    required this.subCount,
  });

  var categoryId;
  var categoryName;
  var categoryImage;
  var categoryAction;
  var bannerType;
  var displayLabel;
  var details;
  var errorMessage;
  var subCount;


  factory WhatsOnInitModel.fromJson(Map<String, dynamic> json) => WhatsOnInitModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    categoryAction: json["category_action"],
    bannerType: json["bannertype"],
    displayLabel: json["displaylabel"],
    details: json["details"],
    errorMessage: json["errormessage"],
    subCount: json["sub_count"],

  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_image": categoryImage,
    "category_action": categoryAction,
    "bannertype": bannerType,
    "displaylabel": displayLabel,
    "details": details,
    "errormessage": errorMessage,
    "sub_count": subCount,



  };


}