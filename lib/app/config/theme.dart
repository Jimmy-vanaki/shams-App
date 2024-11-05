import 'package:flutter/material.dart';

class MyThemes {
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'dijlah',
    useMaterial3: true,
    dividerTheme:
        const DividerThemeData(color: Color.fromARGB(50, 210, 210, 210)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 55, 55, 55),
        backgroundColor: const Color.fromARGB(255, 194, 194, 194),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 194, 194, 194),
      onPrimary: Color.fromARGB(255, 55, 55, 55),
      surface: Color.fromARGB(255, 55, 55, 55),
      onSurface: Color.fromARGB(255, 194, 194, 194),
      
      secondary: Color.fromARGB(255, 81, 0, 244),
      onSecondary: Color.fromARGB(255, 63, 34, 34),
      error: Color.fromARGB(255, 249, 52, 62),
      onError: Color(0xffffb4ab),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'dijlah',
    useMaterial3: true,
    dividerTheme:
        const DividerThemeData(color: Color.fromARGB(20, 150, 120, 50)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 150, 120, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 150, 120, 50),
      onPrimary: Color.fromARGB(255, 255, 250, 240),
      surface: Color.fromARGB(255, 255, 250, 240),
      onSurface: Color.fromARGB(255, 150, 120, 50),

      secondary: Color.fromARGB(255, 240, 205, 140),
      onSecondary: Color(0xff22323f),

      error: Color.fromARGB(255, 249, 52, 62),
      onError: Color(0xffffb4ab),
    ),
  );
}
