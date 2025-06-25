import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';

class SettingsOption extends StatefulWidget {
  const SettingsOption({
    super.key,
    required this.settingsTitle,
    required this.settingIcon,
    required this.subTitleText,
  });
  final String settingsTitle;
  final IoniconsData settingIcon;
  final String subTitleText;

  @override
  State<SettingsOption> createState() => _SettingsOptionState();
}

class _SettingsOptionState extends State<SettingsOption> {
  final titleStyle = txtStyle(
    subTitle20,
    Colors.white,
  ).copyWith(fontWeight: FontWeight.w400);

  final subTitleStyle = txtStyle(
    bodyText14,
    Colors.grey.shade700,
  ).copyWith(fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enableFeedback: true,
      splashColor: Colors.transparent,
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(widget.settingIcon, size: subTitle18, color: Colors.white),
      ),
      title: Text(widget.settingsTitle, style: titleStyle),
      trailing: const Icon(Ionicons.chevron_forward_outline, size: subTitle20),
      subtitle: Text(widget.subTitleText),
      subtitleTextStyle: subTitleStyle,
    );
  }
}
