import 'package:gramify/features/wrapper/domain/entities/user.dart';

sealed class WrapperState {}

final class WrapperInitState extends WrapperState {}

final class WrapperLoadingState extends WrapperState {}

final class WrapperErrorState extends WrapperState {}

final class WrapperHomeState extends WrapperState {
  final User? user;
  WrapperHomeState(this.user);
}
