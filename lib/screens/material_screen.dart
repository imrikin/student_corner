// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:student_corner/componant/secondary_appbar.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/ApiRequest.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/modal/material_modal_new.dart';
import 'package:student_corner/screens/pdf_view.dart';

import '../componant/audio_widget.dart';

class MaterialScreen extends StatefulWidget {
  final String mainId;
  final String subId;
  final String title;
  const MaterialScreen({
    Key? key,
    required this.mainId,
    required this.subId,
    required this.title,
  }) : super(key: key);

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  late StreamController _controller;

  loadData() async {
    materialModalNew(widget.mainId, widget.subId).then((value) async {
      _controller.add(value);
      return value;
    });
  }

  @override
  void initState() {
    _controller = StreamController();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'images/png/library.png',
                width: size.width,
                height: size.height * 0.45,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SecondaryAppbar(
                  title: widget.title,
                  color: Colors.black,
                  fontSize: 14,
                  homeIndex: 100,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: _controller.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: ansElement(
                                  snapshot, size, context, widget.subId),
                            );
                          } else {
                            return CircularProgressIndicator.adaptive();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<Widget> ansElement(
    AsyncSnapshot snapshot, Size size, BuildContext context, subCat) {
  List<Widget> element = [];
  List<MaterialModelNew> modal = snapshot.data;
  for (int i = 0; i < modal[0].data.length; i++) {
    element.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        width: size.width * 0.9,
        // height: 60.0,
        constraints: BoxConstraints(minHeight: 60),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(
              0.0,
              0.0,
            ),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ], borderRadius: BorderRadius.circular(10.0), color: Colors.white70),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextFieldCus(
                  text: modal[0].data[i].title,
                  color: Colors.black,
                  fontSize: 18.0,
                  width: 0.7,
                  textAlign: TextAlign.start,
                  fontFamily: 'Hanuman-bold'),
            ),
            InkWell(
              onTap: () {
                if (modal[0].data[i].type == "1") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PdfView(url: modal[0].data[i].url)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AudioWidget(
                              index: 0,
                              title: modal[0].data[i].title,
                              url: modal[0].data[i].url,
                            )),
                  );
                }
              },
              child: TextFieldCus(
                  text: 'View',
                  color: kPrimary,
                  fontSize: 12.0,
                  width: 0.15,
                  textAlign: TextAlign.start,
                  fontFamily: 'Hanuman-black'),
            ),
          ],
        ),
      ),
    );
  }
  return element;
}
