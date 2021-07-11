import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:we4you/modelz/video.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/styles.dart';

class VideoWidget extends StatelessWidget {
  final VideoModel v;

  const VideoWidget({
    Key key,
    this.v,
  }) : super(key: key);

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 6,
        right: 6,
      ),
      child: InkWell(
        onTap: () {
          _launchURL(v.videolink);
        },
        child: Ink(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      title: Text('Dr ${v.name}', style: ktCaption),
                      subtitle: Text('Consultation Link : ${v.videolink}',
                          style: ktBody2.copyWith(color: kcTextLight)),
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: kcTextLight,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
