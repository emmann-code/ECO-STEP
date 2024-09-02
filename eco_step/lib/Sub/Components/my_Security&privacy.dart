import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class editdescriptiontextOption extends StatelessWidget {
  final String title;
  final String text;


  editdescriptiontextOption({required this.title,  required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,style: GoogleFonts.roboto(
      fontSize: 17,
        fontWeight: FontWeight.w400,),),
      subtitle: Text(text,style: GoogleFonts.roboto(
      fontSize: 14,
        fontWeight: FontWeight.w400,),),
    );
  }
}