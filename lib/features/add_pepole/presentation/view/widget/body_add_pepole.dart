import 'package:alw_alw/features/add_pepole/domain/entites/add_pepole_entity.dart';
import 'package:alw_alw/features/add_pepole/presentation/manger/cubit/add_pepole_cubit.dart';
import 'package:alw_alw/features/add_pepole/presentation/view/widget/view_my_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyAddPepole extends StatefulWidget {
  const BodyAddPepole({
    super.key,
  });

  @override
  State<BodyAddPepole> createState() => _BodyAddPepoleState();
}

class _BodyAddPepoleState extends State<BodyAddPepole> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<AddPepoleCubit, AddPepoleState>(
        listener: (context, state) {
          if (state is AddPepoleSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Add pepole successful'),
              ),
            );
          } else if (state is AddPepoleFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Add pepole failed'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
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
              state is AddPepoleLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AddPepoleCubit>(context).addPepole(
                            AddPepoleEntity(
                              iD: _idController.text.trim(),
                              userName: _nameController.text.trim(),
                            ),
                          );
                        }
                      },
                      child: const Text('Add Pepole'),
                    ),
            ],
          );
        },
      ),
    );
  }
}
/**
 *   ZegoUIKitPrebuiltCallInvitationService().send(
                            invitees: [
                              ZegoCallUser(
                                _idController.text.trim(),
                                _nameController.text.trim(),
                              ),
                            ],
                            isVideoCall: false,
                            resourceID: "alw-alw",
                          );
 */
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