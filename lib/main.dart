import 'package:firebase_ml_text_recognition/detections/face_detections.dart';
import 'package:firebase_ml_text_recognition/labeller/labeller.dart';
import 'package:firebase_ml_text_recognition/scanners/bar_code_scanner.dart';
import 'package:firebase_ml_text_recognition/widget/text_recognition_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Text Recognition';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home:PageViewClass()
      );
}

class PageViewClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        MainPage(title: "Text"),
        Scanner(),
        FaceDetection(),
        //ImageLabeller()
      ],
    );
  }
}


class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 25),
              TextRecognitionWidget(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
}
