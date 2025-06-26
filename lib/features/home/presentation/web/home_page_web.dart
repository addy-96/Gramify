import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_event.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_state.dart';
import 'package:gramify/features/home/presentation/widgets/post.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({super.key, required this.loggedUserId});
  final String loggedUserId;

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  @override
  void initState() {
    super.initState();
    context.read<HomepageBloc>().add(FeedsRequested());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth =
        screenWidth >= xxlMax
            ? 400
            : screenWidth >= xlMax
            ? screenWidth / 14.0
            : screenWidth >= lgMAx
            ? screenWidth / 1.2
            : screenWidth >= mdMax
            ? screenWidth / 10
            : screenWidth >= smMax
            ? screenWidth / 7.6
            : screenWidth / 5.7;
    return Row(
      children: [
        SizedBox(width: screenWidth >= 600 ? screenWidth / 12 : 10),
        SizedBox(
          width: screenWidth >= 600 ? 450 : 400,

          child: BlocConsumer<HomepageBloc, HomepageState>(
            builder: (context, state) {
              if (state is FeedsFetchedState) {
                if (state.feedList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.feedList.length,
                    itemBuilder: (context, index) {
                      return Post(post: state.feedList[index]);
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No Feeds to show, Follow more people'),
                  );
                }
              }
              if (state is HomePageLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return const Center(child: Text('No State'));
            },
            listener: (context, state) {
              if (state is HomePageErrorState) {}
            },
          ),
        ),
        SizedBox(width: screenWidth >= 650 ? screenWidth / 12 : 10),
      ],
    );
  }
}
