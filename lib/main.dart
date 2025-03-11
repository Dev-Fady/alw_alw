import 'package:alw_alw/core/cache/cache_helper.dart';
import 'package:alw_alw/core/services/firebase/firestore_service.dart';
import 'package:alw_alw/features/add_pepole/data/repo/add_pepole_repo_impl.dart';
import 'package:alw_alw/features/add_pepole/presentation/manger/cubit/add_pepole_cubit.dart';
import 'package:alw_alw/features/home/data/repo/home_repo_impl.dart';
import 'package:alw_alw/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:alw_alw/features/login/presentation/login_view.dart';
import 'package:alw_alw/features/main/presentation/view/main_view.dart';
import 'package:alw_alw/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final sharedPrefs = CacheHelper();
  await sharedPrefs.init();

  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  // call the useSystemCallingUI
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedPrefs = CacheHelper();
    final isLoggedIn = sharedPrefs.getData(key: 'isLoggedIn') ?? false;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddPepoleCubit(
              AddPepoleRepoImpl(firestoreService: FirestoreService())),
        ),
        BlocProvider(
          create: (context) =>
              HomeCubit(HomeRepoImpl(firestoreService: FirestoreService()))..getUser(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isLoggedIn ? MainView() : LoginView(),
      ),
    );
  }
}
