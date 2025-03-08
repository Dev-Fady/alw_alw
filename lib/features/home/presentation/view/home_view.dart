import 'package:alw_alw/core/cache/cache_helper.dart';
import 'package:alw_alw/core/services/zego_service/zego_service.dart';
import 'package:alw_alw/features/home/presentation/view/widget/body_home_view.dart';
import 'package:flutter/material.dart';

import '../../../login/presentation/login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ZegoService zegoService = ZegoService();
  CacheHelper prefs = CacheHelper();

  @override
  void initState() {
    super.initState();
    zegoService.onUserLogin(
      userID: prefs.getData(key: 'id'),
      userName: prefs.getData(key: 'userName'),
    );
  }

  void _logout(BuildContext context) {
    prefs.clearData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginView()));
    zegoService.onUserLogout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          )
        ],
      ),
      body: BodyHomeView(),
    );
  }
}
