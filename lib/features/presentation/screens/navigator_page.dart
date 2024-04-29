import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/core/strings/bottom_nav_strings.dart';
import 'package:news_app/core/themes/light_mode_theme.dart';
import 'package:news_app/features/presentation/screens/discover_screen.dart';
import 'package:news_app/features/presentation/screens/news_page.dart';
import 'package:news_app/features/presentation/screens/profile_screen.dart';
import 'package:news_app/features/presentation/screens/saved_screen.dart';
import 'package:news_app/features/presentation/widgets/bottom_nav_widget.dart';
import 'package:news_app/features/presentation/widgets/general_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _selectedIndex = 0;
  final _pages = [
    const NewsPage(),
    const DiscoverScreen(),
    const SavedScreen(),
    const ProfileScreen(),
  ];

  bool isSearching = false;
  bool isStreched = false;
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 65,
          leading: Padding(
            padding: EdgeInsets.only(left: Platform.isAndroid ? 8:0 ),
            child: leadingIcon(context),
          ),
          centerTitle: true,
          title: Text("News",style: GoogleFonts.nunito(color: Colors.black),),
          actions: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              width:   82,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xffe3e3e5).withOpacity(0.6),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                    if (isSearching) {
                      Future.delayed(const Duration(milliseconds: 300))
                          .then((value) {
                        setState(() {
                          isStreched = true;
                        });
                      });
                    } else {
                      setState(() {
                        isStreched = false;
                      });
                    }
                  },
                  child: trailingIcons(isSearching, isStreched, context),
                ),
                const SizedBox(
                  width: 5,
                ),
                notifications(context)
              ]),
            ),
            SizedBox(width: Platform.isAndroid ? 10:0,)
          ],
        ),
        body: ListView(
          children: [
            _pages[_selectedIndex],
          ],
        ),
        bottomNavigationBar: SizedBox(
          width: getPhoneWidth(context),
          height: 60,
          child: Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[100]!))
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(navStrings(context).length, (index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: bottomNavBarItem(
                      context, navIconsNames[index], navStrings(context)[index], _selectedIndex == index),
                );
              }),
            ),
          ),
        ),
      );
    } else if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: lightThemeData(context).scaffoldBackgroundColor,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: lightThemeData(context).scaffoldBackgroundColor,
          leading: leadingIcon(context),
          trailing: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [

                Container(
                  width: isSearching ? getPhoneWidth(context) * 0.74 + 15 : 94,
                  decoration: BoxDecoration(
                    color: const Color(0xffe3e3e5).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(children: [
                    trailingIcons(isSearching, isStreched, context),
                    const SizedBox(
                      width: 5,
                    ),
                    notifications(context)
                  ]),
                ),
              ],
            ),
          ),
          automaticallyImplyMiddle: true,
          automaticallyImplyLeading: true,
          middle: isSearching
              ? const SizedBox()
              : isStreched
                  ? const SizedBox()
                  : Text(
                      AppLocalizations.of(context)!.news,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w500),
                    ),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Center(
            child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            height: 55,
            backgroundColor: lightThemeData(context).scaffoldBackgroundColor,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: List.generate(navStrings(context).length, (index) {
              return bottomNavBarItem(
                  context, navIconsNames[index], navStrings(context)[index],_selectedIndex == index);
            }),
          ),
          tabBuilder: (BuildContext context, int index) {
            return _pages[_selectedIndex];
          },
        )),
      );
    } else {
      return const Text("No page found!");
    }
  }
}
