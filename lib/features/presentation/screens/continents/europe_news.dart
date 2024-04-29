import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/colors_consts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/core/consts/widgets.dart';
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/screens/single_news_screen.dart';
import 'package:news_app/features/presentation/widgets/custom_animated_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EuropeNews extends StatefulWidget {
  const EuropeNews({Key? key}) : super(key: key);

  @override
  State<EuropeNews> createState() => _EuropeNewsState();
}

class _EuropeNewsState extends State<EuropeNews> {

  getEuropeNews(bool firstTime, String category) {
    var provider = Provider.of<PostProvider>(context, listen: false);
    if (!provider.getEuropeNewsFechingStatus() && firstTime == true) {
      provider.getNewByContinentFromDB(context, "Europe",category);
      provider.setEuropeNewsFechingStatus(true);
    }
    else if (provider.getEuropeNewsFechingStatus() && firstTime == false) {
      provider.getNewByContinentFromDB(context, "Europe", category);
    }
  }



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getEuropeNews(true,"");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<PostProvider>(context);
    return Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context),
      padding: const EdgeInsets.only(top: 7),
      child: RefreshIndicator(
        onRefresh: () async {
          getEuropeNews(false,"");
        },
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [

            Hero(
              tag: "toppart",
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 7),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Europe News",
                            style: GoogleFonts.inter(
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            "News From All Over Europe Countries",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                color: const Color(0xff939393),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                width: getPhoneWidth(context),
                height: 40,
                child: SizedBox(
                  height: 40,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: postProvider.getNewsCategories("All").length,
                      itemBuilder: (context, index) {
                        var category = postProvider.getNewsCategories("All")[index];
                        return CustomAnimatedList(
                          index: index,

                          child: Row(
                            children: [
                              index != 0? const SizedBox():Padding(
                                padding: const EdgeInsets.only(right: 10,),
                                child: GestureDetector(
                                  onTap: () {
                                    chooseCategory(postProvider.getNewsCategories("All"), "");
                                    getEuropeNews(false,"");
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: !noCategoryChoosed(postProvider.getNewsCategories("All"))
                                              ? blueDefaultColor
                                              : const Color(0xfff6f6f7)),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 5,),
                                          Text(
                                            "All ",
                                            style: GoogleFonts.inter(fontSize: 17,
                                                color: !noCategoryChoosed(postProvider.getNewsCategories("All"))
                                                    ? Colors.white
                                                    : const Color(0xff808080)),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10,),
                                child: GestureDetector(
                                  onTap: () {
                                    chooseCategory(postProvider.getNewsCategories("All"), postProvider.getNewsCategories("All")[index].id);
                                    getEuropeNews(false, category.categoryName!);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 12),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: isChoosedCategory(postProvider.getNewsCategories("All"),category.id)
                                              ? blueDefaultColor
                                              : const Color(0xfff6f6f7)),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${category.categoryName!} ",
                                            style: GoogleFonts.inter(fontSize: 17,
                                                color: isChoosedCategory(postProvider.getNewsCategories("All"),category.id)

                                                    ? Colors.white
                                                    : const Color(0xff808080)),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )),
            const SizedBox(
              height: 15,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: postProvider.getNewsByContinent("Europe")!.length,
                itemBuilder: (context, index) {
                  var post = postProvider.getNewsByContinent("Europe")![index];
                  return CustomAnimatedList(
                    index: index,
                    duration: Duration(milliseconds: 200 + (index * 100)),
                    begin: 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6.5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SingleNewsScreen(
                                postModel: post,
                              )));
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                        NetworkImage(post.image!))),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/mmc-logo.png"))),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        SizedBox(
                                          width:
                                          getPhoneWidth(context) -
                                              180,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "${post.author['username']} • ${post.category!.categoryName}",
                                                style:
                                                GoogleFonts.inter(
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                getTimeFormat(
                                                    post.createdAt!),
                                                style:
                                                GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: Colors
                                                        .grey[600]),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    SizedBox(
                                      width:
                                      getPhoneWidth(context) - 150,
                                      child: Text(
                                        post.title!,
                                        style: GoogleFonts.inter(
                                            fontSize: 17,
                                            fontWeight:
                                            FontWeight.w600),
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                      width:
                                      getPhoneWidth(context) - 150,
                                      child: Text(
                                        post.subtitle!,
                                        style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: Colors.grey[700]),
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                      width:
                                      getPhoneWidth(context) - 150,
                                      child: Text(
                                        getDateFormat(post.createdAt!),
                                        style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: Colors.grey[800],
                                            fontWeight:
                                            FontWeight.w600),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
  chooseCategory(newsCategories,categoryId) {

    for (int i = 0; i < newsCategories.length; i++) {
      if (newsCategories[i].id == categoryId) {
        newsCategories[i].choosed = true;
      } else {
        newsCategories[i].choosed = false;
      }
    }
  }
  bool isChoosedCategory(newsCategories, categoryId) {
    for (int i = 0; i < newsCategories.length; i++) {
      if (newsCategories[i].id == categoryId && newsCategories[i].choosed) {
        return true;
      }
    }
    return false;
  }
  noCategoryChoosed(newsCategories) {
    for (int i = 0; i < newsCategories.length; i++) {
      if (newsCategories[i].choosed) {
        return true;
      }
    }
    return false;
  }
}
