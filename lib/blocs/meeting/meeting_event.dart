abstract class MeetingEvent {}

class InitEvent extends MeetingEvent {}

class StartMeetingEvent extends MeetingEvent {}

class JoinMeetingEvent extends MeetingEvent {
  final String roomName;
  final bool isAudioMuted;
  final bool isVideoMuted;
  final String userName;

  JoinMeetingEvent(
    this.roomName, {
    this.isAudioMuted = true,
    this.isVideoMuted = true,
    this.userName = '',
  });
}
