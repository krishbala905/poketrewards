import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poketrewards/Others/AlertDialogUtil.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


import 'package:flutter/services.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:xml2json/xml2json.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';


class CustomCard extends StatefulWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  var pageCount = 0;
  var Dateselect = false;

  TextEditingController NameTxt = TextEditingController();
  TextEditingController ExpireDate = TextEditingController();
  File?FristImage;
 var cardimages = [];
  Future OpenGalley() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      final imagetemp = File(image.path);
      print(image.mimeType);
      setState(() {
        this.FristImage =   imagetemp;
       cardimages.add(imagetemp);

      });
    } on PlatformException catch (e){
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
        cardimages.add(imagetemp);
      });
    } on PlatformException catch (e){
      print('failed : $e');
    }

  }


  Future<ImageSource?> showImgSource(BuildContext context ) async {
    if ( Platform.isIOS){
      return showCupertinoModalPopup<ImageSource>(context: context, builder: (context) =>
          CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text(camera),
                onPressed: (){

                  OpenCamera();
                  Navigator.of(context).pop();

                },
              ),
              CupertinoActionSheetAction(
                child: Text(gallery),
                onPressed: (){
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
              onTap: (){
                OpenCamera();
                Navigator.of(context).pop();
              },
              title: const Text(camera),
            ),
            ListTile(
              onTap: (){
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
    double ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Custom Card"),
      backgroundColor: PoketNormalGreen,),
      body:Column(
        children: [
          Expanded(child:
          Column(
            children: [
           SizedBox(
        height: 20,
      ),
            Center(
              child:Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(color: lightGrey),
          ),
          height: 170,
          width: 270,
                  child:  cardimages.length ==  2 ? GridView.builder(

                    itemCount: cardimages.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.88 / 3,

                    ),
                    itemBuilder: (BuildContext context, int index) {


                      return ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.file(cardimages[index],fit: BoxFit.fill)
                      );
                    },
                  ) :
                  FristImage != null ?

                  // Image.file(FristImage!,fit: BoxFit.fill,)
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.file(FristImage!,fit: BoxFit.fill,)
                  )

                      : GestureDetector(
                    onTap: (){
                      print(ExpireDate.text.toString());
                      showImgSource(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/Camera_icon.png',color: PoketNormalGreen,width: 25,),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Tap to add a Image",style: TextStyle(
                          fontSize: 16,
                          color: PoketNormalGreen,
                        ),)
                      ],
                    ),
                  ),




             ),


      ),
            SizedBox(
        height: 10,
      ),
              cardimages.length == 2 ? Container(

                ):
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [

                  GestureDetector(
                    onTap: (){
                      cardimages.length == 0 ? showAlertDialog_oneBtn(context, 'Alert','First image not added yet. You can add the second image only after the first image is added.'):
                      showImgSource(context);
                    },
                    child: Text("Add a second image",
                     style: TextStyle(
                fontSize: 16,
                color: DarkGrey,
                decoration: TextDecoration.underline,decorationThickness: 1,
              ),),
                  ),
          SizedBox(
              width: 10,
          ),
          Icon(Icons.info_outline,color: lightGrey,),
          //Image.asset('assets/Camera_icon.png',color: PoketNormalGreen,width: 25,),
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
                      child: Text("Image Name*",style: TextStyle(
                        color: DarkGrey,fontSize: 16,
                      ),),
                    ),
                    flex: 5,
                  ),

                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right: 40,bottom: 5),
                        width: 200,

                        height: 40,

                        child: TextField(
                          controller: NameTxt,
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
                      child: Text("Expires",style: TextStyle(
                        color: DarkGrey,fontSize: 16,
                      ),),
                    ),
                    flex: 5,
                  ),

                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right: 40,bottom: 5),
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
                              initialDate:  ExpireDate.text.toString() != "" ?
                              DateTime.parse(ExpireDate.text.toString()) :
                              DateTime.now(),
                            firstDate: DateTime(
                                  1860 ), //DateTime.now() - not to allow to choose before today.
                              lastDate: ExpireDate.text.toString() != "" ?
                              DateTime.parse(ExpireDate.text.toString()) :
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
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                print("Selected");
                                Dateselect = true;
                                ExpireDate.text = formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 13,
                            color: Colors.black,
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
          Expanded(child: Row(
            children: [
              Container(
                width: ScreenWidth * 0.495,
                height: double.infinity,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    "CANCEL",style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                ),

              ),
              SizedBox(
                width: ScreenWidth * 0.01,
              ),
              GestureDetector(
                onTap: (){
                  if (FristImage?.isAbsolute != true){
                    showAlertDialog_oneBtn(context, "alert","Please add a image");
                  }
                  else  if (NameTxt.text.isEmpty == true) {
                    showAlertDialog_oneBtn(context, "alert","Please enter the image name");
                  }
                  else {
                    callApi(context, NameTxt.text.toString(), ExpireDate.text.toString(), FristImage);
                  }
                },
                child: Container(
                  width: ScreenWidth * 0.495,
                  height: double.infinity,
                  color: PoketBrightGreen,
                  child: Center(
                    child: Text(
                        "SAVE",style: TextStyle(
                        color: PoketNormalGreen,
                    ),
                    ),
                  ),
                ),
              ),

            ],
          ),
            flex: 1,

          )
        ],
      )

    );


  }
  Future<void> callApi(context, var ImageName, var ExpireDate,
      var ImageData1) async {
    var stream1 = new http.ByteStream(DelegatingStream.typed(ImageData1.openRead()));
    var length1 = await ImageData1.length();
    var uri = Uri.parse(ADD_CUSTOM_CARD_URL);
    var request = new http.MultipartRequest("POST", uri);
    request.fields["imagename1"] = ImageName;
    request.fields["consumer_id"] = CommonUtils.consumerID.toString();
    request.fields["expiryDate"] = ExpireDate;
    request.fields["device_token"] = CommonUtils.deviceToken.toString();

    var multipartFile = new http.MultipartFile('scanning_photo', stream1, length1,
        filename: basename(ImageData1.path),
        contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);

    if (cardimages.length == 2) {
        var stream2 = new http.ByteStream(
            DelegatingStream.typed(cardimages[1].openRead()));
        var length2 = await cardimages[1].length();
      var multipartFile2 = new http.MultipartFile('scanning_photo2', stream2, length2,
          filename: basename(cardimages[1].path),
          contentType: new MediaType('image', 'png'));
      request.files.add(multipartFile2);

    }

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

  String stringSplit(String data) {
    return data.split("*%8%*")[0];
  }
}
