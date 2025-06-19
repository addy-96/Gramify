part of 'add_post_bloc.dart';

sealed class AddPostEvent {}

final class CheckAssetPermisiion extends AddPostEvent {}

final class GetAllAlbumsRequested extends AddPostEvent {}

final class GetAllAssetsRequested extends AddPostEvent {
  final AssetPathEntity selectedAlbum;

  GetAllAssetsRequested({required this.selectedAlbum});
}

final class UploadPostRequested extends AddPostEvent {
  final File postImage;
  final String? postCaption;

  UploadPostRequested({required this.postCaption, required this.postImage});
}
