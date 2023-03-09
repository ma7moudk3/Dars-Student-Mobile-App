import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({Key? key, required this.menulist, this.icon})
      : super(key: key);
  final List<PopupMenuEntry> menulist;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      itemBuilder: (((BuildContext context) => menulist)),
      icon: icon,
    );
  }
}
