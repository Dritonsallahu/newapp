

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/colors_consts.dart';

ThemeData lightThemeData(BuildContext context){
  return ThemeData.light().copyWith(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme,
    useMaterial3: true,
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
    iconTheme: const IconThemeData(color: Colors.blue),
    colorScheme: const ColorScheme.light(
      primary: Colors.yellow,
      secondary: Colors.green,
      error: Colors.red
    )
  );
}