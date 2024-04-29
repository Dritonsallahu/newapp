import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/colors_consts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/features/presentation/screens/navigator_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: getPhoneWidth(context),
          height: getPhoneHeight(context),
          child: Image.asset(
            "assets/images/city1.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          child: Container(
            width: getPhoneWidth(context),
            height: getPhoneHeight(context),
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        Positioned(
            width: getPhoneWidth(context),
            height: getPhoneHeight(context),
            bottom: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Stay Informed\n from Day One",
                  style: GoogleFonts.inter(
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Discover the Latest News with our Seamless Onboarding Experience",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => NavigatorPage()));
                  },
                  child: Container(
                    width: getPhoneWidth(context) - 40,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: blueDefaultColor),
                    child: Center(
                      child: Text(
                        "Getting Started",
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
