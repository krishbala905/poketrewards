import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../Others/AlertDialogUtil.dart';
import '../Others/CommonUtils.dart';
import '../Others/Urls.dart';
import '../res/Strings.dart';
import '../res/colors.dart';
import 'package:http/http.dart' as http;

import 'ConsumerTab.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  String _dropdownvalue ="Mr"  ;
  bool _checkbox = false;
  TextEditingController name_cntrl = TextEditingController();
  TextEditingController addr_cntrl = TextEditingController();
  TextEditingController mobile_cntrl = TextEditingController();
  TextEditingController emailId_cntrl = TextEditingController();
  TextEditingController pwdId_cntrl = TextEditingController();
  TextEditingController refcode_cntrl = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  // TextEditingController radio_cntrl = TextEditingController();
  // Default Radio Button Selected Item When App Starts.
  bool _obscured=true;
  final textFieldFocusNode = FocusNode();
  String radioButtonItem = 'NULL';
  // Group Value for Radio Button.
  int id = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscured=true;
    hideKeyboard();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: corporateColor,
          centerTitle: true,
          title: Text(
            create_new_account,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Icon(
                          Icons.person_outline,
                          size: 30,
                          color: corporateColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 6),
                          child: DropdownButton<String>(
                            hint: Text(
                              "Mr",
                            ),
                            //   style: TextStyle(fontSize: 20),
                            value: _dropdownvalue,
                            items:
                            <String> ["Mr", "Ms", "Mrs"].map(( String option) {
                              return DropdownMenuItem(
                                child: Text("$option"),
                                value: option,
                              );
                            }).toList(),
                            // value: _dropdownvalue,
                            // value: field.value,
                            onChanged: ( String? value) {
                              setState(() {
                                // field.didchange(value);
                                _dropdownvalue = value?? " ";
                              });
                            },
                          )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10.0, bottom: 1),
                        child: TextField(
                          controller: name_cntrl,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\.]")),
                          ],
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: full_name,
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.75,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Radio(
                      value: 1,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          radioButtonItem = 'Male';
                          id = 1;
                        });
                      },
                    ),
                    Text(
                      'Male',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Radio(
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
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.75,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 2),
                        child: Icon(
                          Icons.cake_outlined,
                          size: 32,
                          color: corporateColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8.0),
                        child: TextField(
                          controller: dateinput,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Date of Birth",
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
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.75,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Icon(
                            Icons.location_on_outlined,
                            size: 32,
                            color: corporateColor,
                          ),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: TextField(
                          controller: addr_cntrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Address",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.75,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Icon(
                          Icons.phone_android_sharp,
                          size: 25,
                          color: corporateColor,
                        ),
                      ),
                    ),
                    Container(
                        width: 60,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, ),
                            child: CountryCodePicker(
                              initialSelection: 'SG',
                              favorite: ['+65','SG'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: true,
                              showFlag: false,
                              enabled: true,
                              textStyle: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                              ),
                            )
                          /* child: Text(
                            country_code,
                            style: TextStyle(
                              color: black,
                              fontSize: 14,
                            ),
                          ),*/
                        )),
                    Container(
                      width: 10,
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 0.25,
                        width: 1,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2, top: 6.0),
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
                            hintText: enter_mobile_number,
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.75,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Icon(
                            Icons.email_outlined,
                            size: 32,
                            color: corporateColor,
                          ),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: TextField(
                          controller: emailId_cntrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: email,
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.75,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Icon(
                            Icons.lock_outline_sharp,
                            size: 32,
                            color: corporateColor,
                          ),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: TextField(
                          controller: pwdId_cntrl,
                          obscureText: _obscured,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: password,
                            border: InputBorder.none,
                            suffixIcon:  GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _obscured
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                size: 24,
                                color: corporateColor,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.75,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Icon(
                            Icons.groups_sharp,
                            size: 32,
                            color: corporateColor,
                          ),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: TextField(
                          controller: refcode_cntrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Referral Code",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.75,
              ),
              Container(
                height: 4,
                width: double.infinity,
              ),
              /*  Container(
              width: double.infinity,
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Container(
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0, left: 8.0),
                      child: Text(
                        add,
                        style: TextStyle(fontSize: 20, color: black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.car_rental,
                          size: 32,
                          color: corporateColor,
                        ),
                      )),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Submitted",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: Text(
                          "Car 1 Details",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey),
              height: 0.75,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.car_rental,
                          size: 32,
                          color: corporateColor,
                        ),
                      )),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Submitted",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: Text(
                          "Car 2 Details",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey),
              height: 0.75,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.car_rental,
                          size: 32,
                          color: corporateColor,
                        ),
                      )),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Submitted",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: Text(
                          "Car 3 Details",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey),
              height: 0.75,
            ),*/
              Container(
                height: 5,
                width: double.infinity,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Checkbox(
                          value: _checkbox,
                          onChanged: (value) {
                            setState(() {
                              _checkbox = !_checkbox;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: new RichText(
                            text: new TextSpan(children: [
                              new TextSpan(
                                text: 'I have read and agree to the ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              new TextSpan(
                                  text: 'Terms and conditions',
                                  style: new TextStyle(color: corporateColor,decoration: TextDecoration.underline,decorationThickness: 2),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () async {
                                      final url = ' ';
                                      if (await canLaunch(url)) launch(url);
                                    }),
                              new TextSpan(
                                text: ' and',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              new TextSpan(
                                  text: ' Privacy Policy',
                                  style: new TextStyle(color: corporateColor,decoration: TextDecoration.underline,decorationThickness: 2),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () async {
                                      const url = ' ';
                                      if (await canLaunch(url)) launch(url);
                                    }),
                            ])),
                        /* child: Text("I have read and agree to the Terms of Services and Privacy Details",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),*/
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 25),
                  ],
                ),
              ),
              Container(
                height: 5,
                width: double.infinity,
              ),
              GestureDetector(
                onTap: () {
                  var email = emailId_cntrl.text.toString().trim();
                  var pwd = pwdId_cntrl.text.toString();
                  var usn = name_cntrl.text.toString().trim();
                  var date = dateinput.text.toString();
                  var addr = addr_cntrl.text.toString();
                  var mob = mobile_cntrl.text.toString();
                  var reff = refcode_cntrl.text.toString();
                  var radio = radioButtonItem;
                  var lstname = _dropdownvalue;
                  print(lstname);
                  signup(usn, radio, date, addr, mob, email, pwd, reff,_checkbox,lstname);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: corporateColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                        child: Text(
                          submit,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    FocusScope.of(context).requestFocus(FocusNode());
    name_cntrl.dispose();
    dateinput.dispose();
    addr_cntrl.dispose();
    mobile_cntrl.dispose();
    refcode_cntrl.dispose();
    emailId_cntrl.dispose();
    pwdId_cntrl.dispose();
    super.dispose();
  }
  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return '0';
    } else {
      return "1";
    }
  }
  String validatePassword(String value) {

    if (value.length<6) {
      return "0";
    } else {
      return "1";
    }
  }
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }


  Future<void> signup(String usn, String radio, String date, String addr,
      String mob, String email, String pwd, String reff,bool _checkbox,String lstname) async {
    var lusn = usn+"."+lstname;
    if (usn.isEmpty || usn.length <= 0) {
      showAlertDialog_oneBtn(context, alert1, enter_empty_email);
    } else if (usn.length <= 3) {
      showAlertDialog_oneBtn(context, alert1, enter_valid_name);
    }
    /* else if(radio.isEmpty){
      showAlertDialog_oneBtn(context, alert1, choose_gender);
    }*/
    else if (date.isEmpty){
      showAlertDialog_oneBtn(context, alert1, choose_date);
    }
    else if (addr.isEmpty){
      showAlertDialog_oneBtn(context, alert1, choose_addr);
    }
    else if(mob.isEmpty || mob.length <= 0){
      showAlertDialog_oneBtn(context, alert1, enter_empty_mob);
    }
    else if (mob.startsWith('0')||mob.startsWith('1')||mob.startsWith('2')||mob.startsWith('3')||mob.startsWith('4')||mob.startsWith('5')||mob.startsWith('6')||mob.startsWith('7')){
      showAlertDialog_oneBtn(context, alert1, enter_valid_mob);
    }
    /* else if (('${mob[0]}'!='8') ||  ('${mob[0]}'!='9') ){
      showAlertDialog_oneBtn(context, alert1, enter_valid_mob);
    }*/
    else if(email.length==0){
      showAlertDialog_oneBtn(context, alert1,enter_empty_email);
    }
    else if(validateEmail(email)!="1"){
      showAlertDialog_oneBtn(context, alert1,enter_valid_email);
    }
    else if(pwd.length==0){
      showAlertDialog_oneBtn(context, alert1,enter_empty_pwd);
    }
    else if(validatePassword(pwd)!="1"){
      showAlertDialog_oneBtn(context, alert1, enter_valid_pwd);
    }
    else if(_checkbox!=true){
      showAlertDialog_oneBtn(context, alert1, choose_chbx);
    }
    else{
      //  print("hi" '${mob[0]}');
      // print(lstname);
      callApi( lusn, radio, date, addr, mob, email,  pwd,  reff);
    }
  }
  Future<void> callApi(var lusn, var radio, var date, var addr, var mob, var email,var pwd, var reff ) async {
    var data=null;
    print(lusn);
    print("url:"+SignupUrl);

    final http.Response response = await http.post(
      Uri.parse(SignupUrl),

      body: {
        "first_name" : lusn,
        // "last_name": lstname,
        "gender": radio,
        "date_of_birth": date,
        "phone_no":  "+65"+ mob,
        "email":  email,
        "password": pwd,
        "address": addr,
        "referral_code" : reff,
        "user_type": "1",

      },
    ).timeout(Duration(seconds: 30));
    print(response.body.toString());
// print(lstname);

    if (response.statusCode == 200) {

      data=await jsonDecode(response.body);
      var status=data["user_status"].toString();
      var message=data["prompt_message"].toString();
      if(status=="1"){
        CommonUtils.consumerID=data["consumer_id"].toString();
        CommonUtils.consumerName=data["full_name"].toString();
        CommonUtils.consumerGender=data["gender"].toString();
        //  CommonUtils.consumerProfileImageUrl=data["p9_val"].toString();
        CommonUtils.consumermobileNumber=data["phone_no_with_status "].toString();
        // CommonUtils.consumerIntialScreen=data["p11_val"].toString();
        CommonUtils.consumerEmail=email;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('NewSignup', "1");
        prefs.setString('consumerId', CommonUtils.consumerID.toString());
        prefs.setString('consumerName', CommonUtils.consumerName.toString());
        prefs.setString('consumerEmail', CommonUtils.consumerEmail.toString());

        // Navigator.push(context, MaterialPageRoute(builder: (context) => QRCodeActivity()));
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumerTab()));

      }
      else{
        showAlertDialog_oneBtn(context, alert1, message);
      }

    } else {
      showAlertDialog_oneBtn(context, alert1, something_went_wrong1);
    }


  }
}
