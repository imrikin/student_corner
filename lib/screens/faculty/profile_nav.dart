import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/screens/faculty/http/client.dart';
import 'package:student_corner/screens/faculty/modal/faculty_doc_modal.dart';
import 'package:student_corner/screens/faculty/modal/personal_details_modal.dart';
import 'package:student_corner/screens/faculty/widgets/custom_text.dart';
import 'package:student_corner/screens/faculty/widgets/main_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class FacultyNavProfile extends StatefulWidget {
  const FacultyNavProfile({Key? key}) : super(key: key);

  @override
  State<FacultyNavProfile> createState() => _FacultyNavProfileState();
}

class _FacultyNavProfileState extends State<FacultyNavProfile> {
  late Future<List<FacultyDocumentModal>> documentDetails;

  late Future<List<FacultyDetailsModal>> personalDetailsFac;

  late String username;

  @override
  void initState() {
    getPrefData();
    documentDetails = docData();
    personalDetailsFac = personalDetails();
    super.initState();
  }

  getPrefData() async {
    SharedPreferences userSetting = await SharedPreferences.getInstance();
    username = userSetting.getString('inqueryid')!;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const MainAppBar(title: "Profile"),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: personalDetailsFac,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  List<FacultyDetailsModal> modal = snapshot.data;
                  if (modal[0].success) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          width: width * 0.91,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(
                                  0.0,
                                  10.0,
                                ),
                                blurRadius: 15.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  color: kPrimary.withOpacity(0.7),
                                ),
                                child: const Icon(
                                  Icons.supervisor_account_rounded,
                                  color: Colors.white,
                                  size: 36.0,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: modal[0].data[0].name,
                                      fontfamily: "Hanuman-bold",
                                      size: 16,
                                    ),
                                    CustomText(
                                      text: modal[0].data[0].email,
                                      size: 14,
                                    ),
                                    CustomText(
                                      text: "+91 ${modal[0].data[0].mobile}",
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          width: width * 0.91,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(
                                  0.0,
                                  10.0,
                                ),
                                blurRadius: 15.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  CustomText(
                                    text: "Personal Details",
                                    size: 18,
                                    fontfamily: 'Hanuman-bold',
                                  ),
                                  Icon(
                                    Icons.edit_note_rounded,
                                    size: 20,
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: width * 0.85,
                                height: 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              CustomText(
                                text: "Name : ${modal[0].data[0].name}",
                                size: 14,
                              ),
                              CustomText(
                                text: "UserName : $username",
                                size: 14,
                              ),
                              CustomText(
                                text: "DOB : ${modal[0].data[0].dob}",
                                size: 14,
                              ),
                              CustomText(
                                text: "Branch : ${modal[0].data[0].branch}",
                                size: 14,
                              ),
                              CustomText(
                                text: "Type : ${modal[0].data[0].userType}",
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          width: width * 0.91,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(
                                  0.0,
                                  10.0,
                                ),
                                blurRadius: 15.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  CustomText(
                                    text: "Bank Details",
                                    size: 18,
                                    fontfamily: 'Hanuman-bold',
                                  ),
                                  Icon(
                                    Icons.edit_note_rounded,
                                    size: 20,
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: width * 0.85,
                                height: 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              CustomText(
                                text:
                                    "Holder Name : ${modal[0].data[0].holderName}",
                                size: 14,
                              ),
                              CustomText(
                                text:
                                    "Bank Name : ${modal[0].data[0].bankName}",
                                size: 14,
                              ),
                              CustomText(
                                text: "Branch : ${modal[0].data[0].bankBranch}",
                                size: 14,
                              ),
                              CustomText(
                                text: "A/C No. : ${modal[0].data[0].acNo}",
                                size: 14,
                              ),
                              CustomText(
                                text: "IFSC Code : ${modal[0].data[0].ifsc}",
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          width: width * 0.91,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(
                                  0.0,
                                  10.0,
                                ),
                                blurRadius: 15.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                          ),
                          child: FutureBuilder(
                            future: documentDetails,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                List<FacultyDocumentModal> modal =
                                    snapshot.data;
                                if (modal[0].status == 200) {
                                  int countDoc = 0;
                                  bool hasPhoto = false;
                                  bool hasIdProof = false;
                                  bool hasPassbook = false;
                                  if (modal[0].data[0].photo != "") {
                                    countDoc++;
                                    hasPhoto = true;
                                  }
                                  if (modal[0].data[0].idProof != "") {
                                    countDoc++;
                                    hasIdProof = true;
                                  }
                                  if (modal[0].data[0].passbook != "") {
                                    countDoc++;
                                    hasPassbook = true;
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const CustomText(
                                            text: "Document Proof",
                                            size: 18,
                                            fontfamily: 'Hanuman-bold',
                                          ),
                                          Visibility(
                                            visible:
                                                countDoc == 3 ? true : false,
                                            child: const CustomText(
                                              text: "Verify",
                                              size: 14,
                                              color: Colors.green,
                                              fontfamily: 'Hanuman-bold',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        width: width * 0.85,
                                        height: 2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CustomText(
                                              text: "Photo (Passport Size)",
                                              size: 14,
                                            ),
                                            Row(
                                              children: [
                                                Visibility(
                                                  visible: hasPhoto,
                                                  child: InkWell(
                                                    onTap: () {
                                                      launchUrl(Uri.parse(
                                                          modal[0]
                                                              .data[0]
                                                              .photo));
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 6,
                                                              right: 6,
                                                              top: 3,
                                                              bottom: 2),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: const CustomText(
                                                        text: "View",
                                                        size: 10,
                                                        fontfamily:
                                                            'Hanuman-bold',
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 6,
                                                      right: 6,
                                                      top: 3,
                                                      bottom: 2),
                                                  child: CustomText(
                                                    text: "Upload",
                                                    size: 10,
                                                    fontfamily: 'Hanuman-bold',
                                                    color: kPrimary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CustomText(
                                              text: "ID Proof",
                                              size: 14,
                                            ),
                                            Row(
                                              children: [
                                                Visibility(
                                                  visible: hasIdProof,
                                                  child: InkWell(
                                                    onTap: () {
                                                      launchUrl(Uri.parse(
                                                          modal[0]
                                                              .data[0]
                                                              .idProof));
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 6,
                                                              right: 6,
                                                              top: 3,
                                                              bottom: 2),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: const CustomText(
                                                        text: "View",
                                                        size: 10,
                                                        fontfamily:
                                                            'Hanuman-bold',
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 6,
                                                      right: 6,
                                                      top: 3,
                                                      bottom: 2),
                                                  child: CustomText(
                                                    text: "Upload",
                                                    size: 10,
                                                    fontfamily: 'Hanuman-bold',
                                                    color: kPrimary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CustomText(
                                              text: "Passbook First Page",
                                              size: 14,
                                            ),
                                            Row(
                                              children: [
                                                Visibility(
                                                  visible: hasPassbook,
                                                  child: InkWell(
                                                    onTap: () => launchUrl(
                                                        Uri.parse(modal[0]
                                                            .data[0]
                                                            .passbook)),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 6,
                                                              right: 6,
                                                              top: 3,
                                                              bottom: 2),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: const CustomText(
                                                        text: "View",
                                                        size: 10,
                                                        fontfamily:
                                                            'Hanuman-bold',
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 6,
                                                      right: 6,
                                                      top: 3,
                                                      bottom: 2),
                                                  child: CustomText(
                                                    text: "Upload",
                                                    size: 10,
                                                    fontfamily: 'Hanuman-bold',
                                                    color: kPrimary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const CustomText(text: "Error!!");
                                }
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CustomText(text: modal[0].message),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
