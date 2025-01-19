part of 'img_generator_bloc_bloc.dart';

@immutable
sealed class ImgGeneratorBlocEvent {}

final class InitialEvent extends ImgGeneratorBlocEvent{
  
}

final class OnGenerateButtonClickedEvent extends ImgGeneratorBlocEvent {
  final String prompt;

  OnGenerateButtonClickedEvent({required this.prompt});
}
