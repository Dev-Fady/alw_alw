import 'package:flutter/material.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController idController,
  }) : _formKey = formKey, _nameController = nameController, _idController = idController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _idController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
    );
  }
}
