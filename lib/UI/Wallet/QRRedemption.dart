import 'package:flutter/material.dart';
import '../../res/Colors.dart';
import '../../res/Strings.dart';



class QRRedemption extends StatefulWidget {
  const QRRedemption({Key? key}) : super(key: key);

  @override
  State<QRRedemption> createState() => _QRRedemptionState();
}

class _QRRedemptionState extends State<QRRedemption> {
   var voucherName="Welcome Voucher";
   var quantity="1";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 450,
          height: 450,
          color: Colors.transparent,
          child: Container(
            width: 400,
            height: 400,
            color: Colors.white,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                SizedBox(height: 20,),
                Text("Redeem Voucher",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text(voucherName+" x "+quantity,style: TextStyle(fontSize: 16,color: Colors.black),),
                SizedBox(height: 30,),
                Text(" SCAN VOUCHER QR CODE ",style: TextStyle(fontSize: 21,color: Colors.black),),
                SizedBox(height: 20,),
                Center(child: generateQRCode()),
                SizedBox(height: 20,),
                MaterialButton(onPressed: (){},
                 color: corporateColor,
                child:  Text(cancel,style: TextStyle(color: Colors.white,fontSize: 13),),),
                SizedBox(height: 20,),
              ],

            ),
          ),
        ),
      ),
    );
  }
  
  Widget generateQRCode(){
    return Image.network("https://miro.medium.com/max/1400/1*sHmqYIYMV_C3TUhucHrT4w.png",width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.width/2,);
  }
  
}
