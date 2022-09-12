import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:quick_meet/services/auth_service.dart';
import 'package:quick_meet/services/firestore_service.dart';

class JitsiMeetService {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  Future createMeeting(
      {required String roomName,
      required bool isAudioMuted,
      required bool isVideoMuted,
      String userName = ''}) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p

      String name;

      if (userName.isEmpty) {
        name = _authService.user.displayName!;
      } else {
        name = userName;
      }

      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userEmail = _authService.user.email
        ..userAvatarURL = _authService.user.photoURL // or .png
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      await _firestoreService.addToMeetingHistory(roomName);

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      rethrow;
    }
  }
}
