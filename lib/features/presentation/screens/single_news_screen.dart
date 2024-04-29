import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/core/consts/widgets.dart';
import 'package:news_app/core/themes/light_mode_theme.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/screens/comments_screen.dart';
import 'package:news_app/features/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';

class SingleNewsScreen extends StatefulWidget {
  final PostModel? postModel;
  const SingleNewsScreen({Key? key, this.postModel}) : super(key: key);

  @override
  State<SingleNewsScreen> createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
  PostModel? postModel;
  bool fetching = false;
  bool saving = false;
  bool liking = false;
  getPostInfo() async {
    setState(() => fetching = true);
    var a = await Provider.of<PostProvider>(context, listen: false)
        .getPostByIdFromDB(context, widget.postModel!.id);
    setState(() {
      postModel = a;
    });
    setState(() => fetching = false);
  }

  saveNewPost(String post) async {
    setState(() => saving = true);
    await Provider.of<PostProvider>(context, listen: false)
        .saveNewPostToDB(context, post);
    setState(() => saving = false);
    getPostInfo();
  }

  likePost() async {
    setState(() => liking = true);
    await Provider.of<PostProvider>(context, listen: false)
        .likePostFromDB(context, widget.postModel!.id);
    setState(() => liking = false);
  }

  @override
  void initState() {
    getPostInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<PostProvider>(context);
    print(postProvider.isPostSaved(widget.postModel!));
    if (Platform.isAndroid) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 65,
          leading: Padding(
            padding: EdgeInsets.only(left: Platform.isAndroid ? 8 : 0),
            child: leadingIcon(context, isNewPage: true),
          ),
          centerTitle: true,
          title: Text(
            widget.postModel!.continent ?? widget.postModel!.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,

          ),
          actions: [
            GestureDetector(
                onTap: () {
                  saveNewPost(widget.postModel!.id);
                },
                child: saving
                    ? const CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Colors.blue,
                      )
                    : Image.asset("assets/icons/save-icon.png",width: 30,)),
            SizedBox(width: Platform.isAndroid ? 17:0)
          ],
        ),
        body: body(context),
      );
    } else {
      return CupertinoPageScaffold(
          backgroundColor: lightThemeData(context).scaffoldBackgroundColor,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: lightThemeData(context).scaffoldBackgroundColor,
            leading: leadingIcon(context, isNewPage: true),
            // trailing: trailingIcons(),
            automaticallyImplyMiddle: true,
            automaticallyImplyLeading: true,
            middle: SizedBox(
                width: 200,
                child: Center(
                    child: Text(
                  widget.postModel!.continent ?? widget.postModel!.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))),
            trailing: GestureDetector(
              onTap: () {
                if(!postProvider.isPostSaved(widget.postModel!)){

                  saveNewPost(widget.postModel!.id);
                }

              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      width: saving ? 45 : 50,
                      color: Colors.transparent,
                      child: postProvider.isPostSaved(widget.postModel!)
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: saving
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: Colors.blue,
                                    )
                                  : Image.asset(
                                      "assets/icons/save-icon.png",
                                      width: 22,
                                    ),
                            )),
                  !postProvider.isPostSaved(widget.postModel!)
                      ? const SizedBox()
                      : Text("Saved")
                ],
              ),
            ),
            border: Border.all(color: Colors.white),
          ),
          child: body(context));
    }
  }

  body(context) {
    return Stack(
      children: [
        Container(
          width: getPhoneWidth(context),
          height: getPhoneHeight(context),
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: RefreshIndicator(
            onRefresh: () async {
              getPostInfo();
            },
            child: ListView(
              padding: const EdgeInsets.only(top: 10, bottom: 80),
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/mmc-logo.png"))),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "MMC • ${widget.postModel!.continent ?? "NEWS"} - ${getDateFormat(widget.postModel!.updatedAt!)}",
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          "${widget.postModel!.country ?? "World"}",
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: getPhoneWidth(context),
                  height: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.postModel!.image!))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.postModel!.title!,
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.postModel!.subtitle!,
                  style: GoogleFonts.inter(
                      color: Colors.blueGrey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.postModel!.content!,
                  style: GoogleFonts.inter(
                    color: Colors.blueGrey[800]!.withOpacity(0.85),
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            width: getPhoneWidth(context),
            bottom: fetching ? -50 : 20,
            curve: Curves.easeIn,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // infoModal("This features are not available for now!", context);
                },
                child: Container(
                  width: getPhoneWidth(context) * 0.6,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 10)
                      ]),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!liking) {
                                likePost();
                              }
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xffe3e3e5).withOpacity(0.6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.6),
                                child: SvgPicture.asset(
                                  "assets/icons/heart.svg",
                                  color: const Color(0xff303131),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.postModel!.likesNumber ?? "0"}",
                            style: GoogleFonts.inter(color: Colors.grey[800]),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => CommentsScreen(
                                        postModel: widget.postModel,
                                      )));
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xffe3e3e5).withOpacity(0.6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  "assets/icons/message.svg",
                                  color: const Color(0xff303131),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.postModel!.commentsNumber ?? "0"}",
                            style: GoogleFonts.inter(color: Colors.grey[800]),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              infoModal(
                                  "This feature is now available for now!",
                                  context);
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xff3057ff),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  "assets/icons/headset.svg",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
