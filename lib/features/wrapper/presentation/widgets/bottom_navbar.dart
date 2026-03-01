import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/features/wrapper/presentation/bloc/nav_bar_cubit.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final navHeight = Utils.getScreenHeight(context) / 10;

    return Padding(
      padding: const EdgeInsets.all(10), 
      child: Material(
        color: Colors.transparent, 
        child: Container(
          height: navHeight,
          decoration: BoxDecoration(
            color: Colors.white, // only the inner pill shape is white
            borderRadius: BorderRadius.circular(100),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavItem(context, context.watch<NavBarCubit>().state == 0 ? FontAwesomeIcons.solidHouse : FontAwesomeIcons.house, 0),
                buildNavItem(context, context.watch<NavBarCubit>().state == 1 ? FontAwesomeIcons.magnifyingGlassPlus : FontAwesomeIcons.magnifyingGlass, 1),
                buildNavItem(context, context.watch<NavBarCubit>().state == 3 ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart, 2),
                buildNavItem(context, context.watch<NavBarCubit>().state == 4 ? FontAwesomeIcons.solidMap : FontAwesomeIcons.map, 3),
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
          onTap: () => context.read<NavBarCubit>().updateIndex(index),
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
