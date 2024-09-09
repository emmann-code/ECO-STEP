import 'package:eco_step/Sub/Pages/Profile/changelang.dart';
import 'package:eco_step/Sub/Pages/Profile/privacypolicy.dart';
import 'package:eco_step/Sub/Pages/Profile/terms&conditions.dart';
import 'package:eco_step/Sub/Pages/Profile/updatepassword.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class SetingTile extends StatelessWidget {
  const SetingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(height: 20,),
          ListTile(tileColor: Theme.of(context).colorScheme.secondary,
            title: Text('Update Password',style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.bold,),
            ),
            onTap: () {
              // Navigate to Update password Page
              Navigator.push(context, MaterialPageRoute(builder: (context) => Updatepassword(email: String.fromEnvironment(""),)));
            },
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
          ),
          SizedBox(height: 20,),
          ListTile(
            title: Text('Change Language',style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.bold,),),
            onTap: () {
              // Navigate to change lang Page
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeLanguagePage()));
            },
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
            tileColor: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(height: 20,),
          ListTile(
            title: Text('Privacy Policy',style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.bold,),),
            onTap: () {
              // Navigate to privacy Page
              Navigator.push(context, MaterialPageRoute(builder: (context) => Privacypolicy()));
            },
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
            tileColor:Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(height: 20,),
          ListTile(
            title: Text('Terms and Condition',style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.bold,),),
            onTap: () {
              // Navigate to terms&condition Page
              Navigator.push(context, MaterialPageRoute(builder: (context) => Termsconditions()));
            },
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
            tileColor: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
