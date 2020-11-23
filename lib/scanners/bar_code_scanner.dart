import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  File pickedImage;
  var text = '';

  bool imageLoaded = false;

  Future pickImage() async {
    var awaitImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = awaitImage;
      imageLoaded = true;
    });

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);

    final BarcodeDetector barcodeDetector =
    await FirebaseVision.instance.barcodeDetector();

    final List<Barcode> barcodes =
    await barcodeDetector.detectInImage(visionImage);

    for (Barcode barcode in barcodes) {
      print("barcode $barcode");
      final String rawValue = barcode.rawValue;
      final BarcodeValueType valueType = barcode.valueType;

      setState(() {
        text ="$rawValue\nType: $valueType";
      });

    }

    barcodeDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 100.0),
          imageLoaded
              ? Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(blurRadius: 20),
                  ],
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                height: 250,
                child: Image.file(
                  pickedImage,
                  fit: BoxFit.cover,
                ),
              ))
              : Container(),
          SizedBox(height: 10.0),
          Center(
            child: FlatButton.icon(
              icon: Icon(
                Icons.photo_camera,
                size: 100,
              ),
              label: Text(''),
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                pickImage();
              },
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(height: 10.0),
          text == ''
              ? Text('Text will display here')
              : Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  text,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}