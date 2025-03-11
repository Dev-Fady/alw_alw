import 'package:alw_alw/core/cache/cache_helper.dart';
import 'package:alw_alw/core/services/zego_service/zego_service.dart';
import 'package:alw_alw/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../login/presentation/login_view.dart';
import 'widget/body_home_view.dart';

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

    Future.microtask(() {
      context.read<HomeCubit>().getUser();
    });
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
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccess) {
            return BodyHomeView(users: state.users);
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
