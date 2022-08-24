import 'package:flutter/material.dart';

import 'package:poketrewards/UI/Signup/SingUpScreen.dart';

class MainLoginUi extends StatefulWidget {
  const MainLoginUi({Key? key}) : super(key: key);

  @override
  State<MainLoginUi> createState() => _MainLoginUiState();
}

class _MainLoginUiState extends State<MainLoginUi> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    return SafeArea(child:Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
         image: DecorationImage(
           image: AssetImage(
               'assets/Bacgroundimg.png'
           ),
           fit: BoxFit.fill,
         )

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignupScreen()));

              },
              child: Container(

               width: ScreenWidth * 0.8,
               height: 40,

                decoration: BoxDecoration(
                  color: Colors.transparent,
                    border: Border.all(color: Colors.white)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(
                      child:
                    Icon(Icons.create,size: 30,color: Colors.white,),
                    flex: 1,),



                   Expanded(
                     flex: 3,
                     child:  Text('Create New Account',style: TextStyle(
                     color:
                     Colors.white,
                     fontSize: 18,
                     fontWeight: FontWeight.w600,
                   ),),)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: ScreenWidth * 0.8,
              height: 40,

              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(
                    child:
                    Icon(Icons.facebook_outlined,size: 30,color: Colors.white,),
                    flex: 1,),



                  Expanded(
                    flex: 3,
                    child:  Text('Login With Facebook',style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),),)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: ScreenWidth * 0.8,
              height: 40,

              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(
                    child:
                    Icon(Icons.apple_outlined,size: 30,color: Colors.white,),
                    flex: 1,),



                  Expanded(
                    flex: 3,
                    child:  Text('Login With Apple',style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),),)
                ],
              ),
            ),
            SizedBox(
             height: 20,
            ),
            Container(
              width: ScreenWidth * 0.8,
              height: 40,

              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(
                    child:
                    Icon(Icons.login_outlined,size: 30,color: Colors.white,),
                    flex: 1,),



                  Expanded(
                    flex: 3,
                    child:  Text('Login with Email ',style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),),)
                ],
              ),
            ),

          ],
        ),



      ),
    ),

    );
  }
}
