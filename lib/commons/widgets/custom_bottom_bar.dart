import 'package:flirty/constants/colors.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  final String currentRoute; // To identify the current route

  const CustomBottomBar({Key? key, required this.currentRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BottomAppBar(
    //   height: 64,
    //   child: Row(
    //     mainAxisAlignment:
    //         MainAxisAlignment.spaceAround, // Space evenly between items
    //     children: [
    //       _buildNavItem(
    //         context,
    //         AppRoutes.home,
    //         "assets/svg/logo.svg",
    //         height: 24,
    //       ),
    //       _buildNavItem(
    //         context,
    //         AppRoutes.matches,
    //         "assets/svg/matches.svg",
    //         height: 20,
    //       ),
    //       _buildNavItem(
    //         context,
    //         AppRoutes.chat,
    //         "assets/svg/chat.svg",
    //         height: 20,
    //       ),
    //       _buildNavItem(
    //         context,
    //         AppRoutes.profile,
    //         "assets/svg/person.svg",
    //         height: 25,
    //       ),
    //     ],
    //   ),
    // );
    return Container(
      width: double.infinity,
      height: 64,
      color: const Color(0xFFF3F3F3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildbottombutton(
            AppRoutes.home,
            "assets/svg/logo.svg",
            currentRoute,
            context,
          ),
          buildbottombutton(
            AppRoutes.matches,
            "assets/svg/matches.svg",
            currentRoute,
            context,
          ),
          buildbottombutton(
            AppRoutes.chat,
            "assets/svg/chat.svg",
            currentRoute,
            context,
          ),
          buildbottombutton(
            AppRoutes.profile,
            "assets/svg/person.svg",
            currentRoute,
            context,
          ),
        ],
      ),
    );
  }
}

Expanded buildbottombutton(
    String route, String icon, String currentRouteName, BuildContext context) {
  final textColor =
      route == currentRouteName ? CColors.primary : CColors.textColor;
  final Color borderColor =
      currentRouteName == route ? CColors.primary : const Color(0xFFE8E6EA);
  return Expanded(
    child: GestureDetector(
      onTap: () {
        if (currentRouteName == route) {
          return;
        } else {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: borderColor,
              width: 1.5,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 30,
              colorFilter: ColorFilter.mode(
                textColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
