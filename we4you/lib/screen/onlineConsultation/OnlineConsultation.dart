import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:we4you/modelz/video.dart';
import 'package:we4you/screen/onlineConsultation/widget/VideoWidget.dart';

import 'package:we4you/utils/colors.dart';

class OpenVideoList extends StatefulWidget {
  static final routeName = './videoList';

  @override
  OpenVideoListState createState() => OpenVideoListState();
}

class OpenVideoListState extends State<OpenVideoList> {
  List<VideoModel> linkz = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Online Consultation',
              style: TextStyle(
                  color: kcText, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('openvideo')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  linkz = [];
                  snapshot.data.docs.forEach((element) {
                    VideoModel videoModel =
                        VideoModel.fromMap(element.data(), element.id);
                    linkz.add(videoModel);
                  });

                  return Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          itemCount: linkz.length,
                          itemBuilder: (buildContext, index) =>
                              VideoWidget(v: linkz[index])));
                } else {
                  return Center(
                    child: Loading(
                      indicator: BallPulseIndicator(),
                      size: 40.0,
                      color: kcText,
                    ),
                  );
                }
              })
        ]),
      ),
    );
  }
}
