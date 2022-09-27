import 'dart:convert';
List<Headerdata> HeaderdataFromJson(String str) =>
    List<Headerdata>.from(json.decode(str).map((x) => Headerdata.fromJson(x)));
String ECardModelToJson(List<Headerdata> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Headerdata {
  var HeaderImage;
  var HeaderText;
  var consumerid;

  Headerdata({
    required this.HeaderImage,
    required this.HeaderText,
    required this.consumerid,
  });

  factory Headerdata.fromJson(Map<String, dynamic> json) =>
      Headerdata(
        HeaderImage: json["HeaderImage"],
        HeaderText: json["HeaderText"],
        consumerid: json["consumer_id"],


      );

  Map<String, dynamic> toJson() =>
      {
        "HeaderImage": HeaderImage,
        "HeaderText": HeaderText,
        "consumerid": consumerid,
      };
}