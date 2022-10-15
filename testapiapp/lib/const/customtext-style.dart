import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle({double? fs, Color? clr, FontWeight? fw}) {
  return GoogleFonts.titilliumWeb(fontSize: fs, color: clr, fontWeight: fw);
}

final spinkit = SpinKitSpinningCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);
