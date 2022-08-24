import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Create New Account'),centerTitle:true,backgroundColor: Colors.pink,
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
      ),
    ),) ;
  }
}
