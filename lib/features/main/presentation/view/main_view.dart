import 'package:alw_alw/features/add_pepole/presentation/view/add_pepole_view.dart';
import 'package:alw_alw/features/main/presentation/view/widget/main_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  // قائمة الصفحات
  static final List<Widget> _widgetOptions = <Widget>[
    const AddPepoleView(),
    
  ];

  // تغيير الصفحة عند الضغط
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: MainBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
      ),
    );
  }
}