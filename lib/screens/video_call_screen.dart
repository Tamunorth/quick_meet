import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:quick_meet/blocs/meeting/meeting_event.dart';
import 'package:quick_meet/blocs/meeting/meeting_state.dart';
import 'package:quick_meet/services/auth_service.dart';
import 'package:quick_meet/utils/colors.dart';
import 'package:quick_meet/widgets/meeting_options.dart';

import '../blocs/meeting/meeting_bloc.dart';
import '../utils/app_snackbar.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthService authService = AuthService();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    nameController = TextEditingController(text: authService.user.displayName);
    meetingIdController = TextEditingController();
  }

  _joinMeeting() {

    BlocProvider.of<MeetingBloc>(context).add(JoinMeetingEvent(meetingIdController.text, userName: nameController.text, isAudioMuted: isAudioMuted, isVideoMuted:isVideoMuted ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }


  final _loadingKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeetingBloc, MeetingState>(
      listener: (context, state) {

        if (state is LoadingState) {
          QuickMeet.showLoading(context, _loadingKey);
        } else if (state is SuccessState) {
          QuickMeet.hideLoading(_loadingKey);
        } else if (state is ErrorState) {
          QuickMeet.showSnackBar(context, state.message, type: SnackType.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Pallets.backgroundColor,
            centerTitle: true,
            title: Text(
              'Join a meeting',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  controller: meetingIdController,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Pallets.secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Room ID',
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: nameController,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Pallets.secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Name',
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: _joinMeeting,
                child: Text(
                  'Join',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MeetingOptions(
                text: "Don't Join with Audio",
                isMuted: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              MeetingOptions(
                text: "Don't Join with Video",
                isMuted: isVideoMuted,
                onChanged: (value) {
                  setState(() {
                    isVideoMuted = value;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
