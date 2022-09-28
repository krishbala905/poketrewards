import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poketrewards/res/Colors.dart';
// import 'package:qr_mobile_vision/qr_camera.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

import '../../Others/CommonUtils.dart';
class MyScanSegment extends StatefulWidget {
  const MyScanSegment({Key? key}) : super(key: key);

  @override
  State<MyScanSegment> createState() => _MyScanSegmentState();
}

class _MyScanSegmentState extends State<MyScanSegment> {
  var qr;
  bool camState = false;
  bool dirState = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Back"),
                Switch(value: dirState, onChanged: (val) => setState(() => dirState = val)),
                Text("Front"),
              ],
            ),
            Expanded(
                child: camState
                    ? Center(
                  child: SizedBox(
                    width: 300.0,
                    height: 600.0,
                    child: QrCamera(
                      onError: (context, error) => Text(
                        error.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      cameraDirection: dirState ? CameraDirection.FRONT : CameraDirection.BACK,
                      qrCodeCallback: (code) {
                        setState(() {
                          qr = code;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.orange,
                            width: 10.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    : Center(child: Text("Camera inactive"))),
            Text("QRCODE: $qr"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Text(
            "on/off",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            setState(() {
              camState = !camState;
            });
          }),
    );
  }
  }

