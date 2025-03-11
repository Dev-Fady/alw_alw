// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'package:alw_alw/features/add_pepole/domain/entites/add_pepole_entity.dart';

class BodyHomeView extends StatelessWidget {

  final List<AddPepoleEntity> users;
  const BodyHomeView({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users List")),
      body: users.isEmpty
          ? Center(child: Text("No users available"))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      user.userName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    subtitle: Text(
                      "ID: ${user.iD}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: SizedBox(
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: ZegoSendCallInvitationButton(
                                isVideoCall: false,
                                resourceID: "alw-alw",
                                invitees: [
                                  ZegoUIKitUser(
                                    id: user.iD,
                                    name: user.userName,
                                  ),
                                ],
                              ),
                            ),
                            Transform.scale(
                              scale: 1.5,
                              child: ZegoSendCallInvitationButton(
                                isVideoCall: true,
                                resourceID: "alw-alw",
                                invitees: [
                                  ZegoUIKitUser(
                                    id: user.iD,
                                    name: user.userName,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
