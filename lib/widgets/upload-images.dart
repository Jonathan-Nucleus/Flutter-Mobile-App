import 'package:client/widgets/section-title.dart';
import 'package:client/widgets/upload-info.dart';
import 'package:client/widgets/upload-widgets.dart';
import 'package:flutter/material.dart';

class UploadPhotos extends StatefulWidget {
  @override
  _UploadPhotosState createState() => _UploadPhotosState();
}

class _UploadPhotosState extends State<UploadPhotos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          UploadWidgets(),
          SectionTitle(title: '상품 정보 입력'),
          UploadInfo(),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
