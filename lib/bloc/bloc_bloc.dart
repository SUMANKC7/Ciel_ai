import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ciel_ai/model/chat_message_model.dart';
import 'package:ciel_ai/repos/chat_repo.dart';
import 'package:meta/meta.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(SuccessState(bothmessages: [])) {
    on<OnUserMessageSendEvent>(onUserMessageSendEvent);
  }
  List<ChatMessageModel> messages = [];
  FutureOr<void> onUserMessageSendEvent(
      OnUserMessageSendEvent event, Emitter<BlocState> emit) async {
    messages.add(
      ChatMessageModel(
          role: "user", parts: [ChatPartModel(text: event.userMessage)]),
    );
    emit(SuccessState(bothmessages: messages));
    String generatedText = await CielRepo.chatTextGenerationRepo(messages);
    if (generatedText.length > 0) {
      messages.add(ChatMessageModel(
          role: "model", parts: [ChatPartModel(text: generatedText)]));
      emit(SuccessState(bothmessages: messages));
    }
  }
}
