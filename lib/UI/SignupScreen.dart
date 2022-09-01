
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:poketrewards/res/Colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import '../Others/AlertDialogUtil.dart';
import '../res/Strings.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  String SelectGender =  '';
  TextEditingController UserNameTxt = TextEditingController();
  TextEditingController AddressTxt = TextEditingController();
  TextEditingController dateinputTxt = TextEditingController();
  TextEditingController PhoneNumTxt = TextEditingController();
  TextEditingController EmailAddresTxt = TextEditingController();
  TextEditingController PasswordTxt = TextEditingController();
  bool ChecktickBox = false;

  var GednerId = 0;


  void _tickfunc() {
    if (ChecktickBox) {
      ChecktickBox = false;
    }
    else {
      ChecktickBox = true;
    }


  }
  File?image;

  Future OpenGalley() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      final imagetemp = File(image.path);
      print(image.mimeType);
      setState(() {
        this.image = imagetemp;
      });
    } on PlatformException catch (e){
      print('failed : $e');
    }

  }
  // Future<File> testCompressAndGetFile(File file, String targetPath) async {
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path, targetPath,
  //     quality: 88,
  //     rotate: 180,
  //   );

  // print(file.lengthSync());
  // print(result.lengthSync());
  //
  // return result;
  //}





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

  @override
  Widget build(BuildContext context)
  {
    double ScreenWidth = MediaQuery.of(context).size.width;
    File imageFile;
    return SafeArea(

      child: Scaffold(

          backgroundColor: corporateColor,
          body: SingleChildScrollView(
            child: Column(

              children: [

                GestureDetector(
                  child: Container(
                    height: 180,
                    width: double.infinity,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SizedBox(
                          height: 20,

                        ),
                        image != null ? ClipOval(
                          child: Image.file(image!,
                            width: 100, height: 100,fit: BoxFit.cover,
                          ),
                        ) : Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/ic_profile.png',),
                                fit: BoxFit.fill,),
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            )
                        ),

                        SizedBox(height: 10, ),
                        Text('Add Photo',style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),)
                      ],
                    ),


                  ),
                  onTap: (){
                    showImgSource(context);
                    // Picimgae();
                    print('object');
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,

                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide( //                   <--- left side
                            color: Colors.white,
                            width:0.5,
                          ),
                          bottom: BorderSide(
                              color: Colors.white,
                              width: 0.5
                          )

                      )
                  ),
                  child: Row(
                    children: [
                      Expanded(

                        flex: 1,

                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Full Name',style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 13
                          ),),


                        ),),
                      Expanded(flex: 2,child: Container(

                          padding: EdgeInsets.only(left: 10.0),
                          child: TextField(
                            controller: UserNameTxt,
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none



                            ),


                          )

                      ),),

                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 0.5,
                          )
                      )

                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Gender',
                            style: (TextStyle(fontSize: 13,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            )
                            ),
                          ),
                        ),),

                      Expanded(flex: 2,child: Container(



                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [

                            Radio(value: 1, groupValue: GednerId, onChanged: (value){


                              setState(() {
                                GednerId = 1;
                                SelectGender = "Male";
                              });

                            },


                              fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),


                            ),

                            Text('Male',style: TextStyle(
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white

                            ),),
                            Radio(value: 2, groupValue:GednerId, onChanged: (values){


                              setState(() {

                                GednerId = 2;
                                SelectGender = "Female";
                              });


                            },


                              fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),

                            ),
                            Text('Female',style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.white,
                            ),),

                          ],
                        ),


                      ),
                      ),


                    ],
                  ),

                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 0.5,
                          )
                      )
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Date Of Birth',style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 13
                          ),),


                        ),
                      ),
                      Expanded(
                          flex : 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: dateinputTxt,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.white,
                                ),


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
                                    dateinputTxt.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),

                          ))

                    ],
                  ),


                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 0.5,
                          )
                      )
                  ),

                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Address',style: TextStyle(
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white
                            ),),
                          )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: AddressTxt,
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.white
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none



                              ),


                            ),
                          )),
                    ],
                  ),
                ),

                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 0.5,
                          )
                      )
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Phone Number', style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(

                            decoration:BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                      color: Colors.white,
                                      width: 0.5,
                                    )
                                )
                            ) ,
                            child: CountryCodePicker(
                              initialSelection: 'SG',
                              favorite: ['+65','SG'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: true,
                              showFlag: false,
                              enabled: true,
                              textStyle: TextStyle(

                                color: Colors.white,
                                fontSize: 14,
                              ),
                            )
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: PhoneNumTxt,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.white
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none



                              ),


                            ),

                          ))
                    ],

                  ),

                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 0.5,
                          )
                      )
                  ),
                  child: Row(
                    children: [
                      Expanded(

                        flex: 1,

                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Email',style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 13
                          ),),


                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: TextField(
                            controller: EmailAddresTxt,
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none



                            ),

                          ),

                        ),
                      )

                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 0.5,
                          )
                      )
                  ),
                  child: Row(
                    children: [
                      Expanded(

                        flex: 1,

                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Password',style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 13
                          ),),


                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [

                            Expanded(
                              flex : 5,
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextField(
                                  controller: PasswordTxt,
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: Colors.white
                                  ),
                                  decoration: InputDecoration(
                                      border: InputBorder.none

                                  ),

                                ),

                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(

                                ))
                          ],
                        ),
                      ),


                    ],
                  ),

                ),
                Container(

                  height: 80,
                  width: double.infinity,


                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(value: ChecktickBox, onChanged: (newvalue ){
                        setState(() {
                          _tickfunc();

                        });


                      },
                        checkColor: corporateColor,
                        activeColor: Colors.white,
                        fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),

                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RichText(

                          softWrap: true,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: TextSpan(
                            text: 'I have read and agree to the ',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                            children: [

                              TextSpan(
                                  text: 'Terms  \n of Services ',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  recognizer: TapGestureRecognizer(

                                  )..onTap = ()  {

                                  }

                              ),
                              TextSpan(
                                  text: 'and '
                              ),
                              TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  recognizer: TapGestureRecognizer(

                                  )..onTap = (){

                                    _launchURL();
                                  }

                              ),
                            ],
                          )),

                    ],



                  ),
                ),

                GestureDetector(
                  onTap: (){
                    setState(() {

                      SinupBtnTapped();
                    });
                    print('Singup Tapped');
                  },
                  child: Container(
                    width:  ScreenWidth * 0.9,
                    height: 40,

                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text('SIGN UP',
                        style: TextStyle(
                          letterSpacing: 1,
                          color: background,
                          fontSize: 15,
                        ),
                      ),
                    ),




                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),

          )
      ),



    ) ;

  }
  void SinupBtnTapped(){
    if (UserNameTxt.text.isEmpty) {
      showAlertDialog_oneBtn(context, 'alert', ' Please enter full name');

    }
    else if (PhoneNumTxt.text.isEmpty ){
      showAlertDialog_oneBtn(context, 'alert', ' Please enter mobile number');

    }
    else if(EmailAddresTxt.text.length==0){
      showAlertDialog_oneBtn(context, 'Alert','Please enter email address');
    }
    else if (!validateEmail(EmailAddresTxt.text)){
      showAlertDialog_oneBtn(context, 'Alert','Please enter valid email address');
    }
    else if ( PasswordTxt.text.isEmpty) {
      showAlertDialog_oneBtn(context, 'Alert', 'Please enter password');
    }
    else if (PasswordTxt.text.length < 6 ){
      showAlertDialog_oneBtn(context, 'Alert', 'Password must be atleast 6 characters');
    }
    else if ( !ChecktickBox) {
      showAlertDialog_oneBtn(context, 'Alert', 'You have read and agree to the Terms of Service and Privacy Policy');
    }


    else {
      final bytes = File(image!.path).readAsBytesSync();
      final byd = File(image!.path);

      print('object');


    }


  }

  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return false;
    } else {
      return true;
    }
  }
}
