import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/add_post/domain/repositories/add_post_repositories.dart';
import 'package:photo_manager/photo_manager.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final AddPostRepositories addPostRepositories;
  AddPostBloc({required this.addPostRepositories})
    : super(AddpostInitialState()) {
    //
    on<CheckAssetPermisiion>(_onCheckAssetPermission);

    //
    on<GetAllAlbumsRequested>(_onGetAllAlbumsRequested);

    //
    on<GetAllAssetsRequested>(_onGetAllAssetsRequested);

    //
    on<UploadPostRequested>(_onUploadPostRequested);
  }

  _onCheckAssetPermission(
    CheckAssetPermisiion event,
    Emitter<AddPostState> emit,
  ) async {
    final permission = await PhotoManager.requestPermissionExtend();

    permission.isAuth
        ? emit(PermissionGrantedState())
        : emit(PermissionDeniedState());
  }

  _onGetAllAlbumsRequested(
    GetAllAlbumsRequested event,
    Emitter<AddPostState> emit,
  ) async {
    try {
      final res = await addPostRepositories.loadAlbumbs(RequestType.common);

      res.fold(
        (l) => emit(
          AddPostErrorState(
            errorMessaage: 'GetAllAlbumsRequested (try) : ${l.message}',
          ),
        ),
        (r) =>
            emit(AlbumListRetrievedState(albumList: r!, selectedAlbum: r[0])),
      );
    } catch (err) {
      emit(
        AddPostErrorState(
          errorMessaage: 'GetAllAlbumsRequested (cath)) : ${err.toString()}',
        ),
      );
    }
  }

  _onGetAllAssetsRequested(
    GetAllAssetsRequested event,
    Emitter<AddPostState> emit,
  ) async {
    try {
      final res = await addPostRepositories.loadAssets(event.selectedAlbum);

      res.fold(
        (l) => emit(
          AddPostErrorState(
            errorMessaage: 'GetAllAlbumsRequested (cath)) : $l',
          ),
        ),
        (r) =>
            emit(AssetsRetrievedState(assetsList: r!, selectedPicture: r[0])),
      );
    } catch (err) {
      AddPostErrorState(
        errorMessaage: 'GetAllAlbumsRequested (cath)) : ${err.toString()}',
      );
    }
  }

  _onUploadPostRequested(
    UploadPostRequested event,
    Emitter<AddPostState> emit,
  ) async {
    try {
      emit(AddPostPageLoadingState());
      final res = await addPostRepositories.uploadPost(
        postImage: event.postImage,
        postCaption: event.postCaption,
      );

      res.fold(
        (l) => emit(PostUploadFailureState(errorMessage: l.message)),
        (r) => emit(PostUploadSuccessState()),
      );
    } catch (err) {
      emit(PostUploadFailureState(errorMessage: err.toString()));
    }
  }
}
