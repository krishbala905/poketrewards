import 'dart:convert';


List<ServiceInitModel> ServiceInitModelFromJson(String str) =>
    List<ServiceInitModel>.from(json.decode(str).map((x) => ServiceInitModel.fromJson(x)));
String ServiceInitModelToJson(List<ServiceInitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ServiceInitModel {
  ServiceInitModel({
    required this.merchantId,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryDescription,
    required this.categoryfile,
    required this.displayLabel,
    required this.details,
    required this.errorMessage,
    required this.subCount,
  });

  var merchantId;
  var categoryName;
  var categoryImage;
  var categoryDescription;
  var categoryfile;
  var displayLabel;
  var details;
  var errorMessage;
  var subCount;


  factory ServiceInitModel.fromJson(Map<String, dynamic> json) => ServiceInitModel(
    merchantId: json["merchant_id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    categoryDescription: json["category_description"],
    categoryfile: json["category_file"],
    displayLabel: json["displaylabel"],
    details: json["details"],
    errorMessage: json["errormessage"],
    subCount: json["sub_count"],

  );

  Map<String, dynamic> toJson() => {
    "merchant_id": merchantId,
    "category_name": categoryName,
    "category_image": categoryImage,
    "category_description": categoryDescription,
    "category_file": categoryfile,
    "displaylabel": displayLabel,
    "details": details,
    "errormessage": errorMessage,
    "sub_count": subCount,



  };


}