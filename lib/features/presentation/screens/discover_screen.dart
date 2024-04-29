import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/colors_consts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/core/consts/widgets.dart';
import 'package:news_app/core/strings/news_categories_strings.dart';
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/screens/continents/asia_news.dart';
import 'package:news_app/features/presentation/screens/continents/europe_news.dart';
import 'package:news_app/features/presentation/screens/continents/latest_news.dart';
import 'package:news_app/features/presentation/screens/continents/middle_east_news.dart';
import 'package:news_app/features/presentation/screens/continents/usa_news.dart';
import 'package:news_app/features/presentation/screens/continents/world_news.dart';
import 'package:news_app/features/presentation/screens/single_news_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context) - 150,
      child: DefaultTabController(
        length: 6, // This is the number of tabs.
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,bottom: false,left: false,right: false,minimum: const EdgeInsets.all(0),
                  sliver: SliverAppBar(
                    backgroundColor: Colors.white,elevation: 0,

                    floating: true,
                    pinned: true,
                    snap: false,
                    primary: true,expandedHeight: 0,
                    forceElevated: innerBoxIsScrolled,

                    bottom: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.blue,
                      // These are the widgets to put in each tab in the tab bar.
                      tabs: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Latest",
                              style: GoogleFonts.nunito(
                                  color: const Color(0xff939393),fontSize: 18),
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "World",
                              style: GoogleFonts.nunito(
                                  color: const Color(0xff939393),fontSize: 18),
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "USA",
                              style: GoogleFonts.nunito(
                                  color: const Color(0xff939393),fontSize: 18),
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Europe",
                              style: GoogleFonts.nunito(
                                  color: const Color(0xff939393),fontSize: 18),
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Middle East",
                              style: GoogleFonts.nunito(
                                  color: const Color(0xff939393),fontSize: 18),
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Asia",
                              style: GoogleFonts.nunito(
                                  color: const Color(0xff939393),fontSize: 18),
                            )),
                      ],
                    ),
                  ),
                ),
              ),


            ];
          },
          body: const TabBarView(physics: NeverScrollableScrollPhysics(),
            // These are the contents of the tab views, below the tabs.
            children: [
              LatestNews(),
              WorldNews(),
              UsaNews(),
              EuropeNews(), 
              MiddleEastNews(),
              AsiaNews(),

            ],
          ),
        ),
      ),
    );
  }
}
