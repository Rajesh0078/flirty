import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';

class ShowToaster {
  void succeesToast(BuildContext context, String msg) {
    InteractiveToast.slide(
      context,
      title: Text(msg),
      toastStyle: const ToastStyle(titleLeadingGap: 10),
      toastSetting: const SlidingToastSetting(
        animationDuration: Duration(seconds: 1),
        displayDuration: Duration(seconds: 2),
        toastStartPosition: ToastPosition.top,
        toastAlignment: Alignment.topCenter,
      ),
    );
  }

  Text textWidget(String text) => Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      );
}
