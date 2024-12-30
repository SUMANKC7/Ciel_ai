import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ciel_ai/model/chat_message_model.dart';
import 'package:ciel_ai/repos/chat_repo.dart';
import 'package:meta/meta.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  List<ChatMessageModel> messages = [];
  BlocBloc() : super(SuccessState(bothmessages: [])) {
    on<OnUserMessageSendEvent>(onUserMessageSendEvent);
  }
  FutureOr<void> onUserMessageSendEvent(
      OnUserMessageSendEvent event, Emitter<BlocState> emit) async {
    messages.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.userMessage)]));
    emit(SuccessState(bothmessages: messages));
    // await CielRepo.chatTextGenerationRepo(messages);
  }
}
