import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:gramify/features/add_post/presentation/mobile/post_creator_page.dart';
import 'package:gramify/features/add_post/presentation/mobile/widgets/album_grid_view.dart';
import 'package:gramify/features/add_post/presentation/mobile/widgets/grant_permission_button.dart';
import 'package:gramify/features/add_post/presentation/mobile/widgets/menu_container.dart';
import 'package:gramify/features/add_post/presentation/mobile/widgets/picture_container.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';

class SelectPostPicture extends StatefulWidget {
  const SelectPostPicture({super.key});

  @override
  State<SelectPostPicture> createState() => _SelectPostPictureState();
}

class _SelectPostPictureState extends State<SelectPostPicture> {
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
        leading: IconButton(
          icon: const ShaderIcon(
            iconWidget: Icon(Icons.arrow_back_ios_new_outlined),
          ),
          onPressed: () => context.pop(),
        ),
        title: const ShaderText(textWidget: Text('Create Post')),
        actions: [
          IconButton(
            icon: const ShaderIcon(
              iconWidget: Icon(Icons.arrow_forward_ios_outlined),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PostCreatorPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<AddPostBloc, AddPostState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AddPostPageLoadingState) {
            return const Center(
              child: ShaderNormal(childWidget: CircularProgressIndicator()),
            );
          }
          if (state is PermissionDeniedState) {
            return Center(child: grantPermissionButton(context));
          }
          if (state is PermissionGrantedState) {
            // Only trigger once to avoid repeated calls
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<AddPostBloc>().add(GetAllAlbumsRequested());
            });
            return const Center(child: CircularProgressIndicator());
          }
          return const Column(
            children: [PictureContainer(), MenuContainer(), AlbumGridView()],
          );
        },
      ),
    );
  }
}

//
