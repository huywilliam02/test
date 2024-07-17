import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/colors/colors.dart';
import 'main_menu_tool_tip.dart';

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
      'icon': 'assets/icons/trang_chu.svg',
      'text': 'Trang chủ',
      'path': '/dashboard',
      'children': [],
    },
    {
      'icon': 'assets/icons/ngoai_tru.svg',
      'text': 'Ngoại trú',
      'path': '/outpatient',
      'children': [
        {
          'text': 'Người bệnh tại khoa',
          'path': '/outpatient/hospitalized_patient',
        },
        {
          'text': 'Thông tin sinh hiệu',
          'path': '/outpatient/vital_info',
        },
        {
          'text': 'Kết quả cận lâm sàng',
          'path': '/outpatient/lab_results',
        },
        {
          'text': 'Khám chuyên khoa',
          'path': '/outpatient/specialist_consultation',
        },
        {
          'text': 'Quản lý xuất viện',
          'path': '/outpatient/discharge_management',
        },
      ],
    },
    {
      'icon': 'assets/icons/noi_tru.svg',
      'text': 'Nội trú',
      'path': '/inpatient',
      'children': [
        {
          'text': 'Người bệnh tại khoa',
          'path': '/inpatient/lab_results',
        },
        {
          'text': 'Thông tin sinh hiệu',
          'path': '/inpatient/lab_results',
        },
        {
          'text': 'Kết quả cận lâm sàng',
          'path': '/inpatient/lab_results',
        },
        {
          'text': 'Khám chuyên khoa',
          'path': '/inpatient/lab_results',
        },
        {
          'text': 'Quản lý xuất viện',
          'path': '/inpatient/lab_results',
        },
      ],
    },
    {
      'icon': 'assets/icons/hsba.svg',
      'text': 'Quản lý HSBA',
      'path': '/medical_record_management',
      'children': [],
    },
    // {
    //   'icon': 'icons/du_lieu_dung_chung.svg',
    //   'text': 'Dữ liệu dùng chung',
    //   'children': [],
    // },
    {
      'icon': 'assets/icons/quan_tri_he_thong.svg',
      'text': 'Quản trị hệ thống',
      'path': '/system_administration',
      'children': [
        {
          'text': 'Quản lý tài khoản',
          'path': '/system_administration/account_management',
        },
        {
          'text': 'Tài khoản',
          'path': '/system_administration/account',
        },
        {
          'text': 'Nhóm quyền',
          'path': '/system_administration/rights_group',
        },
        {
          'text': 'Phân quyền',
          'path': '/system_administration/decentralization',
        },
      ],
    },
    {
      'icon': 'assets/icons/cai_dat.svg',
      'text': 'Cài đặt',
      'path': '/settings',
      'children': [],
    },
    {
      'icon': 'assets/icons/thong_bao.svg',
      'text': 'Thông báo',
      'path': '/notifications',
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
            ? CustomExpansionTile(
                title: GestureDetector(
                  onTap: () {
                    if (drawerItems[index]['children'].length == 0)
                      Navigator.of(context)
                          .pushNamed(drawerItems[index]['path']);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: expandedIndex == index
                          ? AppColors.mainMenu
                          : AppColors.drawerBg,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          drawerItems[index]['icon'],
                          height: 20,
                          width: 20,
                          color: AppColors.textBlack,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            drawerItems[index]['text'],
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ),
                        Spacer(),
                        if (drawerItems[index]['children'].length > 0)
                          SvgPicture.asset('assets/icons/arrow_right.svg'),
                      ],
                    ),
                  ),
                ),
                initiallyExpanded: expandedIndex == index,
                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedIndex = expanded ? index : null;
                    selectedChildIndex = null;
                  });
                },
                children: List.generate(drawerItems[index]['children'].length,
                    (childIndex) {
                  final child = drawerItems[index]['children'][childIndex];
                  return Container(
                    margin: EdgeInsets.only(left: 40, right: 10),
                    decoration: BoxDecoration(
                      color: expandedIndex == index &&
                              selectedChildIndex == childIndex
                          ? AppColors.subMenu
                          : AppColors.drawerBg,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      title: Text(
                        child['text'],
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          expandedIndex = index;
                          selectedChildIndex = childIndex;
                          Navigator.of(context).pushNamed(child['path']);
                        });
                      },
                    ),
                  );
                }),
              )
            : GestureDetector(
                onTap: () {
                  if (drawerItems[index]['children'].length == 0)
                    Navigator.of(context).pushNamed(drawerItems[index]['path']);
                },
                child: MainMenuTooltip(
                  buttonNames: drawerItems[index]['children']
                      .map<String>((child) => child['text'] as String)
                      .toList(),
                  buttonPaths: drawerItems[index]['children']
                      .map<String>((child) => child['path'] as String)
                      .toList(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          drawerItems[index]['icon'],
                          height: 20,
                          width: 20,
                          color: AppColors.textBlack,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            drawerItems[index]['text'],
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              color: AppColors.textBlack,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
  }) : super(key: key);

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(_isExpanded);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _handleTap,
          child: widget.title,
        ),
        if (_isExpanded) ...widget.children,
      ],
    );
  }
}
