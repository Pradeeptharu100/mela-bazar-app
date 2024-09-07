import 'package:flutter/material.dart';

Map<int, Color> primarySwatch = {
  50: PTColor.primary.withOpacity(0.1),
  100: PTColor.primary.withOpacity(0.2),
  200: PTColor.primary.withOpacity(0.3),
  300: PTColor.primary.withOpacity(0.4),
  400: PTColor.primary.withOpacity(0.5),
  500: PTColor.primary.withOpacity(0.6),
  600: PTColor.primary.withOpacity(0.7),
  700: PTColor.primary.withOpacity(0.8),
  800: PTColor.primary.withOpacity(0.9),
  900: PTColor.primary.withOpacity(1),
};

class PTColor {
  static const Color primaryTextColor = Color(0xFF505050);
  static const Color secondary = Color(0xFFFF8800);
  static const Color white = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF1C7CBB);
  static const Color litePrimary = Color(0xFFE9F2F9);
  static const Color yellow = Color(0xFFFABF01);
  static const Color yellowLite = Color(0xFFFFAA4C);
  static const Color lightRed = Color(0xFFF56666);
  static const Color greyLite = Color(0xFFE0E0E0);
  static const Color cyanLite = Color(0xFFE0E9F0);
  static const Color blackLite = Color(0xFF4F4F4F);
  static const Color primaryDark = Color(0xFFF7FAFF);
  static const Color black12 = Color(0xFF313131);
  static const Color lightBackground = Color(0xFFDDECF5);
  static const Color textGrey = Color(0xFF7B8698);
  static const Color lowRed = Color(0xFF6394fa);
  static const Color chartBlue = Color(0xFF6394fa);
  static const Color chartGreen = Color(0xFF63daab);
  static const Color red = Color(0xFFF12525);
  static const Color greyButton = Color(0xFF3A3D5E);
  static const Color lightGreen = Color(0x264CB050);
  static const Color lightCyan = Color(0x331C7DBB);
  static const Color liteGreen = Color(0x8099D5E0);
  static const Color buttonGrey = Color(0xFF828282);
  static const Color borderLite = Color(0xFFF4F4F4);
  static const Color liteTextColor = Color(0xFF535353);
  static const Color moreDrawerDivider = Color(0xFFEFEFEF);
  static const Color lightBlue = Color(0xFFE6F4FF);
  static const Color blackDark = Color(0xFF696969);
  static const Color lightBlack = Color(0xFF495057);
  static const Color borderGrey = Color(0xFfD9D9D9);
  static const Color successColor = Color(0xff4CB050);
  static const Color booksBackground = Color(0xFFF7FAFF);
  static const Color bookTitleBlack = Color(0xff303030);
  static const Color tabIndicator = Color(0xFF3A61AB);
  static const Color dividerColor = Color(0xFFDCDCDC);
  static const Color secondaryLite = Color(0xFFF89F1C);
  static const Color orangeLite = Color(0xFFF7E8D2);
  static const Color filterIconColor = Color(0xFF1890FF);
  static const Color black = Color(0xFF000000);
  static const Color navBG = Color(0xFFF8F8F8);
  static const Color assetGrey = Color(0xFF808080);
  static const Color filterTextColor = Color(0xFF323232);
  static const Color platinum = Color(0xFFE4E4E4);
  static const Color cosmicLatte = Color(0xFFFCF5E3);
  static const Color aliceBlue = Color(0xFFE7F3FF);
  static const Color antiFlashWhite = Color(0xFFEDEDED);
  static const Color dividerGrey = Color(0xFFEBEBEB);
  static const Color whiteBG = Color(0xFFF5F5F5);
  static const Color tabIndicatorBg = Color(0x218C8C8C);
  static const Color positiveGreen = Color(0xFF0EC240);
  static const Color negativeRed = Color(0xFFFF6B6B);
  static const Color rebeccaPurple = Color(0xff5c2d91);
  static const Color kellyGreen = Color(0xff60BB46);
  static const Color academyBlue = Color(0xff0C55A8);
  static const Color tabIndicatorTextColor = Color(0xFF8C8C8C);
  static const Color nepseMainChartTabIndicatorTextColor = Color(0xFF858585);
  static const Color secondaryTextColor = Color(0xFF1685F8);
  static const Color placeholderTextColor = Color(0xFF9E9E9E);
  static const Color headerTextColor = Color(0xFF4E4E4E);
  static const Color textFieldBorderColor = Color(0xFFC4C4C4);
  static const Color textFieldHintColor = Color(0xFFA9A9A9);
  static const Color greyTextColor = Color(0xFFAFAFAF);
  static const Color darkestGreyTextColor = Color(0xFF7C7C7C);
  static const Color darkerGreyTextColor = Color(0xFF909090);
  static const Color appBg = Color(0xFFF7F8FB);
  static const Color paleAqua = Color(0xFFD7E7FF);
  static const Color violetColor = Color(0xff1b1651);
  static const Color starCommandBlue = Color(0xFF1C7DBB);
  static const Color selectedLoginOptionsColor = Color(0xFFD2E5F1);
  static const Color lightGreyColor = Color(0xffA0A0A0);
  static const Color categorySelectedColor = Color(0xFFE0E9F0);
  static const Color statusBarColor = Color(0xff016699);
  static const Color progressIndicatorGreen = Color(0xFF34C38F);
  static const Color guestLectureBGColor = Color(0xFF34A5F1);
  static const Color mcqSelectedBGColor = Color(0x191C7DBB);
  static const Color yellowLow = Color(0xffFFF4E6);
  static const Color newGreyColor = Color(0xff606060);
  static const Color transParentRed = Color(0xffF12525);

  static const Color liteRed = Color(0x26F12525);
  static var positiveGradientColors = [
    positiveGreen.withOpacity(0.3),
    positiveGreen.withOpacity(0.01)
  ];

  static var negativeGradientColors = [
    negativeRed.withOpacity(0.3),
    negativeRed.withOpacity(0.01)
  ];

  static var neutralGradientColors = [
    secondaryTextColor.withOpacity(0.3),
    secondaryTextColor.withOpacity(0.01)
  ];

  static var buttonGradientColors = [
    const Color(0xFF1685F8),
    const Color(0xFF52A7FF),
  ];
}
