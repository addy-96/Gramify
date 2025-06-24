import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/explore/presentation/bloc/explore_tab_bloc/explore_tab_bloc.dart';

class ExploreTabMenu extends StatelessWidget {
  const ExploreTabMenu({super.key, required this.tabName, required this.index});
  final String tabName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreTabBloc, ExploreTabState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
            gradient:
                (state is PeopleTabSelected && index == 0) ||
                        (state is ExploreTabInititalState && index == 0) ||
                        (state is GramsTabSelected && index == 1)
                    ? const LinearGradient(colors: [thmegrad1, thmegrad2])
                    : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    (state is PeopleTabSelected && index == 0) ||
                            (state is ExploreTabInititalState && index == 0) ||
                            (state is PeopleTabSelected && index == 0) ||
                            (state is GramsTabSelected && index == 1)
                        ? ShaderText(
                          textWidget: Text(
                            tabName,
                            textAlign: TextAlign.center,
                            style: txtStyleNoColor(bodyText16),
                          ),
                        )
                        : Text(
                          tabName,
                          textAlign: TextAlign.center,
                          style: txtStyle(bodyText16, whiteForText),
                        ),
              ),
            ),
          ),
        );
      },
    );
  }
}
