import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/colors_consts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/features/data/models/user_model.dart';
import 'package:news_app/features/presentation/providers/user_provider.dart';
import 'package:news_app/features/presentation/screens/navigator_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _madeByAnimationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700), // Set the duration as needed.
    );
    _animationController.forward(); // Start the animation.

    _madeByAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Set the duration as needed.
    );
    _madeByAnimationController.forward(); // Start the animation.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      const uuid = Uuid();
      var uniqueID = Platform.isAndroid ? uuid.v4():allInfo['identifierForVendor'];
      print("sdf");
      await Future.delayed(const Duration(milliseconds: 1200));
      autoLogin(uniqueID);
    });
  }

  autoLogin(String? uniqueID) async {
    var provider = Provider.of<UserProvider>(context,listen: false);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userData = preferences.getString("user");
    var existID = preferences.getString("uniqueID");

    if(existID == null || existID.isEmpty){
      print("|sdfsd");
      print(uniqueID);
      await provider.setUniqueIDFromDB(preferences,uniqueID);
      print("Unique ID set");
    }
    else{
      print("Unique");
    }
    print(userData);
    if(userData != null){
      UserModel userModel = UserModel.fromJson(jsonDecode(userData));
      await provider.addNewUser(userModel);

    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const NavigatorPage()));
  }

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid){
      return Scaffold(
        body: Container(
          width: getPhoneWidth(context),
          height: getPhoneHeight(context),
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 20,),
                FadeTransition(
                  opacity: _animationController.drive(Tween<double>(begin: 0, end: 1)),
                  child: Image.asset(
                    "assets/images/mmc-logo.png",
                    width: getPhoneWidth(context) * 0.7,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: FadeTransition(
                    opacity: _madeByAnimationController.drive(Tween<double>(begin: 0, end: 1)),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Made by ",style: GoogleFonts.poppins(color: Colors.grey[800],fontWeight: FontWeight.w600),),
                        Text(" XYZ",style: GoogleFonts.poppins(color: Colors.grey[800],fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    }
    return Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context),
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20,),
            FadeTransition(
              opacity: _animationController.drive(Tween<double>(begin: 0, end: 1)),
              child: Image.asset(
                "assets/images/mmc-logo.png",
                width: getPhoneWidth(context) * 0.7,
              ),
            ),
            FadeTransition(
              opacity: _madeByAnimationController.drive(Tween<double>(begin: 0, end: 1)),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Made by ",style: GoogleFonts.poppins(color: Colors.grey[800],fontWeight: FontWeight.w600),),
                  Text(" XYZ",style: GoogleFonts.poppins(color: Colors.grey[800],fontWeight: FontWeight.w600),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
