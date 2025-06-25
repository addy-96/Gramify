import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:gramify/features/explore/presentation/bloc/explore_tab_bloc/explore_tab_bloc.dart';
import 'package:gramify/features/explore/presentation/widgets/explore_tab_menu.dart';
import 'package:gramify/features/profile/presentation/mobile/profile_page.dart';
import 'package:ionicons/ionicons.dart';

class ExplorePageMobile extends StatefulWidget {
  const ExplorePageMobile({super.key});

  @override
  State<ExplorePageMobile> createState() => _ExplorePageMobileState();
}

class _ExplorePageMobileState extends State<ExplorePageMobile> {
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

  final List<String> tabNames = ['People', 'Grams'];

  Widget peopleTabDisplay() {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        if (state is ExploreInintialState) {
          return Center(
            child: Text(
              'Search to Explore...',
              style: txtStyle(bodyText16, Colors.grey.shade800),
            ),
          );
        }
        if (state is ExploreLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SearchPeopleSuccessState) {
          if (searchController.text.isEmpty) {
            state.peopleList = [];
            return Center(
              child: Text(
                'Search to explore...',
                style: txtStyle(bodyText16, Colors.grey.shade800),
              ),
            );
          }
          if (state.peopleList.isEmpty) {
            return Center(
              child: Text(
                'No User Found!',
                style: txtStyle(bodyText16, Colors.grey.shade800),
              ),
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
                          (context) => ProfilePageMobile(
                            userId: state.peopleList[index].userId,
                          ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 25,
                  backgroundImage:
                      state.peopleList[index].profileImageUrl == null
                          ? null
                          : NetworkImage(
                            state.peopleList[index].profileImageUrl!,
                          ),
                ),
                title: Text(
                  state.peopleList[index].username,
                  style: txtStyle(bodyText16, whiteForText),
                ),
              );
            },
          );
        }
        return Center(
          child: Text(
            'Search to explore...',
            style: txtStyle(bodyText16, whiteForText),
          ),
        );
      },
    );
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white24),
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(14),
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
                  style: txtStyle(bodyText16, whiteForText),
                  onChanged: (value) {
                    if (value.isEmpty) {}
                    if (selectedIndex == 0) {
                      context.read<ExploreBloc>().add(
                        SearchPeopleRequested(searchQuery: value),
                      );
                    } else if (selectedIndex == 1) {}
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
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i <= 1; i++)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context.read<ExploreTabBloc>().add(
                        ExploreTabSelectedEvent(index: i),
                      );
                      if (searchController.text.trim().isEmpty) {
                        return;
                      }
                      if (i == 0) {
                      } else if (i == 1) {
                        context.read<ExploreBloc>().add(
                          SearchPeopleRequested(
                            searchQuery: searchController.text,
                          ),
                        );
                      } else if (i == 2) {}
                    },
                    child: ExploreTabMenu(tabName: tabNames[i], index: i),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            searchBox(),
            Flexible(
              child: BlocBuilder<ExploreTabBloc, ExploreTabState>(
                builder: (context, state) {
                  if (state is PeopleTabSelected) {
                    selectedIndex = 0;
                    return peopleTabDisplay();
                  }
                  if (state is GramsTabSelected) {
                    selectedIndex = 1;
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
