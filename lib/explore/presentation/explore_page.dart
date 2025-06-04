import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/explore/presentation/bloc/explore_tab_bloc/explore_tab_bloc.dart';
import 'package:gramify/explore/presentation/bloc/explore_tab_bloc/explore_tab_event.dart';
import 'package:gramify/explore/presentation/bloc/explore_tab_bloc/explore_tab_state.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(colors: [thmegrad1, thmegrad2]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 2,
                        bottom: 2,
                      ),
                      child: TextField(
                        keyboardAppearance: Brightness.dark,
                        style: txtStyle(18, whiteForText),
                        onTapOutside: (event) {},
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: txtStyle(15, Colors.grey.shade800),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ExploreTabMenu(tabName: 'All', index: 0),
                  ExploreTabMenu(tabName: 'People', index: 1),
                  ExploreTabMenu(tabName: 'Grams', index: 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreTabMenu extends StatelessWidget {
  const ExploreTabMenu({super.key, required this.tabName, required this.index});
  final String tabName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          context.read<ExploreTabBloc>().add(
            ExploreTabSelectedEvent(index: index),
          );
        },
        child: BlocBuilder<ExploreTabBloc, ExploreTabState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                gradient:
                    (state is AllTabSelected && index == 0) ||
                            (state is ExploreTabInititalState && index == 0) ||
                            (state is PeopleTabSelected && index == 1) ||
                            (state is GramsTabSelected && index == 2)
                        ? LinearGradient(colors: [thmegrad1, thmegrad2])
                        : null,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        (state is AllTabSelected && index == 0) ||
                                (state is ExploreTabInititalState &&
                                    index == 0) ||
                                (state is PeopleTabSelected && index == 1) ||
                                (state is GramsTabSelected && index == 2)
                            ? ShaderText(
                              textWidget: Text(
                                tabName,
                                textAlign: TextAlign.center,
                                style: txtStyleNoColor(18),
                              ),
                            )
                            : Text(
                              tabName,
                              textAlign: TextAlign.center,
                              style: txtStyle(18, whiteForText),
                            ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
