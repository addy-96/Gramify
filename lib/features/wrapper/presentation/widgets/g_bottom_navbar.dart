import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/features/wrapper/presentation/bloc/nav_bar_cubit.dart';

class GBottomNavbar extends StatelessWidget {
  const GBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: Utils.getScreenHeight(context) / 10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavItem(context, context.watch<NavBarCubit>().state == 0 ? FontAwesomeIcons.solidHouse : FontAwesomeIcons.house, 0),
                buildNavItem(context, context.watch<NavBarCubit>().state == 1 ? FontAwesomeIcons.magnifyingGlassPlus : FontAwesomeIcons.magnifyingGlass, 1),
                buildNavItem(context, FontAwesomeIcons.circlePlus, 2),
                buildNavItem(context, context.watch<NavBarCubit>().state == 3 ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart, 3),
                buildNavItem(context, context.watch<NavBarCubit>().state == 4 ? FontAwesomeIcons.solidMap : FontAwesomeIcons.map, 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(BuildContext context, IconData iconData, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          enableFeedback: true,
          splashColor: Colors.grey.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            context.read<NavBarCubit>().updateIndex(index);
          },
          child: Icon(iconData, color: Colors.black87),
        ),
        if (context.watch<NavBarCubit>().state == index)
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 10,
            width: 10,
            decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(50)),
          ),
      ],
    );
  }
}
