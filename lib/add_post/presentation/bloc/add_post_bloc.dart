import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/add_post/domain/repositories/add_post_repositories.dart';
import 'package:gramify/add_post/presentation/bloc/add_post_event.dart';
import 'package:gramify/add_post/presentation/bloc/add_post_state.dart';
import 'package:photo_manager/photo_manager.dart';

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

  /*
  _onGetAllAssetsRequested(
    GetAllAssetsRequeted event,
    Emitter<AddPostState> emit,
  ) async {
    emit(AddPostPageLoadingState());

    try {
      final res = await addPostRepositories.loadAssets(event.selectedAlbum);

      res.fold(
        (l) => emit(
          AddPostErrorState(
            errorMessaage: 'GetAllAssetsRequested (cath)) : ${l.message}',
          ),
        ),
        (r) =>
            emit(AssetOfAlbumRetrieved(assetCount: r!.length, picturesList: r)),
      );
    } catch (err) {
      emit(
        AddPostErrorState(
          errorMessaage: 'GetAllAssetsRequested (cath)) : ${err.toString()}',
        ),
      );
    }
  }
*/
}
