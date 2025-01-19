part of 'img_generator_bloc_bloc.dart';

@immutable
sealed class ImgGeneratorBlocState {}

final class ImgGeneratorBlocInitial extends ImgGeneratorBlocState {}

final class ImgGeneratorSuccessState extends ImgGeneratorBlocState {
  final Uint8List uint8list;

  ImgGeneratorSuccessState(this.uint8list);
}

final class ImgGeneratorFailedState extends ImgGeneratorBlocState {}

final class ImgGeneratorLoadingState extends ImgGeneratorBlocState {}
