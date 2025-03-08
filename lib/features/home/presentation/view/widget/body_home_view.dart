import 'package:alw_alw/features/home/presentation/view/widget/view_my_date.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class BodyHomeView extends StatefulWidget {
  const BodyHomeView({
    super.key,
  });

  @override
  State<BodyHomeView> createState() => _BodyHomeViewState();
}

class _BodyHomeViewState extends State<BodyHomeView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                ViewMyDate(),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.credit_card),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your ID';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ZegoUIKitPrebuiltCallInvitationService().send(
                  invitees: [
                    ZegoCallUser(
                      _idController.text.trim(),
                      _nameController.text.trim(),
                    ),
                  ],
                  isVideoCall: false,
                  resourceID: "alw-alw",
                );
              }
              setState(() {});
            },
            child: const Text('Call'),
          ),
          // ZegoSendCallInvitationButton(
          //   isVideoCall: false,
          //   resourceID: "alw-alw",
          //   invitees: [
          //     ZegoUIKitUser(
          //       id: _idController.text.trim(),
          //       name: _nameController.text.trim(),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
