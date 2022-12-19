import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slacks_test/log_in/login.dart';
import 'package:slacks_test/screens/new_bar.dart';
import '../log_in/signin.dart';
import 'package:google_fonts/google_fonts.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String dummy= "xxxxxxx";
   SharedPreferences? logindata;
   String? usernumber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      usernumber = logindata?.getString('usernumber');
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: ListView(
        children: [Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(30)),
        //   if(LOG() )
            (imageUrl==null)?
            CircleAvatar(backgroundColor: Colors.black,radius: 60):
            CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl!,
              ),
              radius: 60,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 40),
          //   Text("Number :",style: GoogleFonts.poppins( fontSize: 15,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black54)
          // ),
            Text(
              'NAME',
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
        (name==null)?
            Text("$dummy"):
        Text(
          name!,
          style: (GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold)
          ),),
            SizedBox(height: 20),
            Text(
              'EMAIL',
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            (email==null)?Text("$dummy"):
            Text(
              email!,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Phone number',
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            (usernumber==null)?
            Text("$dummy"):
            Text(
             "$usernumber",
              style: (GoogleFonts.poppins(
                  color: Colors.black,

                  fontSize: 25,
                  fontWeight: FontWeight.bold)
              ),),
            // SizedBox(height: 40),
            // ElevatedButton(
            //   onPressed: () {
            //     signOutGoogle();
            //     Navigator.of(context).pushAndRemoveUntil(
            //         MaterialPageRoute(builder: (context) {
            //           return Barnew();
            //         }), ModalRoute.withName('/'));
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(
            //       'Back',
            //       style: TextStyle(fontSize: 25, color: Colors.white),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
       ] ),

      ),
    );
  }
}



