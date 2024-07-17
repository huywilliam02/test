import 'package:dashboard/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom_tool_tip.dart';

class DrawerItemList extends StatefulWidget {
  bool isExpanded;
  DrawerItemList({required this.isExpanded});
  @override
  _DrawerItemListState createState() => _DrawerItemListState();
}

class _DrawerItemListState extends State<DrawerItemList> {
  int? expandedIndex;
  int? selectedChildIndex;

  final List<Map<String, dynamic>> drawerItems = [
    {
      'icon': 'icons/ngoai_tru.svg',
      'text': 'Ngoại trú',
      'children': [
        {'text': 'Quản lý hồ sơ bệnh án'},
        {'text': 'Thông tin sinh hiệu'},
        {'text': 'Kết quả cận lâm sàng'},
      ],
    },
    {
      'icon': 'icons/noi_tru.svg',
      'text': 'Nội trú',
      'children': [
        {'text': 'Người bệnh tại khoa'},
        {'text': 'Thông tin sinh hiệu'},
        {'text': 'Kết quả cận lâm sàng'},
        {'text': 'Khám chuyên khoa'},
        {'text': 'Quản lý ra viện'},
      ],
    },
    {
      'icon': 'icons/hsba.svg',
      'text': 'Quản lý HSBA',
      'children': [],
    },
    {
      'icon': 'icons/du_lieu_dung_chung.svg',
      'text': 'Dữ liệu dùng chung',
      'children': [],
    },
    {
      'icon': 'icons/quan_tri_he_thong.svg',
      'text': 'Quản trị hệ thống',
      'children': [],
    },
    {
      'icon': 'icons/cai_dat.svg',
      'text': 'Cài đặt',
      'children': [],
    },
    {
      'icon': 'icons/thong_bao.svg',
      'text': 'Thông báo',
      'children': [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: drawerItems.length,
      itemBuilder: (context, index) {
        return widget.isExpanded
            ? ExpansionTile(
                title: Container(
                  decoration: BoxDecoration(
                      color: expandedIndex == index
                          ? ColorResources.mainMenu
                          : ColorResources.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        drawerItems[index]['icon'],
                        height: 20,
                        width: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(drawerItems[index]['text']),
                      ),
                    ],
                  ),
                ),
                children: List.generate(drawerItems[index]['children'].length,
                    (childIndex) {
                  final child = drawerItems[index]['children'][childIndex];
                  return Container(
                    margin: EdgeInsets.only(left: 40),
                    decoration: BoxDecoration(
                        color: expandedIndex == index &&
                                selectedChildIndex == childIndex
                            ? ColorResources.subMenu
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      title: Text(child['text']),
                      onTap: () {
                        setState(() {
                          expandedIndex = index;
                          selectedChildIndex = childIndex;
                          // Navigator.pop(context);
                        });
                      },
                    ),
                  );
                }),
                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedIndex = expanded ? index : null;
                    selectedChildIndex = null;
                  });
                },
              )
            : CustomTooltip(
                buttonNames: drawerItems[index]['children']
                    .map<String>((child) => child['text'] as String)
                    .toList(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      drawerItems[index]['icon'],
                      height: 20,
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        drawerItems[index]['text'],
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}
