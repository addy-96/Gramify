import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:gramify/features/add_post/presentation/bloc/cubit/selectedPicture_cubit.dart';
import 'package:gramify/features/add_post/presentation/mobile/camera_page_for_post.dart';
import 'package:gramify/features/add_post/presentation/mobile/make_story_page.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_manager/photo_manager.dart';

class MenuContainer extends StatefulWidget {
  const MenuContainer({super.key});

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  List<AssetPathEntity> albumlist = [];
  AssetPathEntity? selectedalbum;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostState>(
      builder: (context, state) {
        if (state is AlbumListRetrievedState) {
          if (albumlist.isEmpty) {
            albumlist = state.albumList;
            selectedalbum = state.albumList[0];
            context.read<AddPostBloc>().add(
              GetAllAssetsRequested(selectedAlbum: selectedalbum!),
            );
          }
        }

        if (state is AssetsRetrievedState) {
          state.selectedPicture.file.then((value) {
            context.read<SelectedpictureCubit>().pictureSelected(value!);
          });

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<AssetPathEntity>(
                  icon: const Icon(Ionicons.chevron_down_outline, size: 20),

                  value: selectedalbum,
                  items:
                      albumlist.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item.name,
                            style: txtStyleNoColor(18),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedalbum = value;
                      });
                      context.read<AddPostBloc>().add(
                        GetAllAssetsRequested(selectedAlbum: value),
                      );
                    }
                  },
                ),
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      enableFeedback: false,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MakeStoryPage(),
                          ),
                        );
                      },
                      child: ShaderText(
                        textWidget: Text(
                          'Story',
                          style: txtStyleNoColor(subTitle20),
                        ),
                      ),
                    ),
                    const Gap(20),
                    InkWell(
                      enableFeedback: false,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CameraPageForPost(),
                          ),
                        );
                      },
                      child: const Icon(Ionicons.camera_outline, size: 30),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const Row(children: [ShimmerContainer(height: 30, width: 80)]);
      },
    );
  }
}
