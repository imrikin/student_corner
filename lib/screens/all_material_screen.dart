// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_corner/componant/secondary_appbar.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/ApiRequest.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/modal/main_cat_modal_new.dart';
import 'package:student_corner/screens/sub_cate_screen.dart';

class AllMaterialScreen extends StatefulWidget {
  const AllMaterialScreen({Key? key}) : super(key: key);

  @override
  State<AllMaterialScreen> createState() => _AllMaterialScreenState();
}

class _AllMaterialScreenState extends State<AllMaterialScreen> {
  late Future<List<MainCategoryModalNew>> allMaterialFuture;

  @override
  void initState() {
    allMaterialFuture = mainCateModalNew();
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
                  color: Colors.black,
                  title: "Library",
                  homeIndex: 0,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: allMaterialFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        List<MainCategoryModalNew> modal = snapshot.data;
                        return Column(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              runSpacing: 5.0,
                              spacing: 15.0,
                              direction: Axis.horizontal,
                              children: widgets(modal, size, context),
                            ),
                          ],
                        );
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

List<Widget> widgets(
    List<MainCategoryModalNew> modal, Size size, BuildContext context) {
  List<Widget> element = [];
  for (var i = 0; i < modal[0].data.length; i++) {
    element.add(
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubCateScreen(
                      cateId: modal[0].data[i].id,
                      module: modal[0].data[i].title,
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            alignment: Alignment.center,
            width: size.width * 0.4,
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFieldCus(
                    text: modal[0].data[i].title,
                    color: kPrimary,
                    fontSize: 20.0,
                    width: 0.38,
                    textAlign: TextAlign.center,
                    fontFamily: 'Hanuman-black'),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kPrimaryBackGround,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    offset: const Offset(
                      0.0,
                      5.0,
                    ),
                    blurRadius: 15.0,
                    spreadRadius: 0.0,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
  return element;
}
