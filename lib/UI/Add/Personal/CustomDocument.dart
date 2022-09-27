import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:poketrewards/Others/AlertDialogUtil.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/Others/Utils.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:http/http.dart' as http;

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:xml2json/xml2json.dart';


class Customdocument extends StatefulWidget {
  const Customdocument({Key? key}) : super(key: key);

  @override
  State<Customdocument> createState() => _CustomdocumentState();
}

class _CustomdocumentState extends State<Customdocument> {

  TextEditingController ImgNameTxt = TextEditingController();
  TextEditingController PurchaseDate = TextEditingController();
  TextEditingController ExpireDate = TextEditingController();
  TextEditingController RemainderDate = TextEditingController();
  TextEditingController ReminderNotes = TextEditingController();


  File?FristImage;
  String? imagedata;

  Future OpenGalley() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      final imagetemp = File(image.path);
      //Upload(imagetemp);
      final bytes = Uint8List.fromList(imagetemp.readAsBytesSync());

    //  print(imagetemp.absolute.readAsStringSync());
      // print(image.mimeType);`
      setState(() {
        this.FristImage = imagetemp;
        this.imagedata = base64Encode(imagetemp.readAsBytesSync());
      });
    } on PlatformException catch (e) {
      print('failed : $e');
    }
  }

  Future OpenCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imagetemp = File(image.path);
      setState(() {
        this.FristImage = imagetemp;
        //Upload(imagetemp);
      });
    } on PlatformException catch (e) {
      print('failed : $e');
    }
  }


  Future<ImageSource?> showImgSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context, builder: (context) =>
          CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text(camera),
                onPressed: () {
                  OpenCamera();
                  Navigator.of(context).pop();
                },
              ),
              CupertinoActionSheetAction(
                child: Text(gallery),
                onPressed: () {
                  OpenGalley();
                  Navigator.of(context).pop();
                },
              ),


            ],
          ),
      );
    }
    else {
      showModalBottomSheet(context: context, builder: (context) {
        return Column(
          children: [
            ListTile(
              onTap: () {
                OpenCamera();
                Navigator.of(context).pop();
              },
              title: const Text(camera),
            ),
            ListTile(
              onTap: () {
                OpenGalley();
                Navigator.of(context).pop();
              },
              title: const Text(gallery),
            ),

          ],
        );
      },);
    }
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Custom Document"),
        backgroundColor: PoketNormalGreen,),
      body: Column(
        children: [
          Expanded(child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(

                  decoration: BoxDecoration(
                    color: Colors.white,

                    border: Border.all(color: lightGrey),
                  ),
                  height: 200,
                  width: 350,
                  child: FristImage != null ?

                  // Image.file(FristImage!,fit: BoxFit.fill,)
                  ClipRRect(

                      child: Image.file(FristImage!, fit: BoxFit.fill,)
                  )

                      : GestureDetector(
                    onTap: () {
                      showImgSource(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/Camera_icon.png', color: PoketNormalGreen,
                          width: 25,),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Tap to add a Image", style: TextStyle(
                          fontSize: 16,
                          color: PoketNormalGreen,
                        ),)
                      ],
                    ),
                  ),


                ),


              ),
              SizedBox(
                height: 20,
              ),
              Row(


                children: [

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text("Image Name*", style: TextStyle(
                        color: DarkGrey, fontSize: 16,
                      ),),
                    ),
                    flex: 5,
                  ),

                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right: 40, bottom: 5),
                        width: 200,

                        height: 40,

                        child: TextField(
                          controller: ImgNameTxt,
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(


                          ),
                        )
                    ),
                    flex: 6,
                  ),


                ],
              ),
              SizedBox(
                height: 20,
              ),

              Row(


                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text("Purchase Date", style: TextStyle(
                        color: DarkGrey, fontSize: 16,
                      ),),
                    ),
                    flex: 5,
                  ),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 40, bottom: 5),
                      width: 200,
                      height: 40,
                      child: TextField(
                        controller: PurchaseDate,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(


                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                1860),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: corporateColor, // <-- SEE HERE
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface: Colors.black, // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary: corporateColor, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (pickedDate != null) {
                            //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd')
                                .format(pickedDate);

                            //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              PurchaseDate.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        // style: TextStyle(
                        //   letterSpacing: 1,
                        //   fontSize: 13,
                        //   color: Colors.red,
                        // ),

                      ),


                    ),
                    flex: 6,
                  ),


                ],
              ),

              SizedBox(
                height: 20,
              ),
              Row(


                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text("Expires", style: TextStyle(
                        color: DarkGrey, fontSize: 16,
                      ),),
                    ),
                    flex: 5,
                  ),

                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right: 40, bottom: 5),
                        width: 200,

                        height: 40,

                        child: TextField(

                          controller: ExpireDate,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(

                            hintStyle: TextStyle(
                              letterSpacing: 1,
                              color: Colors.white,
                            ),


                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  1860),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: corporateColor, // <-- SEE HERE
                                      onPrimary: Colors.white, // <-- SEE HERE
                                      onSurface: Colors.black, // <-- SEE HERE
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: corporateColor, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                ExpireDate.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },

                        )
                    ),
                    flex: 6,
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Row(


                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text("Reminder Date", style: TextStyle(
                        color: DarkGrey, fontSize: 16,
                      ),),
                    ),
                    flex: 5,
                  ),

                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right: 40, bottom: 5),
                        width: 200,

                        height: 40,

                        child: TextField(

                          controller: RemainderDate,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(

                            hintStyle: TextStyle(
                              letterSpacing: 1,
                              color: Colors.white,
                            ),


                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: RemainderDate.text.toString() != "" ?
                              DateTime.parse(RemainderDate.text.toString()) :
                              DateTime.now(),
                              firstDate: DateTime(
                                  1860),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: RemainderDate.text.toString() != "" ?
                              DateTime.parse(RemainderDate.text.toString()) :
                              DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: corporateColor, // <-- SEE HERE
                                      onPrimary: Colors.white, // <-- SEE HERE
                                      onSurface: Colors.black, // <-- SEE HERE
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: corporateColor, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                RemainderDate.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },

                        )
                    ),
                    flex: 6,
                  ),

                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(


                children: [

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text("Reminder Notes", style: TextStyle(
                        color: DarkGrey, fontSize: 16,
                      ),),
                    ),
                    flex: 5,
                  ),

                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right: 40, bottom: 5),
                        width: 200,

                        height: 40,

                        child: TextField(
                          controller: ReminderNotes,
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(


                          ),
                        )
                    ),
                    flex: 6,
                  ),


                ],
              ),


            ],
          ),
            flex: 13,
          ),
          Expanded(child:
          Row(
            children: [
              Container(
                width: ScreenWidth * 0.495,
                height: double.infinity,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    "CANCEL", style: TextStyle(
                      color: Colors.white
                  ),
                  ),
                ),

              ),
              SizedBox(
                width: ScreenWidth * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  if (FristImage?.isAbsolute != true) {
                    showAlertDialog_oneBtn(context, "Alert", "Please add a image");
                  }
                  else if (ImgNameTxt.text.isEmpty == true){
                    showAlertDialog_oneBtn(context, "Alert", "Please enter the image name");

                  }

                  else {
                  callApi(context,
                  ImgNameTxt.text.toString(), PurchaseDate.text.toString(),
                  ExpireDate.text.toString(), RemainderDate.text.toString(),
                  ReminderNotes.text.toString(), FristImage);

                  }
                },
                child: Container(
                  width: ScreenWidth * 0.495,
                  height: double.infinity,
                  color: PoketBrightGreen,
                  child: Center(
                    child: Text(
                      "SAVE", style: TextStyle(
                      color: PoketNormalGreen,
                    ),
                    ),
                  ),
                ),
              ),

            ],
          ),
            flex: 1,

          ),

        ],
      ),

    );
  }

  Future<void> callApi(context, var ImageName, var PurchaseDate, var ExpireDate,
      var ReminderDate, var ReminderNotes, var ImageData) async {
    var stream = new http.ByteStream(DelegatingStream.typed(ImageData.openRead()));
    var length = await ImageData.length();
    var uri = Uri.parse(ADD_CUSTOM_DOCUMENT_URL);
    var request = new http.MultipartRequest("POST", uri);
   request.fields["imagename1"] = ImageName;
    request.fields["consumer_id"] = CommonUtils.consumerID.toString();
    request.fields["purchase_date"] = PurchaseDate;
    request.fields["expiry_date"] = ExpireDate;
    request.fields["reminder_date"] = ReminderDate;
    request.fields["reminder_notes"] = ReminderNotes;
   request.fields["device_token"] = CommonUtils.deviceToken.toString();

    var multipartFile = new http.MultipartFile('scanning_photo', stream, length,
        filename: basename(ImageData.path),
        contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Xml2Json xml2json = new Xml2Json();
      response.stream.transform(utf8.decoder).listen((value){
        xml2json.parse(value);
        var jsonstring = xml2json.toParker();
        var data = jsonDecode(jsonstring);
        var data2 = data['info'];
        var messg = stringSplit(data2['p2']);
        print(messg);
        showAlertDialog_oneBtnWitDismiss(context, "Alert", messg);



      });

    }


  }


  Upload(File imageFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://poketiosapi.poket.com/main/newapi/NewUiConsumerPhotoCmd");
    var request = new http.MultipartRequest("POST", uri);
    request.fields["action_event"] = '2';
    request.fields["consumer_id"] = "193881";


    var multipartFile = new http.MultipartFile('scanning_photo', stream, length,
        filename: basename(imageFile.path),
        contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value){
      print(value);
    });



    // var dio = new Dio();
    // dio.options.baseUrl = ADD_CUSTOM_CARD_URL;
    // dio.options.connectTimeout = 50000; //5s
    // dio.options.receiveTimeout = 50000;
    // dio.options.headers['content-Type'] = 'application/json';
    // dio.options.contentType = ContentType("application","x-www-form-urlencoded") as String?;
    // FormData formData = new FormData();

    //FormData formData =
  //  new FormData.fromMap({"files": await MultipartFile.fromFile(imageFile.path, filename: 'photo')
    //});
    //dio.
  }



    Future<void> callApi2(var ImageName, var PurchaseDate, var ExpireDate, var ReminderDate, var ReminderNotes,var ImageData ) async {
    var data=null;
    var body = {
      "member_id": "250051",
      "imagename1": ImageName,
      "purchase_date": PurchaseDate,
      "expiry_date": ExpireDate,
      "reminder_date": ReminderDate,
      "reminder_notes": ReminderNotes,
      "device_token": CommonUtils.deviceToken,
      "cma_timestamps": Utils().getTimeStamp(),
      "time_zone": Utils().getTimeZone(),
      "software_version": CommonUtils.softwareVersion,
      "os_version": CommonUtils.osVersion,
      "phone_model": CommonUtils.deviceModel,
      "device_type": CommonUtils.deviceType,
      'consumer_application_type': CommonUtils.consumerApplicationType,
      'consumer_language_id': CommonUtils.consumerLanguageId,
    };
    var postUri = Uri.parse(ADD_CUSTOM_CARD_URL);
    var request = new http.MultipartRequest("POST", postUri);
    request.fields["member_id"] = "250051" ;

   // request.files.add(value)




  }
  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
}
