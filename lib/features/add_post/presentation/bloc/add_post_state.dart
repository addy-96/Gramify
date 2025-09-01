part of 'add_post_bloc.dart';

sealed class AddPostState {}

final class AddpostInitialState extends AddPostState {}

final class AddPostPageLoadingState extends AddPostState {}

final class AddPostErrorState extends AddPostState {
  final String errorMessaage;

  AddPostErrorState({required this.errorMessaage});
}

final class PermissionDeniedState extends AddPostState {}

final class PermissionGrantedState extends AddPostState {}

final class AlbumListRetrievedState extends AddPostState {
  final List<AssetPathEntity> albumList;
  final AssetPathEntity selectedAlbum;

  AlbumListRetrievedState({required this.albumList, required this.selectedAlbum});
}

final class AssetsRetrievedState extends AddPostState {
  final List<AssetEntity> assetsList;
  final AssetEntity selectedPicture;

  AssetsRetrievedState({required this.assetsList, required this.selectedPicture});
}

final class PostUploadSuccessState extends AddPostState {}

final class PostUploadFailureState extends AddPostState {
  final String errorMessage;

  PostUploadFailureState({required this.errorMessage});
}

final class UplaodingStoryState extends AddPostState {}

final class StoryUplaodedState extends AddPostState {}

final class StoryUploadFailureState extends AddPostState {
  final String errorMessage;
  StoryUploadFailureState({required this.errorMessage});
}
