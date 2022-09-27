import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:poketrewards/Others/AlertDialogUtil.dart';
import 'package:poketrewards/Others/CommonUtils.dart';
import 'package:http/http.dart' as http;
import 'package:poketrewards/Others/Urls.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:poketrewards/res/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';



class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {
  TextEditingController full_name_cntrl = new TextEditingController();
  TextEditingController dateinput = new TextEditingController();
  TextEditingController addr_cntrl = new TextEditingController();
  TextEditingController mobile_cntrl = new TextEditingController();
  TextEditingController emailId_cntrl = new TextEditingController();
  String radioButtonItem = 'NULL';
  String? pickedCountryCode1;
  var usn, addr, mobile, emailid, date, sal, gen;
  String? imgUrl;

  // String imgUrl="assets/ic_profile.png";
  void initState() {
    // TODO: implement initState
    super.initState();
    hideKeyboard();
    //getUSerImage();
    getUserProfil(CommonUtils.consumerID);
  }
  // Group Value for Radio Button.
  int id = 1;
  File?image,_file;
  Future OpenGalley() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      final imagetemp = File(image.path);
      print(image.mimeType);
      setState(() {
        this.image =   imagetemp;
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
        this.image = imagetemp;
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
 /* getUSerImage()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    imgUrl=pref.getString("consumerProfileImage");
    debugPrint("3"+ imgUrl!);
  }*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          profile,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: corporateColor2,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        color: corporateColor2,
        child: Column(
          children: <Widget>[
            Container(decoration: BoxDecoration(color: Colors.white),height: 0.5,),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                height: 120,
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    image != null ? ClipOval(
                      child: Image.file(image!,
                        width: 80, height: 80,fit: BoxFit.cover,
                      ),
                    ) : Container(
                        height: 80,
                        width: 80,
                        decoration:  BoxDecoration(
                          image: DecorationImage(
                           // image: FileImage(_file!),
                            // Icon(Icons.person_outline_rounded,color: Colors.white,size: 65,),
                            image: imgUrl!=null ? NetworkImage(imgUrl!, scale: 5.0): AssetImage('assets/ic_profile.png') as ImageProvider,
                            fit: BoxFit.fill,),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        )
                    ),

                    SizedBox(height: 10, ),
                    Text(editprofile,style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),)
                  ],
                ),


              ),
              onTap: (){
                showImgSource(context);
                // Picimgae();
                print('object'+update);
              },
            ),
            /*GestureDetector(
              onTap: (){
                showImgSource(context);
                // Picimgae();
                print('object'+update);
              },
              child: Center(
                // child: CircleAvatar(
                 // radius:  40,
                 *//* Image.file(
                    profileImage,
                    fit: BoxFit.cover,
                  ).image,*//*
                 child: ClipOval(
                    // child: Icon(Icons.person_outline_rounded,color: Colors.white,size: 65,),
                    child: Image.asset('assets/ic_profile.png',height: 100,width: 100,fit: BoxFit.fill,),
                  ),

                 // backgroundColor: Colors.grey,
                // ),
              ),
            ),*/
           /* SizedBox( height: 5,),
            Center(
              child: Text(editprofile, style: TextStyle(fontSize: 15,color: Colors.white),)
            ),*/
            SizedBox(
              height: 3,
            ),
            Container(decoration: BoxDecoration(color: Colors.white),height: 1,),
            Container(
              height: 40,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 25),
                  Container(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(full_name,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 15,
                            )),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: TextField(
                        cursorColor: textColor,
                        controller: full_name_cntrl,
                        keyboardType: TextInputType.name,
                        style: TextStyle(color: textColor, fontSize: 15),
                        decoration: InputDecoration(
                          labelText: "",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            Container(decoration: BoxDecoration(color: Colors.white),height: 1,),
            Container(
             height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 25),
                  Text(gender,style: TextStyle(fontSize: 15,color: Colors.white),),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Radio(
                      activeColor: Colors.white,
                      fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                      value: 1,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          radioButtonItem = 'Male';
                          id = 1;
                        });
                      },
                    ),
                  ),
                  Text(
                    'Male',
                    style: new TextStyle(fontSize: 15.0,color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Radio(
                    activeColor: Colors.white,
                    fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                    value: 2,
                    groupValue: id,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'Female';
                        id = 2;
                      });
                    },
                  ),
                  Text(
                    'Female',
                    style: new TextStyle(fontSize: 15.0,color: Colors.white),
                  ),
              ],
                    ),
                  ),

            Container(decoration: BoxDecoration(color: Colors.white),height: 1,),
            Container(
             height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 25
                  ),
                  Container(
                    width: 70,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 2),
                      child: Text(
                        dateofbirth,
                        style: TextStyle(
                            fontSize: 15,color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45,),
                      child: TextField(
                        controller: dateinput,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                1860 ), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary:corporateColor, // <-- SEE HERE
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface: Colors.black, // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary:corporateColor, // button text color
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
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              dateinput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  SizedBox(width: 25),

                ],
              ),
            ),
            Container(decoration: BoxDecoration(color: Colors.white),height: 1,),
            Container(
             height: 40,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 25),
                  Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          address,style: TextStyle(
                            fontSize: 15,color: Colors.white
                        ),
                        ),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 65,),
                      child: TextField(
                        controller: addr_cntrl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            Container(decoration: BoxDecoration(color: Colors.white),height: 1,),

            Container(
              height: 45,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(mobile_number,style: TextStyle(
                        fontSize: 15, color: Colors.white,
                      ),
                      )
                    ),
                  ),
                  Container(
                      width: 65,
                      child: Padding(
                          padding: const EdgeInsets.only(),
                          child: CountryCodePicker(
                            initialSelection: 'IN',
                            favorite: ['+91','IN'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: true,
                            showFlag: false,
                            enabled: true,
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            //  onInit: (value) =>  print(pickedCountryCode1!.toString()),
                            //{
                              /*setState(){
                                pickedCountryCode = value.toString();
                                print("1:" + pickedCountryCode!);
                              }*/

                            // },
                          ),
                      )),
                  Container(
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 0.25,
                      width: 1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6,),
                      child: TextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: mobile_cntrl,
                        // maxLength: 12,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // counterText: ' ',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 14,color: Colors.white),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Container(decoration: BoxDecoration(color: Colors.white),height: 1,),
            Container(
             height: 40,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 25),
                  Container(
                      width: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          email, style: TextStyle(
                          fontSize: 15, color: Colors.white
                        ),
                        )
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 65,),
                      child: TextField(
                        controller: emailId_cntrl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            Container(decoration: BoxDecoration(color: Colors.white),height: 1,),
            SizedBox( height: 20,),
            GestureDetector(
              onTap: () {
                setState(() {
                  var email = emailId_cntrl.text.toString().trim();
                  // var pwd = pwdId_cntrl.text.toString();
                  var usn = full_name_cntrl.text.toString().trim();
                  var date = dateinput.text.toString();
                  var addr = addr_cntrl.text.toString();
                  var mob = mobile_cntrl.text.toString();
                  // var reff = refcode_cntrl.text.toString();
                  var radio = radioButtonItem;
                  File? image = this.image;
                  updateprofile(usn,radio,date,addr,mob,email,image);
                });
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: textColor),
                  ),
                  child: Center(
                      child: Text(
                       update,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
            ),

                ],
              ),
            ),
    ));
  }
  Future<void> updateprofile( String up_usn, String up_radio, String up_date, String up_addr, String up_mob, String up_email,File? image ) async {
    var data = null;



    final http.Response response = await http.post(
      Uri.parse(PROFILE_URL),
      body: {
        "consumer_id": CommonUtils.consumerID,
        "country_index" : "91",
        "device_type": CommonUtils.deviceType,
        "full_name": up_usn,
        "gender": up_radio,
        "birthdate": up_date,
        "phone_no":  up_mob,
        "device_token_id":CommonUtils.deviceTokenID,
        "conusumer_email": up_email,
        "address": up_addr,
        "consumer_language_id": CommonUtils.consumerLanguageId,
        // "user_type": "1",
        "action_event": "2",

      },
    ).timeout(Duration(seconds: 30));

    print(response.body.toString());

    if (response.statusCode == 200) {
      data = await jsonDecode(response.body);
      var status = data["status"].toString();
      var message = data["data"].toString();
      if(status == "True"){
        setState(() {
          print("check12"+up_usn);
          full_name_cntrl.text = up_usn;
          dateinput.text = up_date;
          addr_cntrl.text = up_addr;
          mobile_cntrl.text = up_mob;
          emailId_cntrl.text = up_email;
        });

        gen = up_radio;
        if (gen == "female") {
          setState(() {
            id=2;
          });
          //  radioButtonItem=id.toString();
        } else {
          setState(() {
            id=1;
          });

          //  radioButtonItem = '1';
        }
        // radioButtonItem =gen;
        print("check12"+up_date+"hi"+up_addr+"hii"+up_mob+"hii"+up_email);


        CommonUtils.consumerName=up_usn;
        CommonUtils.consumerGender=up_radio;
        CommonUtils.consumerEmail = up_email;
        CommonUtils.consumerDateofBirth = up_date;
        CommonUtils.consumermobileNumber = up_mob;

        /*CommonUtils.consumerDateOfBirth=up_date;
        CommonUtils.consumerAddress=up_addr;*/


        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('consumerId', CommonUtils.consumerID.toString());
        prefs.setString('consumerName', CommonUtils.consumerName.toString());
        prefs.setString('consumerEmail', CommonUtils.consumerEmail.toString());
        prefs.setString('consumerMobile', CommonUtils.consumermobileNumber.toString());
        prefs.setString('consumerGender', CommonUtils.consumerGender.toString());
       /* prefs.setString('consumerDateOfBirth', CommonUtils.consumerDateOfBirth.toString());
        prefs.setString('consumerAddr', CommonUtils.consumerAddress.toString());*/
        showAlertDialog_oneBtn(context, 'Alert', message);
      }

    }else {
      showAlertDialog_oneBtn(context, alert1, something_went_wrong1);
    }
  }

  Future<void> getUserProfil(var consid) async {
    var data = null;
    print("url:" + PROFILE_URL_GET);

    final http.Response response = await http.post(
      Uri.parse(PROFILE_URL_GET),
      body: {
        "consumer_id": consid,
        "action_event": "1",
      },
    ).timeout(Duration(seconds: 30));

    print(response.body.toString());
    if (response.statusCode == 200) {
      data = await jsonDecode(response.body);
      var status = data["status"].toString();
      var message = data["status"].toString();
      if (status == "True") {
        print("hii");
        usn = data["data"]['first_name'].toString();
        full_name_cntrl.text = usn;
        gen = data["data"]['gender'].toString();
        if (gen == "female") {
          setState(() {
            id=2;
          });
          //  radioButtonItem=id.toString();
        } else {
          setState(() {
            id=1;
          });

          //  radioButtonItem = '1';
        }
        // radioButtonItem =gen;
        date = data["data"]['birthdate'].toString();
        dateinput.text = date;
        addr = data["data"]['address'].toString();
        addr_cntrl.text = addr;
        mobile = data["data"]['mobile'].toString();
        mobile_cntrl.text = mobile.split(",")[1];
        var countrycode1 = mobile.split(",")[0];
        var imgurl = data["data"]['profile_image'].toString();
        imgUrl = imgurl;
        /*if(countrycode1!=null){
          setState(() {
            pickedCountryCode1 = countrycode1;
            print("2:"+pickedCountryCode1!);
          });
        }*/
        emailid = data["data"]['consumer_email'].toString();
        emailId_cntrl.text = emailid;
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumerTab(),));
      }
      else{
        showAlertDialog_oneBtn(context, alert1, message);
      }

    } else {
      showAlertDialog_oneBtn(context, alert1, something_went_wrong1);
    }
  }

}
