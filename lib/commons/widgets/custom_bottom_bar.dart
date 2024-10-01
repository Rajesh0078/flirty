import 'package:flirty/constants/colors.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  final String currentRoute;

  const CustomBottomBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            offset: const Offset(0, -2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildbottombutton(
            "Home",
            AppRoutes.home,
            "assets/svg/logo.svg",
            24,
            currentRoute,
            context,
          ),
          buildbottombutton(
            "Matches",
            AppRoutes.matches,
            "assets/svg/matches.svg",
            22,
            currentRoute,
            context,
          ),
          buildbottombutton(
            "Chat",
            AppRoutes.chat,
            "assets/svg/chat.svg",
            24,
            currentRoute,
            context,
          ),
          buildbottombutton(
            "Profile",
            AppRoutes.profile,
            "assets/svg/person.svg",
            22,
            currentRoute,
            context,
          ),
        ],
      ),
    );
  }
}

Expanded buildbottombutton(String name, String route, String icon,
    double height, String currentRouteName, BuildContext context) {
  final textColor = route == currentRouteName
      ? CColors.primary
      : const Color.fromARGB(255, 127, 123, 123);
  return Expanded(
    child: GestureDetector(
      onTap: () {
        if (currentRouteName == route) {
          return;
        } else {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: height,
              colorFilter: ColorFilter.mode(
                textColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              name,
              style: TextStyle(
                fontSize: 12.5,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
