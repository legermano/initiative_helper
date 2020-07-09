import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:initiative_helper/colors/custom_colors.dart';

final darkTheme = ThemeData(
  typography: customTypography,
  textTheme: darkTextTheme,
  primarySwatch: CustomColor.darkRed,
  primaryColor: CustomColor.darkRed,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: CustomColor.darkRed,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: CustomColor.darkRed,
    foregroundColor: Colors.white
  ),
  dividerColor: Colors.black12,
  cardColor: const Color(0xFF2D2D2D),
  selectedRowColor: const Color(0xFF474747),  
  appBarTheme: AppBarTheme(
    color: CustomColor.darkRed,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity
);

final lightTheme = ThemeData(
  typography: customTypography,
  textTheme: lightTextTheme,
  primarySwatch: CustomColor.red,
  primaryColor: CustomColor.red,
  selectedRowColor: Colors.amber[100],
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity
);

final customTypography = Typography.material2018(
    englishLike: Typography.englishLike2018,
    dense: Typography.dense2018,
    tall: Typography.tall2018,
);

final lightTextTheme = TextTheme(
  headline1: GoogleFonts.roboto(   
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.roboto(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5
  ),
  headline3: GoogleFonts.roboto(
    fontSize: 48,
    fontWeight: FontWeight.w400
  ),
  headline4: GoogleFonts.roboto(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25
  ),
  headline5: GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w400
  ),
  headline6: GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15
  ),
  subtitle1: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15
  ),
  subtitle2: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1
  ),
  bodyText1: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5
  ),
  bodyText2: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25
  ),
  button: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25
  ),
  caption: GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4
  ),
  overline: GoogleFonts.roboto(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5
  )
);

final darkHighEmphasisWhite = Color.fromRGBO(255, 255, 255, 87);
final darkMediumEmphasisWhite = Color.fromRGBO(255, 255, 255, 60);
final darkDisabledWhite = Color.fromRGBO(255, 255, 255, 38);

final darkTextTheme = TextTheme(
  headline1: GoogleFonts.roboto(
    fontSize: 96,
    fontWeight: FontWeight.w300,    
    letterSpacing: -1.5,
    color: darkHighEmphasisWhite
  ),
  headline2: GoogleFonts.roboto(
    fontSize: 60,
    fontWeight: FontWeight.w300,    
    letterSpacing: -0.5,
    color: darkHighEmphasisWhite
  ),
  headline3: GoogleFonts.roboto(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: darkHighEmphasisWhite
  ),
  headline4: GoogleFonts.roboto(
    fontSize: 34,
    fontWeight: FontWeight.w400,    
    letterSpacing: 0.25,
    color: darkHighEmphasisWhite
  ),
  headline5: GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: darkHighEmphasisWhite
  ),
  headline6: GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: darkHighEmphasisWhite
  ),
  subtitle1: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,  
    letterSpacing: 0.15,
    color: darkMediumEmphasisWhite
  ),
  subtitle2: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,  
    letterSpacing: 0.1,
    color: darkMediumEmphasisWhite
  ),
  bodyText1: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: darkMediumEmphasisWhite
  ),
  bodyText2: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,  
    letterSpacing: 0.25,
    color: darkMediumEmphasisWhite
  ),
  button: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: darkMediumEmphasisWhite
  ),
  caption: GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: darkMediumEmphasisWhite
  ),
  overline: GoogleFonts.roboto(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    color: darkMediumEmphasisWhite
  )
);
