import 'package:flutter/material.dart';

class ScreenSizeUtils {
  screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  screenHeight(context) {
    return MediaQuery.of(context).size.height;
  }
}

final screenSizeUtils = ScreenSizeUtils();
