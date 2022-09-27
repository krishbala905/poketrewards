import 'dart:convert';


List<MerchantDataModel> MerchantDataModelFromJson(String str) =>
    List<MerchantDataModel>.from(json.decode(str).map((x) => MerchantDataModel.fromJson(x)));
String MerchantDataModelToJson(List<MerchantDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class MerchantDataModel {
  var merchant_id;
  var merchant_name;
  var merchant_logo;

  MerchantDataModel({
    required this.merchant_id,
    required this.merchant_name,
    required this.merchant_logo,
  });


  factory MerchantDataModel.fromJson(Map<String, dynamic> json) =>
      MerchantDataModel(
        merchant_id: json["merchant_id"],
        merchant_name: json["merchant_name"],
        merchant_logo: json["merchant_logo"],
      );

  Map<String, dynamic> toJson() =>
      {
        "merchant_name": merchant_name,
        "merchant_id": merchant_id,
        "merchant_logo": merchant_logo,
      };

}