import 'package:flutter/material.dart';
import 'package:poketrewards/res/Strings.dart';

import '../Others/CommonUtils.dart';
import '../res/Colors.dart';
import 'package:poketrewards/UI/Tabbar/ConsumerTab.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailId_cntrl = TextEditingController();
  TextEditingController pwdId_cntrl = TextEditingController();
  bool _obscured = true;
  final textFieldFocusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscured = true;
    hideKeyboard();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: PoketNormalGreen,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context, true);
            // _goBack(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: PoketNormalGreen,
        centerTitle: true,
        title: const Text(
          login,
          style: TextStyle(color: textcolor, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(color: textcolor),
            height: 0.5,
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            decoration: BoxDecoration(color: textcolor),
            height: 0.5,
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SizedBox(width: 25),
                Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(email,
                          style: TextStyle(
                            color: textcolor,
                            fontSize: 15,
                          )),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: TextField(
                      cursorColor: textcolor,
                      controller: emailId_cntrl,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: textcolor,
                        fontSize: 20
                      ),
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
          Container(
            decoration: BoxDecoration(color: textcolor),
            height: 0.5,
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 25),
                Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(password,
                          style: TextStyle(
                            color: textcolor,
                            fontSize: 15,
                          )),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: TextField(
                      cursorColor: textcolor,
                      controller: pwdId_cntrl,
                      obscureText: _obscured,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          color: textcolor,
                          fontSize: 20
                      ),
                      decoration: InputDecoration(
                        labelText: "",
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 24,
                            color: textcolor,
                          ),
                        ),
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
            decoration: BoxDecoration(color: textcolor),
            height: 0.5,
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (_) => ConsumerTab()));
              // Validation
              // var email = emailId_cntrl.text.toString().trim();
              // var paswd = pwdId_cntrl.text.toString();

               // loginTask(email,paswd);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: textcolor),
                ),
                child: Center(
                    child: Text(
                  loginwith,
                  style: TextStyle(color: textcolor, fontSize: 15,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          GestureDetector(
            onTap: () {
              // Validation
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(35.0, 0, 35.0, 0),
              child: Center(
                  child: Text(
                forgot_password,
                style: TextStyle(color: textcolor, fontSize: 15),
                textAlign: TextAlign.center,
              )),
            ),
          ),
        ],
      ),
    ));
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }
 /* String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return '0';
    } else {
      return "1";
    }
  }

  Future<void> loginTask(var email, var paswd) async {

    if(email.length==0){
      showAlertDialog_oneBtn(context, alert,enter_empty_email);
    }
    else if(validateEmail(email)!="1"){
      showAlertDialog_oneBtn(context, alert,enter_valid_email);
    }
    else if(paswd.length==0){
      showAlertDialog_oneBtn(context, alert,enter_empty_pwd);
    }
    else if(validatePassword(paswd)!="1"){
      showAlertDialog_oneBtn(context, alert, enter_valid_pwd);
    }
    else{

      callApi(email, paswd);
    }

  }




  String validatePassword(String value) {

    if (value.length<6) {
      return "0";
    } else {
      return "1";
    }
  }*/
}
