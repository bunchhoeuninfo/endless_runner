import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class EndlessRunnerTheme {
  static EndlessRunnerTheme of(BuildContext context) {
    return EndlessRunnerTheme();
  }

  Color get primaryBackground => const Color(0xFFFFFFFF);
  Color get secondaryBackground => const Color(0xFFEEEEEE);
  Color get appBarBackground => const Color.fromARGB(255, 3, 49, 255);
  Color get appBarTextColor => const Color(0xFFEEEEEE);
  Color get primaryColor => const Color(0xFF6200EA);
  Color get secondaryColor => const Color(0xFF03DAC6);

  TextStyle get displaySmall => TextStyle(
    fontFamily: 'Roboto',
    color: primaryColor,
    fontSize: 32,
    //fontWeight: FontWeight.bold,
  );

  TextStyle get normalText => const TextStyle(
    fontFamily: 'KhmerOS-Reg', // Apply custom font to unselected label
    fontSize: 14, // Adjust the font size if needed
    fontWeight: FontWeight.normal,
  );

  TextStyle get bottomNavUnselectedTextStyle => const TextStyle(
    fontFamily: 'OpenSans-Regular', // Apply custom font to unselected label
    fontSize: 14, // Adjust the font size if needed
    fontWeight: FontWeight.normal,
  );

  TextStyle get bottomNavUnselectedKHTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  TextStyle get playerNormalText => const TextStyle(
   //fontFamily: GoogleFonts.battambang,
   fontSize: 14,
  );

  TextStyle get battambangTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  TextStyle get normalKhTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  TextStyle get catTextKhTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  TextStyle get catTextKhRltText {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  TextStyle get titleH3KhTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get titleH4KhTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get titleH4KhRltText {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get titleH4KhWhite {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get titleH5KhTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  

  TextStyle get titleH3TextStyle => const TextStyle(
    fontFamily: 'OpenSans-Regular', // Apply custom font to unselected label
    fontSize: 18, // Adjust the font size if needed
    //fontWeight: FontWeight.bold,
  ); 

  TextStyle get audioTitleH4TextStyle => const TextStyle(
    fontFamily: 'OpenSans-Regular', // Apply custom font to unselected label
    fontSize: 16, // Adjust the font size if needed
    //fontWeight: FontWeight.bold,
  );


  TextStyle get audioSubTitleTextStyle => const TextStyle(
    fontFamily: 'OpenSans-Regular', // Apply custom font to unselected label
    fontSize: 14, // Adjust the font size if needed
    fontWeight: FontWeight.normal,
  );

  TextStyle get audioLengthTextStyle => const TextStyle(
    fontFamily: 'OpenSans-Regular', // Apply custom font to unselected label
    fontSize: 12, // Adjust the font size if needed
    fontWeight: FontWeight.normal,
  );

  TextStyle get audioDateTimeTextStyle => const TextStyle(
    fontFamily: 'OpenSans-Regular', // Apply custom font to unselected label
    fontSize: 14, // Adjust the font size if needed
    fontWeight: FontWeight.bold,
  );

  TextStyle get dateTimeKhNormalTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  TextStyle get titleH2TextStyle => const TextStyle(
    fontFamily: 'OpenSans-Regular', // Apply custom font to unselected label
    fontSize: 24, // Adjust the font size if needed
    //fontWeight: FontWeight.bold,
  );

  TextStyle get titleH2KhTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get subTitleKhTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 11,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  

  ButtonStyle get elevatBtnStyle {
    return ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    textStyle: GoogleFonts.battambang(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    );
  }

  ButtonStyle get articleBtnPlayStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      textStyle: GoogleFonts.battambang(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),  // Set the corner radius
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,  
    );
  }

  ButtonStyle get elevatBtnPlayLastStyle {
    return ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: GoogleFonts.battambang(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                padding: const EdgeInsets.symmetric(horizontal: 82.0, vertical: 16.0),
              );
  }

  ButtonStyle get btnCloseKhStyle {
    return ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: GoogleFonts.battambang(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                
              );
  }

  ButtonStyle get elevatBtnPlayAudioKhStyle {
    return ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: GoogleFonts.battambang(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                padding: const EdgeInsets.symmetric(horizontal: 82.0, vertical: 16.0),
              );
  }

  TextStyle get audiTitleSmallTextStyle => const TextStyle(
    fontFamily: 'OpenSans-Regular', // Apply custom font to unselected label
    fontSize: 11, // Adjust the font size if needed
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  TextStyle get audiTitleSmallKhTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(        
        fontSize: 11, // Adjust the font size if needed
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  TextStyle get audiTitleMeduimKhTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(        
        fontSize: 12, // Adjust the font size if needed
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

   TextStyle get titleH2RedKhTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 24,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get titleH2RedTextStyle => const TextStyle(
    fontFamily: 'OpenSans-Regular', // Apply custom font to unselected label
    fontSize: 24, // Adjust the font size if needed
    color: Colors.red,
    //fontWeight: FontWeight.bold,
  );

  TextStyle get bottomNavSelectedTextStyle => const TextStyle(
    fontFamily: 'OpenSans-Regular', // Apply custom font to unselected label
    fontSize: 14, // Adjust the font size if needed
    //fontWeight: FontWeight.bold,
    color: Colors.red,
  );

  TextStyle get bottomNavSelectedKHTextStyle {
    return GoogleFonts.battambang(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );
  }

  ThemeData get globalTheme => ThemeData(
    fontFamily: 'OpenSans-Regular',
  );

String formatAudioDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
}

}