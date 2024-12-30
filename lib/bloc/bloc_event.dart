part of 'bloc_bloc.dart';

@immutable
sealed class BlocEvent {}

final class OnUserMessageSendEvent extends BlocEvent {
  final String userMessage;

  OnUserMessageSendEvent({required this.userMessage});
}
