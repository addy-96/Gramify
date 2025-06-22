import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:gramify/features/add_post/presentation/bloc/cubit/selectedPicture_cubit.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';

class AlbumGridView extends StatelessWidget {
  const AlbumGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostState>(
      builder: (context, state) {
        if (state is AssetsRetrievedState) {
          return _buildGrid(
            itemCount: state.assetsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: FutureBuilder(
                    future: state.assetsList[index].file,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return InkWell(
                          onTap:
                              () => context
                                  .read<SelectedpictureCubit>()
                                  .pictureSelected(snapshot.data!),
                          child: Image.file(snapshot.data!, fit: BoxFit.cover),
                        );
                      }
                      return const ShimmerContainer(height: 50, width: 50);
                    },
                  ),
                ),
              );
            },
          );
        }

        // Loading state
        return _buildGrid(
          itemCount: 12,
          itemBuilder:
              (context, index) => const Padding(
                padding: EdgeInsets.all(4),
                child: ShimmerContainer(height: 50, width: 50),
              ),
        );
      },
    );
  }

  Widget _buildGrid({
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
  }) {
    return Expanded(
      child: GridView.builder(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
      ),
    );
  }
}
