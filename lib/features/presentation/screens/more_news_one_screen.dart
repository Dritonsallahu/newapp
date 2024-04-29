import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/core/consts/widgets.dart';
import 'package:news_app/core/themes/light_mode_theme.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/presentation/screens/single_news_screen.dart';
import 'package:news_app/features/presentation/widgets/general_widgets.dart';

class MoreNewsOneScreen extends StatefulWidget {
  final List<PostModel>? post;
  const MoreNewsOneScreen({Key? key, this.post}) : super(key: key);

  @override
  State<MoreNewsOneScreen> createState() => _MoreNewsOneScreenState();
}

class _MoreNewsOneScreenState extends State<MoreNewsOneScreen> {
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
              child: leadingIcon(context,isNewPage: true),
            ),
            centerTitle: true,
            title: Text("News",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
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
                  "News",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))),
            border: Border.all(color: Colors.white),
          ),
          child: body(context));
    }
  }

  body(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: widget.post!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6.5),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SingleNewsScreen(
                            postModel: widget.post![index],
                          )));
                },
                child: Container(
                  width: getPhoneWidth(context),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: getPhoneWidth(context),
                            height: 220,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(widget.post![index].image!),
                                )),
                          ),
                          Positioned(
                              width: getPhoneWidth(context),
                              
                              bottom: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.red,
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        widget
                                            .post![index].category!.categoryName!,
                                         style: GoogleFonts.poppins(
                                            color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: getPhoneWidth(context) - 25,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                      color: Colors.black.withOpacity(0.4),

                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text(
                                      widget.post![index].title!,
                                      maxLines: 2,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
