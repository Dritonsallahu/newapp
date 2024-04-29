import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/core/consts/widgets.dart';
import 'package:news_app/features/data/models/comment_model.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/providers/user_provider.dart';
import 'package:news_app/features/presentation/screens/single_news_screen.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final PostModel? postModel;
  const CommentsScreen({Key? key, required this.postModel}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController commentText = TextEditingController();
  List<CommentModel> _comments = [];
  getComments() async {
    var comment = await Provider.of<PostProvider>(context, listen: false)
        .getNewsCommentsPostFromDB(context, widget.postModel!.id);
    if (comment != null) {
      setState(() {
        _comments = comment;
      });
    }
  }

  addComment(String username, String commentText) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var hasUsername = userProvider.getUser() != null;
    var comment = await Provider.of<PostProvider>(context, listen: false)
        .commentPostFromDB(
            context,
            hasUsername ? userProvider.getUser()!.username! : username,
            commentText,
            widget.postModel!.id);
    if(comment != null){
      setState(() {
        _comments.insert(0,comment);
      });
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var hasUsername = userProvider.getUser() != null;
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: const Text("Post comments"),
          actions: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          width: getPhoneWidth(context),
                          height: 340,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: ListView(
                            children: [
                                CupertinoTextField(
                                placeholder: "Username",
                                readOnly: hasUsername,
                                controller: userProvider.getUser() != null
                                    ? TextEditingController(
                                    text: userProvider.getUser()!.username!)
                                    : username,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey[300]!)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CupertinoTextField(
                                  minLines: 8,
                                  maxLines: 10,
                                  controller: commentText,
                                  placeholder: "Add new comment...",
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                      Border.all(color: Colors.grey[300]!))),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  addComment(username.text, commentText.text);
                                },
                                child: Container(
                                  width: getPhoneWidth(context),
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });

              },
               child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(right: 0),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
            ),
             ),
            SizedBox(width: 10,),
          ],
        ),
        body: body(),
      );
    } else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
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
                      left: 6.0, right: 6.0, top: 6.0, bottom: 6.0),
                  child: SvgPicture.asset(
                    "assets/icons/back-icon.svg",
                    color: const Color(0xff323232),
                  ),
                ),
              ),
            ),
          ),
          middle: const Text("Posts comments"),
          trailing: GestureDetector(
            onTap: () {

                showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          width: getPhoneWidth(context),
                          height: 340,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            children: [
                              CupertinoTextField(
                                placeholder: "Username",
                                readOnly: hasUsername,
                                controller: userProvider.getUser() != null
                                    ? TextEditingController(
                                        text: userProvider.getUser()!.username!)
                                    : username,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey[300]!)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CupertinoTextField(
                                  minLines: 8,
                                  maxLines: 10,
                                  controller: commentText,
                                  placeholder: "Add new comment...",
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Colors.grey[300]!))),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if(username.text.isNotEmpty && commentText.text.isNotEmpty){
                                    addComment(username.text, commentText.text);
                                  }


                                },
                                child: Container(
                                  width: getPhoneWidth(context),
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });

            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(right: 0),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ),
        child: body(),
      );
    }
  }

  body() {
    return Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context),
      padding: const EdgeInsets.only(top: 7),
      child: ListView(
        children: [
          _comments.isEmpty
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
                  itemCount: _comments.length,
                  itemBuilder: (context, index) {
                    var comment = _comments[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6.5),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey[300]),
                                child: const Center(child: Icon(Icons.person,color: Colors.grey,),),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.grey[400],
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        SizedBox(
                                          width: getPhoneWidth(context) - 125,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${comment.username} ",
                                                style: GoogleFonts.inter(
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                getTimeFormat(
                                                    comment.updatedAt!),
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
                                        comment.comment!,
                                        style: GoogleFonts.inter(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                      width: getPhoneWidth(context) - 150,
                                      child: Text(
                                        getDateFormat(comment.updatedAt!),
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
                    );
                  })
        ],
      ),
    );
  }
}
