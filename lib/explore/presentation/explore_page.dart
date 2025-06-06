import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:gramify/explore/presentation/bloc/explore_bloc/explore_event.dart';
import 'package:gramify/explore/presentation/bloc/explore_bloc/explore_state.dart';
import 'package:gramify/explore/presentation/bloc/explore_tab_bloc/explore_tab_bloc.dart';
import 'package:gramify/explore/presentation/bloc/explore_tab_bloc/explore_tab_event.dart';
import 'package:gramify/explore/presentation/bloc/explore_tab_bloc/explore_tab_state.dart';
import 'package:gramify/profile/presentation/profile_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    context.read<ExploreTabBloc>().add(ExploreTabSelectedEvent(index: 0));
    super.initState();
  }

  Widget tabDisplay() {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        if (state is ExploreInintialState) {
          return Center(
            child: Text(
              'Search to Explore...',
              style: txtStyle(22, whiteForText),
            ),
          );
        }
        if (state is ExploreLoadingState) {
          return Center(child: CircularProgressIndicator(year2023: true));
        }
        if (state is SearchPeopleSuccessState) {
          if (searchController.text.isEmpty) {
            state.peopleList = [];
            return Center(
              child: Text(
                'Search to Explore...',
                style: txtStyle(22, whiteForText),
              ),
            );
          }
          if (state.peopleList.isEmpty) {
            return Center(
              child: Text('No User Found', style: txtStyle(22, whiteForText)),
            );
          }
          return ListView.builder(
            itemCount: state.peopleList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => ProfilePage(
                            userId: state.peopleList[index].userId,
                          ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage:
                      state.peopleList[index].profileImageUrl == null
                          ? null
                          : NetworkImage(
                            state.peopleList[index].profileImageUrl!,
                          ),
                ),
                title: Text(
                  state.peopleList[index].username,
                  style: txtStyle(22, whiteForText),
                ),
              );
            },
          );
        }
        return Center(
          child: Text(
            'Search to Explore...',
            style: txtStyle(22, whiteForText),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                          controller: searchController,
                          keyboardAppearance: Brightness.dark,
                          style: txtStyle(18, whiteForText),
                          onChanged: (value) {
                            if (value.isEmpty) {}
                            if (selectedIndex == 0) {
                            } else if (selectedIndex == 1) {
                              context.read<ExploreBloc>().add(
                                SearchPeopleRequested(searchQuery: value),
                              );
                            } else if (selectedIndex == 2) {}
                          },

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
          Expanded(
            child: BlocBuilder<ExploreTabBloc, ExploreTabState>(
              builder: (context, state) {
                if (state is AllTabSelected) {
                  selectedIndex = 0;
                }
                if (state is PeopleTabSelected) {
                  selectedIndex = 1;
                  return tabDisplay();
                }
                if (state is GramsTabSelected) {
                  selectedIndex = 2;
                }
                return Container();
              },
            ),
          ),
        ],
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
