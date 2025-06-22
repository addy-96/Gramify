import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_event.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_state.dart';
import 'package:gramify/features/home/presentation/widgets/post.dart';

class PostSection extends StatefulWidget {
  const PostSection({super.key});

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  @override
  void initState() {
    super.initState();
    context.read<HomepageBloc>().add(FeedsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<HomepageBloc, HomepageState>(
        listener: (context, state) {
          if (state is HomePageInititalState) {
            context.read<HomepageBloc>().add(FeedsRequested());
          }
        },
        builder: (context, state) {
          if (state is HomePageLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FeedsFetchedState) {
            if (state.feedList.isEmpty) {
              return const Center(
                child: Text('No Feeds to show, follw more people : )'),
              );
            }
            return ListView.builder(
              itemCount: state.feedList.length,
              itemBuilder: (context, index) {
                final feed = state.feedList[index];
                return Post(post: feed);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
