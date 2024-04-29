import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/colors_consts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';

dynamic bottomNavBarItem(
    BuildContext context, String iconName, String labelName,bool selected) {
  if(Platform.isAndroid){
    return Container(
      width: getPhoneWidth(context)/5 ,
     decoration: const BoxDecoration(
       color: Colors.transparent,

     ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/$iconName",color: selected ? blueDefaultColor:Colors.black,),
          Text(
            labelName,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500,color: selected ? blueDefaultColor:Colors.black,),
          )
        ],
      ),
    );
  }
  return BottomNavigationBarItem(
      icon: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 10),
      SvgPicture.asset("assets/icons/$iconName",color: selected ? blueDefaultColor:Colors.black,),
      Text(
        labelName,
        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500,color: selected ? blueDefaultColor:Colors.black,),
      )
    ],
  ));
}
