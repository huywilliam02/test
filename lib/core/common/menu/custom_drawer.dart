import 'package:dashboard/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'drawer_item_list.dart';

class CustomDrawer extends StatefulWidget {
  bool isExpanded;
  CustomDrawer({required this.isExpanded});
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorResources.transparent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Row(
            mainAxisAlignment: widget.isExpanded
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Container(
                width: 46,
                height: 38,
                margin: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
                decoration: BoxDecoration(
                    color: ColorResources.textBlue, shape: BoxShape.circle),
                child: Image.asset(
                  'images/doctor.png',
                  fit: BoxFit.contain,
                ),
              ),
              if (widget.isExpanded)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BÁC SĨ',
                      style: TextStyle(color: ColorResources.lightBlack),
                    ),
                    Text(
                      'TRẦN THANH SƠN',
                      style: TextStyle(color: ColorResources.black),
                    ),
                  ],
                ),
            ],
          ),
          DrawerItemList(isExpanded: widget.isExpanded),
        ],
      ),
    );
  }
}
