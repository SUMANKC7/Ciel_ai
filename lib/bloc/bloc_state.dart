part of 'bloc_bloc.dart';

@immutable
sealed class BlocState {}

final class BlocInitial extends BlocState {}

final class SuccessState extends BlocState {
  final List<ChatMessageModel>  bothmessages;

  SuccessState({required this.bothmessages});

}
