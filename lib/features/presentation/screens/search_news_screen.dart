import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/core/consts/widgets.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/data/models/saved_post_model.dart';
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/screens/single_news_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/features/presentation/widgets/custom_animated_list.dart';
import 'package:provider/provider.dart';

class SearchNewsScreen extends StatefulWidget {
  const SearchNewsScreen({Key? key}) : super(key: key);

  @override
  State<SearchNewsScreen> createState() => _SearchNewsScreenState();
}

class _SearchNewsScreenState extends State<SearchNewsScreen> {
  final TextEditingController _titleController = TextEditingController();
  Timer? _debounce;
  getSavedPosts(String title) {
    Provider.of<PostProvider>(context, listen: false)
        .searchNewsFromDB(context,title);
  }

  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          title: const Text("Notifications"),
        ),
        body: body(),
      );
    } else {
      return CupertinoPageScaffold(
        navigationBar:   CupertinoNavigationBar(
          backgroundColor: Colors.white,
          border: Border.all(color: Colors.transparent),
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
          middle: CupertinoTextField(
            onChanged: (value){
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                // This code will run after a delay of 1 second
                getSavedPosts(value);
              });
            },
            placeholder: AppLocalizations.of(context)!.search,
            placeholderStyle: GoogleFonts.inter(color: Colors.grey),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xfff6f6f7)),
            suffix: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.search,color: Colors.grey,),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10),
          ),
          trailing: const SizedBox(width: 20,),
        ),
        child: body(),
      );
    }
  }
  body(){
    var news = Provider.of<PostProvider>(context).getSearchedNewsList();
    print(news.length);
    return Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context),
      padding: const EdgeInsets.only(top: 7),
      child: ListView(
        children: [
          news.isEmpty
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No posts found!",
                style: GoogleFonts.nunito(color: Colors.grey[900]),
              ),
            ],
          )
              : ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: news.length,
              itemBuilder: (context, index) {
                var post = news[index];
                return CustomAnimatedList(
                  index: index,
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  begin: 0.85,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6.5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>   SingleNewsScreen(postModel: post,)));
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
                                      image: NetworkImage(post.image!))),
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
                                            color: Colors.green),
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
                                              "${post.continent} - ${post.category!.categoryName}",
                                              style: GoogleFonts.inter(
                                                  fontSize: 13),
                                            ),
                                            Text(
                                              getTimeFormat(post.updatedAt!),
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
                                    width: getPhoneWidth(context) - 150,
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
                                    width: getPhoneWidth(context) - 150,
                                    child: Text(
                                      getDateFormat(post.updatedAt!),
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
              })
        ],
      ),
    );
  }
}
