import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:quick_meet/services/jitsi_meet_service.dart';

import 'meeting_event.dart';
import 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc() : super(InitialState()) {
    on<InitEvent>(_init);
    on<StartMeetingEvent>(_createNewMeeting);
    on<JoinMeetingEvent>(_joinMeeting);
  }

  JitsiMeetService _meetService = JitsiMeetService();

  void _init(InitEvent event, Emitter<MeetingState> emit) async {
    emit(state);
  }

  Future _createNewMeeting(
      StartMeetingEvent event, Emitter<MeetingState> emit) async {
    var random = Random();
    String roomName = (random.nextInt(1000000000) + 10000000).toString();

    try {
      emit(LoadingState());
      await _meetService.createMeeting(
          roomName: roomName, isAudioMuted: true, isVideoMuted: true);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future _joinMeeting(
      JoinMeetingEvent event, Emitter<MeetingState> emit) async {
    try {
      emit(LoadingState());
      await _meetService.createMeeting(
          roomName: event.roomName,
          isAudioMuted: event.isAudioMuted,
          isVideoMuted: event.isVideoMuted,
          userName: event.userName);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
