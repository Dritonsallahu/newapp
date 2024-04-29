import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/features/presentation/screens/notifications_screen.dart';
import 'package:news_app/features/presentation/screens/search_news_screen.dart';
import 'package:news_app/features/presentation/widgets/error_widgets.dart';

leadingIcon(context, {bool isNewPage = false}) {
  return GestureDetector(
    onTap: () {
      if (isNewPage) {
        Navigator.pop(context);
      } else {

      }
    },
    child: Container(
      width: Platform.isAndroid ? 30:45,
      height: Platform.isAndroid ? 30:45,
      decoration: BoxDecoration(
        color: !isNewPage ? Colors.transparent:const Color(0xffe3e3e5).withOpacity(0.6),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: Platform.isAndroid ? null:const EdgeInsets.only(left: 2,top: 2,bottom: 2,right: 2),
      margin: EdgeInsets.all(Platform.isAndroid ? 6:0),
      child: !isNewPage ?  Padding(
        padding:   EdgeInsets.all(Platform.isAndroid ? 4:0),
        child: Image.asset("assets/images/mmc-logo.png",fit: BoxFit.cover,),
      ):
      Container(
        width: Platform.isAndroid ? 30:45,
        height:  Platform.isAndroid ? 30:45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 6.0, right: isNewPage ? 8 : 6.0, top: 6.0, bottom: 6.0),
          child: Platform.isAndroid ? Icon(Icons.arrow_back_outlined):SvgPicture.asset(  "assets/icons/back-icon.svg"
               ,
            color: const Color(0xff323232),
          ),
        ),
      ),
    ),
  );
}

trailingIcons(isSearchCliced, isStreched, context) {

  return   Stack(
    children: [
      GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchNewsScreen()));
        },
        child: Container(
          width:  Platform.isAndroid ? 34:40,
          height: Platform.isAndroid ? 37:45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:   EdgeInsets.only(right: Platform.isAndroid ?  7:10),
                child: SvgPicture.asset(
                  "assets/icons/search.svg",
                  color: const Color(0xff323232),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

notifications(context) => GestureDetector(
  onTap: (){
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => NotificationsScreen()));
  },
  child:   Container(
    width:  Platform.isAndroid ? 34:40,
    height: Platform.isAndroid ? 37:45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SvgPicture.asset(
          "assets/icons/bell.svg",
          color: const Color(0xff323232),
        ),
      ),
    ),
);



infoModal(String title,BuildContext context){
  if(Platform.isAndroid){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 22, right: 25, bottom: 25),
            child: Container(
              width: getPhoneWidth(context),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: getPhoneWidth(context) - 120,
                      child: Text(
                        title,textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey[100],
                      ),
                      child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    100.0), // Adjust the radius as needed
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child:   Text("Leave",style: GoogleFonts.poppins(color: Colors.blue,fontWeight: FontWeight.w500),)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  else{
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 25, right: 25, bottom: 25),
            child: Container(
              width: getPhoneWidth(context),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: getPhoneWidth(context) - 150,
                      child: Text(
                        title,textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey[100],
                      ),
                      child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    100.0), // Adjust the radius as needed
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Leave")),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}