import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:gramify/add_post/presentation/bloc/add_post_event.dart';
import 'package:gramify/add_post/presentation/bloc/add_post_state.dart';
import 'package:gramify/add_post/presentation/bloc/cubit/selectedPicture_cubit.dart';
import 'package:gramify/add_post/presentation/camera_page.dart';
import 'package:gramify/add_post/presentation/post_creator_page.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPhotoMobilePage extends StatefulWidget {
  const AddPhotoMobilePage({super.key});

  @override
  State<AddPhotoMobilePage> createState() => _AddPostMobilePageState();
}

class _AddPostMobilePageState extends State<AddPhotoMobilePage> {
  @override
  void initState() {
    context.read<AddPostBloc>().add(CheckAssetPermisiion());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: ShaderIcon(
          iconWidget: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: ShaderText(textWidget: Text('Create')),
        actionsPadding: EdgeInsets.all(8),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PostCreatorPage()),
              );
            },
            child: ShaderIcon(
              iconWidget: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
        ],
      ),
      body: BlocConsumer<AddPostBloc, AddPostState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AddPostPageLoadingState) {
            return ShaderNormal(childWidget: CircularProgressIndicator());
          }
          if (state is PermissionDeniedState) {
            return Center(child: grantPermissionButton());
          }
          if (state is PermissionGrantedState) {
            context.read<AddPostBloc>().add(GetAllAlbumsRequested());
          }
          return Column(
            children: [PictureContainer(), MenuContainer(), AlbumGridView()],
          );
        },
      ),
    );
  }

  Widget grantPermissionButton() => Center(
    child: InkWell(
      enableFeedback: true,
      borderRadius: BorderRadius.circular(50),
      splashColor: thmegrad1,
      onTap: () {
        context.read<AddPostBloc>().add(CheckAssetPermisiion());
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(colors: [thmegrad1, thmegrad2]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),

                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShaderText(
                  textWidget: Text(
                    'Grant Permission',
                    style: txtStyleNoColor(22),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

//
class PictureContainer extends StatefulWidget {
  const PictureContainer({super.key});

  @override
  State<PictureContainer> createState() => _PictureContainerState();
}

class _PictureContainerState extends State<PictureContainer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 2.5;
    return BlocBuilder<SelectedpictureCubit, AssetEntity?>(
      builder: (context, state) {
        if (state == null) {
          return ShimmerContainer(height: height, width: double.infinity);
        } else {
          return FutureBuilder(
            future: state.file,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 1000,
                  ), // slower, more relaxed
                  switchInCurve: Curves.easeInOutCubic,
                  switchOutCurve: Curves.easeOut,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.file(
                      snapshot.data!,
                      key: ValueKey(
                        snapshot.data!.path,
                      ), // Important to make AnimatedSwitcher detect changes
                      height: height,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
              return ShimmerContainer(height: height, width: double.infinity);
            },
          );
        }
      },
    );
  }
}

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
          context.read<AddPostBloc>().add(
            GetAllAssetsRequested(selectedAlbum: state.albumList[0]),
          );
          albumlist = state.albumList;
          selectedalbum = state.selectedAlbum;
        }
        if (state is AssetsRetrievedState) {
          context.read<SelectedpictureCubit>().pictureSelected(
            state.selectedPicture,
          );

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<AssetPathEntity>(
                  value: selectedalbum,
                  items: [
                    for (var item in albumlist)
                      DropdownMenuItem(value: item, child: Text(item.name)),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      selectedalbum = value;
                      context.read<AddPostBloc>().add(
                        GetAllAssetsRequested(selectedAlbum: selectedalbum!),
                      );
                    }
                  },
                ),
                InkWell(
                  enableFeedback: false,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CameraPage()),
                    );
                  },
                  child: ShaderIcon(
                    iconWidget: Icon(Ionicons.camera_outline, size: 30),
                  ),
                ),
              ],
            ),
          );
        }
        return Row(children: [ShimmerContainer(height: 30, width: 80)]);
      },
    );
  }
}

class AlbumGridView extends StatelessWidget {
  const AlbumGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostState>(
      builder: (context, state) {
        if (state is AssetsRetrievedState) {
          return Expanded(
            child: GridView.builder(
              itemCount: state.assetsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(4),
                  child: InkWell(
                    enableFeedback: true,
                    onTap: () {
                      context.read<SelectedpictureCubit>().pictureSelected(
                        state.assetsList[index],
                      );
                    },
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: FutureBuilder(
                        future: state.assetsList[index].file,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Image.file(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            );
                          }
                          return ShimmerContainer(height: 50, width: 50);
                        },
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
            ),
          );
        }

        return Expanded(
          child: GridView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(4),
                child: ShimmerContainer(height: 50, width: 50),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
          ),
        );
      },
    );
  }
}
