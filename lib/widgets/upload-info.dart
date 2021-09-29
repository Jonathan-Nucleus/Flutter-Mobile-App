import 'package:client/widgets/modals/categories.dart';
import 'package:client/widgets/section-title.dart';
import 'package:client/widgets/upload-input.dart';
import 'package:flutter/material.dart';
import 'modals/floating-modal.dart';

final List<String> catListAll = [
  '상의',
  '하의',
  '아우터',
  '세트(원피스 등)',
  '가방',
  '신발',
  '액세서리',
];

final List<String> catSub1 = [
  '민소매',
  '반팔티',
  '피케/카라',
  '긴팔',
  '맨투맨',
  '니트/스웨터',
  '후드',
  '셔츠',
  '기타(상의)',
];

final List<String> catSub2 = [
  '청바지',
  '면바지',
  '슬랙스',
  '트레이닝',
  '조거',
  '숏팬츠',
  '레깅스',
  '스커트',
  '기타(하의)',
];

final List<String> catSub3 = [
  '트레이닝',
  '후드집업',
  '블루종',
  '라이더재킷',
  '트러커재킷',
  '블레이저',
  '아노락',
  '플리스',
  '기타(아우터)',
];

final List<String> catSub4 = [
  '원피스',
  '세트',
  '기타(세트)',
];

class UploadInfo extends StatefulWidget {
  @override
  _UploadInfoState createState() => _UploadInfoState();
}

class _UploadInfoState extends State<UploadInfo> {
  var _brandController = TextEditingController();
  String _categoryValue = '카테고리 선택';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 35,
            margin: EdgeInsets.only(top: 10),
            child: UploadInput(
              obscure: false,
              hint: "가격 입력",
              width: width * 0.95,
              text: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '원',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 35,
                margin: EdgeInsets.only(top: 10),
                child: UploadInput(
                  obscure: false,
                  hint: "브랜드 입력",
                  width: width * 0.65,
                  controller: _brandController,
                ),
              ),
              SizedBox(width: 7),
              Container(
                height: 35,
                margin: EdgeInsets.only(top: 10),
                width: width * 0.28,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey[400],
                  ),
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      _brandController.text = "브랜드 없음";
                    });
                  },
                  child: Center(
                    child: Text(
                      '브랜드 없음',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => CategoriesModal(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          '카테고리 선택',
                          style: TextStyle(
                            fontFamily: "Bold",
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Expanded(
                        child: ListView.builder(
                            itemCount: catListAll.length,
                            itemBuilder: (BuildContext context, int index) {
                              _dynamicView() {
                                if (index == 0) {
                                  return showFloatingModalBottomSheet(
                                      context: context,
                                      builder: (context) => CategoriesModal(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '상의',
                                                    style: TextStyle(
                                                      fontFamily: "Bold",
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Expanded(
                                                    child: ListView.builder(
                                                        itemCount:
                                                            catSub1.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Column(
                                                            children: [
                                                              Divider(),
                                                              ListTile(
                                                                visualDensity:
                                                                    VisualDensity(
                                                                        vertical:
                                                                            -4),
                                                                title: Text(
                                                                  '${catSub1[index]}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    _categoryValue =
                                                                        '${catListAll[0] + '/' + catSub1[index]}';
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        })),
                                                SizedBox(height: 20),
                                              ],
                                            ),
                                          ));
                                } else if (index == 1) {
                                  return showFloatingModalBottomSheet(
                                      context: context,
                                      builder: (context) => CategoriesModal(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '하의',
                                                    style: TextStyle(
                                                      fontFamily: "Bold",
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Expanded(
                                                    child: ListView.builder(
                                                        itemCount:
                                                            catSub2.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Column(
                                                            children: [
                                                              Divider(),
                                                              ListTile(
                                                                visualDensity:
                                                                    VisualDensity(
                                                                        vertical:
                                                                            -4),
                                                                title: Text(
                                                                  '${catSub2[index]}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    _categoryValue =
                                                                        '${catListAll[1] + '/' + catSub2[index]}';
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        })),
                                                SizedBox(height: 20),
                                              ],
                                            ),
                                          ));
                                } else if (index == 2) {
                                  return showFloatingModalBottomSheet(
                                      context: context,
                                      builder: (context) => CategoriesModal(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '아우터',
                                                    style: TextStyle(
                                                      fontFamily: "Bold",
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Expanded(
                                                    child: ListView.builder(
                                                        itemCount:
                                                            catSub3.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Column(
                                                            children: [
                                                              Divider(),
                                                              ListTile(
                                                                visualDensity:
                                                                    VisualDensity(
                                                                        vertical:
                                                                            -4),
                                                                title: Text(
                                                                  '${catSub3[index]}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    _categoryValue =
                                                                        '${catListAll[2] + '/' + catSub3[index]}';
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        })),
                                                SizedBox(height: 20),
                                              ],
                                            ),
                                          ));
                                } else if (index == 3) {
                                  return showFloatingModalBottomSheet(
                                      context: context,
                                      builder: (context) => CategoriesModal(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '원피스/세트',
                                                    style: TextStyle(
                                                      fontFamily: "Bold",
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Expanded(
                                                    child: ListView.builder(
                                                        itemCount:
                                                            catSub4.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Column(
                                                            children: [
                                                              Divider(),
                                                              ListTile(
                                                                visualDensity:
                                                                    VisualDensity(
                                                                        vertical:
                                                                            -4),
                                                                title: Text(
                                                                  '${catSub4[index]}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    _categoryValue =
                                                                        '${catListAll[3] + '/' + catSub4[index]}';
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        })),
                                                SizedBox(height: 20),
                                              ],
                                            ),
                                          ));
                                }
                              }

                              _custom() {
                                if (index == 4 || index == 5 || index == 6) {
                                  return ListTile(
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text(
                                      '${catListAll[index]}',
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black87),
                                    ),
                                    onTap: () {
                                      print(catListAll[index]);
                                      setState(() {
                                        _categoryValue = '${catListAll[index]}';
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                } else {
                                  return ListTile(
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text(
                                      '${catListAll[index]}',
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black87),
                                    ),
                                    onTap: () {
                                      print(catListAll[index]);
                                      return _dynamicView();
                                    },
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: Colors.black87,
                                    ),
                                  );
                                }
                              }

                              return Column(
                                children: [
                                  Divider(),
                                  _custom(),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Container(
              height: 35,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(top: 5, left: 15),
              width: width * 0.95,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey[400],
                ),
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _categoryValue,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15, bottom: 3),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SectionTitle(title: '의류 상태'),
          Container(
            alignment: Alignment.centerLeft,
            height: 35,
            margin: EdgeInsets.only(top: 10),
            child: UploadInput(
              obscure: false,
              hint: "Details",
              width: width * 0.95,
            ),
          ),
          SectionTitle(title: '사이즈'),
          Container(
            alignment: Alignment.centerLeft,
            height: 35,
            margin: EdgeInsets.only(top: 10),
            child: UploadInput(
              obscure: false,
              hint: "Details",
              width: width * 0.95,
            ),
          ),
          SectionTitle(title: '스타일'),
          Container(
            alignment: Alignment.centerLeft,
            height: 35,
            margin: EdgeInsets.only(top: 10),
            child: UploadInput(
              obscure: false,
              hint: "Details",
              width: width * 0.95,
            ),
          ),
          SectionTitle(title: '상품 설명 입력'),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            child: UploadInput(
              obscure: false,
              hint: "Details",
              height: 100,
              width: width * 0.95,
              lines: 8,
            ),
          ),
        ],
      ),
    );
  }
}
