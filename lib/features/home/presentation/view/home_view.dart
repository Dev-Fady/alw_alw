import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        child: Column(
          children: [
            ZegoSendCallInvitationButton(
              isVideoCall: true,
              //You need to use the resourceID that you created in the subsequent steps.
              //Please continue reading this document.
              resourceID: "zegouikit_call",
              invitees: [
                ZegoUIKitUser(
                  id: '12345',
                  name: 'fady',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
