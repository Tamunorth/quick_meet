import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_meet/blocs/meeting/meeting_bloc.dart';
import 'package:quick_meet/blocs/meeting/meeting_event.dart';
import 'package:quick_meet/blocs/meeting/meeting_state.dart';
import 'package:quick_meet/widgets/meeting_buttons.dart';

import '../utils/app_snackbar.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({
    Key? key,
  }) : super(key: key);

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
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MeetingButton(
                  onTap: () {
                    BlocProvider.of<MeetingBloc>(context)
                        .add(StartMeetingEvent());
                  },
                  text: "New Meeting",
                  icon: Icons.videocam,
                ),
                MeetingButton(
                  onTap: () {
                    
                    Navigator.pushNamed(context, '/video-call');
                  },
                  text: "Join Meeting",
                  icon: Icons.add_box_rounded,
                ),
                MeetingButton(
                  onTap: () {},
                  text: "Schedule Meeting",
                  icon: Icons.videocam,
                ),
                MeetingButton(
                  onTap: () {},
                  text: "Share Screen",
                  icon: Icons.arrow_upward,
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Create/Join Meetings with just a Click!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
