import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news_app/core/consts/colors_consts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/core/consts/widgets.dart';
import 'package:news_app/core/strings/news_categories_strings.dart';
import 'package:news_app/features/presentation/ads/ad_helper.dart';
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/screens/more_news_one_screen.dart';
import 'package:news_app/features/presentation/screens/single_news_screen.dart';
import 'package:news_app/features/presentation/widgets/breaking_news_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/features/presentation/widgets/custom_animated_list.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  late AnimationController? _controller;
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
    //     _createBottomBannerAd();
    // });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _controller!.forward();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getLastUpdate(context);
    });
    super.initState();
  }

  getLastUpdate(context) {
    Provider.of<PostProvider>(context, listen: false).getPostsFromDB(context);
    Provider.of<PostProvider>(context, listen: false)
        .getBreakingNewsPostsFromDB(context);
    Provider.of<PostProvider>(context, listen: false)
        .getNewsCategoriesFromDB(context);
    Provider.of<PostProvider>(context, listen: false)
        .getPopularNewsPostsFromDB(context);
  }

  getLastNews() {
    Provider.of<PostProvider>(context, listen: false).getPostsFromDB(context);
  }

  getPostsByCategory(String category) {
    if (category.isNotEmpty) {
      Provider.of<PostProvider>(context, listen: false)
          .getNewsByCategoryFromDB(context, category);
    }
  }

  @override
  void dispose() {

    if(_controller != null) _controller!.dispose();
    if(_topBannerAd != null) _topBannerAd!.dispose();
    super.dispose();
  }

  BannerAd? _topBannerAd;
  bool _isTopBannerAdLoaded = false;

  void _createBottomBannerAd() async{
    _topBannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHepler.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (_) {

        setState(() {
          _isTopBannerAdLoaded = true;
        });
      }),
      request: AdRequest(),
    );
    await _topBannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<PostProvider>(context);
    var posts = Provider.of<PostProvider>(context).getPosts();
    var breakingNews =
        Provider.of<PostProvider>(context).getBreakingNewsPosts();

    return Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context),
      child: RefreshIndicator(
        onRefresh: () async {
          getLastUpdate(context);
        },
        child: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: [

            BrakingNewsSection(breakingNews: breakingNews),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: postProvider.getNewsCategories("All").length,
                  itemBuilder: (context, index) {
                    var category = postProvider.getNewsCategories("All")[index];
                    return CustomAnimatedList(
                      index: index,
                      child: Row(
                        children: [
                          index == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      postProvider.chooseCategory("");
                                      getPostsByCategory("");
                                      getLastNews();
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: !postProvider
                                                    .noCategoryChoosed()
                                                ? blueDefaultColor
                                                : const Color(0xfff6f6f7)),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "All ",
                                              style: GoogleFonts.inter(
                                                  fontSize: 17,
                                                  color: !postProvider
                                                          .noCategoryChoosed()
                                                      ? Colors.white
                                                      : const Color(
                                                          0xff808080)),
                                            ),
                                          ],
                                        )),
                                  ),
                                )
                              : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                postProvider.chooseCategory(category.id);
                                getPostsByCategory(category.categoryName!);
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: postProvider
                                              .isChoosedCategory(category.id)
                                          ? blueDefaultColor
                                          : const Color(0xfff6f6f7)),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${category.categoryName!} ",
                                        style: GoogleFonts.inter(
                                            fontSize: 17,
                                            color:
                                                postProvider.isChoosedCategory(
                                                        category.id)
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
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.recommandecforyou,
                    style: GoogleFonts.inter(fontSize: 25),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => MoreNewsOneScreen(
                                post: posts,
                              )));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.showmore,
                      style: GoogleFonts.inter(
                          fontSize: 15, color: const Color(0xff949191)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: getPhoneWidth(context),
              height: 130,
              child: PageView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: posts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CustomAnimatedList(
                      index: index,
                      duration: Duration(milliseconds: 300 + (index * 100)),
                      begin: 0.9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6.5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SingleNewsScreen(
                                      postModel: posts[index],
                                    )));
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              posts[index].image!))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            width: getPhoneWidth(context) - 180,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${posts[index].country} • ${posts[index].category!.categoryName}",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  getTimeFormat(
                                                      posts[index].createdAt!),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 13,
                                                      color: Colors.grey[600]),
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
                                        width: getPhoneWidth(context) - 150,
                                        child: Text(
                                          posts[index].title!,
                                          style: GoogleFonts.inter(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                        width: getPhoneWidth(context) - 150,
                                        child: Text(
                                          posts[index].subtitle!,
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
                                        width: getPhoneWidth(context) - 150,
                                        child: Text(
                                          getDateFormat(
                                              posts[index].createdAt!),
                                          style: GoogleFonts.inter(
                                              fontSize: 13,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w600),
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
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Popular news",
                    style: GoogleFonts.inter(fontSize: 25),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => MoreNewsOneScreen(
                                post: postProvider.getPopularNews(),
                              )));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.showmore,
                      style: GoogleFonts.inter(
                          fontSize: 15, color: const Color(0xff949191)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: getPhoneWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 208,
                      crossAxisCount: 2,
                      mainAxisSpacing: 1),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: postProvider.getPopularNews().length,
                  itemBuilder: (context, index) {
                    var post = postProvider.getPopularNews()[index];
                    return CustomAnimatedList(
                      index: index,
                      duration: Duration(milliseconds: 100 + (index * 300)),
                      begin: 0.95,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SingleNewsScreen(
                                      postModel: post,
                                    )));
                          },
                          child: Container(
                            width: getPhoneWidth(context) / 2 - 10,
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: getPhoneWidth(context) / 2 - 10,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(post.image!),
                                      )),
                                ),
                                Container(
                                  width: getPhoneWidth(context) / 2 - 10,
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: getPhoneWidth(context) / 2 - 10,
                                        child: Text(
                                          post.title!,
                                          style: GoogleFonts.inter(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                        width: getPhoneWidth(context) / 2 - 20,
                                        child: Text(
                                          getDateFormat(post.createdAt!),
                                          style: GoogleFonts.inter(
                                              fontSize: 13,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w600),
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
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
