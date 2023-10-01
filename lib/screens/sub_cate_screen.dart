// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_corner/componant/secondary_appbar.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/ApiRequest.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/modal/main_cat_modal_new.dart';
import 'package:student_corner/screens/material_screen.dart';

late String id;

class SubCateScreen extends StatefulWidget {
  final String cateId;
  final String module;
  const SubCateScreen({Key? key, required this.cateId, required this.module})
      : super(key: key);

  @override
  State<SubCateScreen> createState() => _SubCateScreenState();
}

class _SubCateScreenState extends State<SubCateScreen> {
  late Future<List<MainCategoryModalNew>> subCat;
  @override
  void initState() {
    setState(() {
      id = widget.cateId;
    });
    subCat = subCateModalNew(widget.cateId);
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
              opacity: 0.22,
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
                  color: Colors.black,
                  title: widget.module,
                  homeIndex: 100,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: subCat,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data[0].status == 200) {
                          List<MainCategoryModalNew> modal = snapshot.data;
                          return Column(
                            children:
                                widgets(modal, size, context, widget.module),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            width: size.width,
                            height: size.height,
                            child: TextFieldCus(
                                text: 'No Data Found!!',
                                color: Colors.white,
                                fontSize: 25.0,
                                width: 1,
                                textAlign: TextAlign.center,
                                fontFamily: 'Hanuman-bold'),
                          );
                        }
                      } else {
                        return CircularProgressIndicator.adaptive();
                      }
                    },
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

List<Widget> widgets(List<MainCategoryModalNew> modal, Size size,
    BuildContext context, String module) {
  List<Widget> element = [];
  for (var i = 0; i < modal[0].data.length; i++) {
    element.add(
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MaterialScreen(
                mainId: id,
                subId: modal[0].data[i].id,
                title: modal[0].data[i].title,
              ),
            ),
          );

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(^
          //     builder: (context) => MaterialScreen(
          //       title: snapshot.data[0].data[i].title,
          //       module: module,
          //       subId: snapshot.data[0].data[i].id,
          //       where: '1',
          //     ),
          //   ),
          // );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10.0),
          padding: EdgeInsets.symmetric(vertical: 8.0),
          width: size.width * 0.9,
          // height: 60.0,
          constraints: BoxConstraints(minHeight: 60),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white70),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextFieldCus(
                    text: modal[0].data[i].title,
                    color: Colors.black87,
                    fontSize: 18.0,
                    width: 0.75,
                    textAlign: TextAlign.start,
                    fontFamily: 'Hanuman-bold'),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: kPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
  return element;
}
