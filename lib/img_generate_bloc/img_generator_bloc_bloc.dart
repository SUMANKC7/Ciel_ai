import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:ciel_ai/repos/image_repo.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'img_generator_bloc_event.dart';
part 'img_generator_bloc_state.dart';

class ImgGeneratorBlocBloc
    extends Bloc<ImgGeneratorBlocEvent, ImgGeneratorBlocState> {
  ImgGeneratorBlocBloc() : super(ImgGeneratorBlocInitial()) {
    on<OnGenerateButtonClickedEvent>(onGenerateButtonClickedEvent);
    on<InitialEvent>(initialEvent);
  }

  FutureOr<void> onGenerateButtonClickedEvent(
      OnGenerateButtonClickedEvent event,
      Emitter<ImgGeneratorBlocState> emit) async {
    try {
      emit(ImgGeneratorLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      Uint8List? bytes = await ImageRepo.generateImage(event.prompt);
      if (bytes != null) {
        emit(ImgGeneratorSuccessState(bytes));
      } else {
        emit(ImgGeneratorFailedState());
      }
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> initialEvent(
      InitialEvent event, Emitter<ImgGeneratorBlocState> emit) async {
    try {
      Uint8List bytes = await rootBundle
          .load('assets/temple.jpg')
          .then((data) => data.buffer.asUint8List());
      emit(ImgGeneratorSuccessState(bytes));
    } catch (e) {
      emit(ImgGeneratorFailedState());
    }
  }
}
