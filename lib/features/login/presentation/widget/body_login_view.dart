import 'package:alw_alw/core/cache/cache_helper.dart';
import 'package:alw_alw/features/login/presentation/widget/button_login.dart';
import 'package:alw_alw/features/login/presentation/widget/form_login.dart';
import 'package:flutter/material.dart';

class BodyLoginView extends StatefulWidget {
  const BodyLoginView({
    super.key,
  });

  @override
  State<BodyLoginView> createState() => _BodyLoginViewState();
}

class _BodyLoginViewState extends State<BodyLoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  CacheHelper prefs = CacheHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormLogin(formKey: _formKey, nameController: _nameController, idController: _idController),
            const SizedBox(height: 24),
            ButtonLogin(formKey: _formKey, prefs: prefs, idController: _idController, nameController: _nameController),
          ],
        ),
      ),
    );
  }
}


