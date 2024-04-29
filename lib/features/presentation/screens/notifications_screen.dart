import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text("Notifications"),
        ),
        body: body(context),
      );
    } else {
      return CupertinoPageScaffold(
        navigationBar:   CupertinoNavigationBar(
          border: const Border(),
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
                Navigator.pop(context);
            },
            child: Container(
              width: 45,
              decoration: BoxDecoration(
                color: const Color(0xffe3e3e5).withOpacity(0.6),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.all(4),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 6.0, right:  6.0, top: 6.0, bottom: 6.0),
                  child: SvgPicture.asset(
                   "assets/icons/back-icon.svg",
                    color: const Color(0xff323232),
                  ),
                ),
              ),
            ),
          ),
          middle: const Text("Notifications"),
        ),
        child: body(context),
      );
    }
  }

  body(context) {
    return Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child:1 ==1 ? Center(child: Text("You don't have any notification yet!",style: GoogleFonts.poppins(color: Colors.grey),)): ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index){

          return  Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/news1.jpg",)
                      ),
                      color: Colors.grey[200]),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: getPhoneWidth(context) - 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Admin"),
                          Text("11:24 PM",style: GoogleFonts.inter(fontSize: 12,color: Colors.grey[700]),),
                        ],
                      ),
                      Text(
                        "This is just a test message from server as information related"
                            "with your account and about exploring in the mobile",
                        style: GoogleFonts.inter(fontSize: 14,color: Colors.grey[700]),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      const Divider(color: Colors.grey,)
                    ],
                  ),
                )
              ],
            ),
          );
        },
        padding: const EdgeInsets.only(top: 15),

      ),
    );
  }
}
