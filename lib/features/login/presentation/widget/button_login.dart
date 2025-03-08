import 'package:alw_alw/core/cache/cache_helper.dart';
import 'package:alw_alw/core/services/zego_service/zego_service.dart';
import 'package:alw_alw/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.prefs,
    required TextEditingController idController,
    required TextEditingController nameController,
  }) : _formKey = formKey, _idController = idController, _nameController = nameController;

  final GlobalKey<FormState> _formKey;
  final CacheHelper prefs;
  final TextEditingController _idController;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            prefs.saveData(key: 'id', value: _idController.text);
            prefs.saveData(
                key: 'userName', value: _nameController.text);
            ZegoService zegoService = ZegoService();
            zegoService.onUserLogin(
              userID: _idController.text,
              userName: _nameController.text,
            );
            await CacheHelper()
                .saveData(key: 'isLoggedIn', value: true);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return HomeView();
              },
            ));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
