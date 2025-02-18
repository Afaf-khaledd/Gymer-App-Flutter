import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoldTextWidget extends StatelessWidget {
  final String text;

  const BoldTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: _parseTextWithBold(text),
      ),
    );
  }

  List<TextSpan> _parseTextWithBold(String text) {
    List<TextSpan> spans = [];
    RegExp regExp = RegExp(r'(\*\*.*?\*\*)');

    int lastIndex = 0;

    for (var match in regExp.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,color:Colors.black,fontSize: 16),
        ));
      }
      spans.add(TextSpan(
        text: text.substring(match.start + 2, match.end - 2),
        style: GoogleFonts.dmSans(fontWeight: FontWeight.w900,color:Colors.black, fontSize: 17),
      ));
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,color:Colors.black, fontSize: 16),

      ));
    }

    return spans;
  }
}