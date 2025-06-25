import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:ionicons/ionicons.dart';

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({super.key, required this.loggedUserId});
  final String loggedUserId;

  @override
  Widget build(BuildContext context) {
    final scrrenHeight = MediaQuery.of(context).size.height;
    final scrrenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Gap(scrrenWidth / 5),
        Container(height: 50, width: scrrenWidth / 3, color: Colors.green),
        const Gap(20),
        Container(height: 50, width: scrrenWidth / 4, color: Colors.green),
      ],
    );
  }
}
