// import 'package:e_commerce/core/constants/images.dart';
// import 'package:e_commerce/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTabChange;

  const MainBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: const Color(0xff1B5E37),
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[200]!,
            color: Colors.black,
            tabs: [
              _buildGButton(
                'Call Pepole',
                Icons.wifi_calling_3_outlined,
              ),
              _buildGButton(
                'Add Pepole',
                Icons.add_ic_call_outlined,
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }

  GButton _buildGButton(String text, IconData icon) {
    return GButton(
      icon: icon,
      text: text,
    );
  }
}
