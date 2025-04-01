import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend/core/themes/colours.dart';
import 'package:frontend/home/pages/home_page.dart';


void main ()
{
  runApp(const MyApp());
}


class MyApp extends StatelessWidget
{
  const MyApp ({super.key});

  @override
  Widget build (BuildContext context)
  {
    return MaterialApp(
      title: 'Perplexity Clone',
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme.copyWith(
          bodyMedium: TextStyle(
            fontSize: 15,
            color: AppColors.whiteColor,
          ),
        )),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}