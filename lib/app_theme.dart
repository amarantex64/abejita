import 'package:abejita/services/local_storage.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData currentTheme = LocalStorage.isObscure ? dark : light;
  static TextDirection textDirection = TextDirection.ltr;

  static const Color primaryColor = Colors.amber;
  static const Color secondaryColor = Color(0xff006a64);

  /// -------------------------- Light Theme  -------------------------------------------- ///

  static final ThemeData light = ThemeData(
    /// Brightness
    brightness: Brightness.light,
    useMaterial3: true,

    /// Primary Color
    primaryColor: AppTheme.primaryColor,

    /// Scaffold and Background color
    scaffoldBackgroundColor: Color(0xffF5F5F5),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xffF5F5F5),
      iconTheme: IconThemeData(color: Color(0xff495057)),
      actionsIconTheme: IconThemeData(color: Color(0xff495057)),
    ),

    /// Card Theme
    cardTheme: CardThemeData(color: Color(0xffffffff)),
    cardColor: Color(0xffffffff),

    /// Colorscheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xff006a64),
      // seedColor: Color(0xe364523c),
      brightness: Brightness.light,
    ),

    snackBarTheme: SnackBarThemeData(actionTextColor: Colors.white),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppTheme.primaryColor,
      splashColor: Color(0xffeeeeee).withAlpha(100),
      highlightElevation: 8,
      elevation: 4,
      focusColor: AppTheme.primaryColor,
      hoverColor: AppTheme.primaryColor,
      foregroundColor: Color(0xffeeeeee),
    ),

    /// Divider Theme
    dividerTheme: DividerThemeData(color: Color(0xffdddddd), thickness: 1),
    dividerColor: Color(0xffdddddd),

    /// Bottom AppBar Theme
    bottomAppBarTheme: BottomAppBarThemeData(color: Color(0xffeeeeee), elevation: 2),

    /// Tab bar Theme
    tabBarTheme: TabBarThemeData(
      unselectedLabelColor: Color(0xff495057),
      labelColor: AppTheme.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppTheme.primaryColor, width: 2.0)),
    ),

    inputDecorationTheme: InputDecorationTheme(),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: AppTheme.primaryColor,
      inactiveTrackColor: AppTheme.primaryColor.withAlpha(140),
      trackShape: RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: AppTheme.primaryColor,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: TextStyle(color: Color(0xffeeeeee)),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      checkColor: WidgetStateProperty.all(Color(0xffffffff)),
      fillColor: WidgetStateProperty.all(AppTheme.primaryColor),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected) ? AppTheme.primaryColor : Colors.white,
      ),
    ),

    /// Other Colors
    splashColor: Colors.white.withAlpha(100),
    highlightColor: Color(0xffeeeeee),
  );

  /// -------------------------- Dark Theme  -------------------------------------------- ///
  static final ThemeData dark = ThemeData.dark(useMaterial3: true).copyWith(
    /// Brightness

    /// Scaffold and Background color
    scaffoldBackgroundColor: Color(0xff262729),
    canvasColor: Colors.transparent,

    primaryColor: AppTheme.primaryColor,
    // primaryColor: Color(0xff6c563a),

    /// AppBar Theme
    appBarTheme: AppBarTheme(backgroundColor: Color(0xff262729)),

    /// Card Theme
    cardTheme: CardThemeData(color: Color(0xff1b1b1c)),
    cardColor: Color(0xff1b1b1c),

    /// Colorscheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xff006a64),
      // seedColor: Color(0xe364523c),
      surface: Color(0xff262729),
      onSurface: Color(0xFFD7D7D7),
      brightness: Brightness.dark,
    ),

    /// Input (Text-Field) Theme
    inputDecorationTheme: InputDecorationTheme(),

    /// Divider Color
    dividerTheme: DividerThemeData(color: Color(0xff393A41), thickness: 1),
    dividerColor: Color(0xff393A41),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppTheme.primaryColor,
      splashColor: Colors.white.withAlpha(100),
      highlightElevation: 8,
      elevation: 4,
      focusColor: AppTheme.primaryColor,
      hoverColor: AppTheme.primaryColor,
      foregroundColor: Colors.white,
    ),

    /// Bottom AppBar Theme
    bottomAppBarTheme: BottomAppBarThemeData(color: Color(0xff464c52), elevation: 2),

    /// Tab bar Theme
    tabBarTheme: TabBarThemeData(
      unselectedLabelColor: Color(0xff495057),
      labelColor: AppTheme.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppTheme.primaryColor, width: 2.0)),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: AppTheme.primaryColor,
      inactiveTrackColor: AppTheme.primaryColor.withAlpha(100),
      trackShape: RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: AppTheme.primaryColor,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: TextStyle(color: Colors.white),
    ),
    disabledColor: Color(0xffa3a3a3),
    highlightColor: Color(0xff47484b),
    splashColor: Colors.white.withAlpha(100),
  );

  static ThemeData createTheme(ThemeMode themeType, Color seedColor) {
    if (themeType == ThemeMode.light) {
      return light.copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.light),
      );
    }
    return dark.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
        onSurface: Color(0xFFDAD9CA),
      ),
    );
  }
}
