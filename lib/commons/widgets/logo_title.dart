// logo_widget.dart

import 'package:flirty/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/svg/logo.svg",
          height: 27,
          colorFilter: const ColorFilter.mode(
            CColors.primary,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 7),
        const Text(
          "roaster",
          style: TextStyle(
            color: CColors.primary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
