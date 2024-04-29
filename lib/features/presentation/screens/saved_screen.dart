import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/core/consts/widgets.dart';
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/screens/single_news_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/features/presentation/widgets/custom_animated_list.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  getSavedPosts() {
    Provider.of<PostProvider>(context, listen: false)
        .getSavedNewsFromDB(context);
  }

  @override
  void initState() {
    getSavedPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var posts =
        Provider.of<PostProvider>(context).getSavedPosts();

    var postProvider = Provider.of<PostProvider>(context);
    return Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context),
      padding: const EdgeInsets.only(top: 7),
      child: RefreshIndicator(
        onRefresh: () async {
          getSavedPosts();
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: Column(
                children: [
                  CupertinoTextField(
                    onChanged: (value){
                      postProvider.filterSavedPost(value);
                    },
                    placeholder: AppLocalizations.of(context)!.search,
                    placeholderStyle: GoogleFonts.inter(color: Colors.grey),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xfff6f6f7)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            posts.isEmpty
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
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  var post = posts[index];
                  return CustomAnimatedList(
                    index: index,
                    duration: Duration(milliseconds: 100 + (index * 100)),
                    begin: 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6.5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>   SingleNewsScreen(postModel: post.post,)));
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
                                        image: NetworkImage(post.post!.image!))),
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
                                                "${post.post!.continent} - ${post.post!.category!.categoryName}",
                                                style: GoogleFonts.inter(
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                getTimeFormat(post.post!.updatedAt!),
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
                                        post.post!.title!,
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
                                        post.post!.subtitle!,
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
                                        getDateFormat(post.post!.updatedAt!),
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
      ),
    );
  }

}
