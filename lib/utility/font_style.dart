import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/utility/colors.dart';

class FontStyle {
  static TextStyle titleStyle = GoogleFonts.poppins(
    color: PColors.mainColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle subtitleStyle = GoogleFonts.poppins(
    color: PColors.mainColor,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  static TextStyle subtitleStyle2 = GoogleFonts.poppins(
    color: PColors.titleGrey,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}
