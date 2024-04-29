import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/core/strings/news_categories_strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/screens/more_news_one_screen.dart';
import 'package:news_app/features/presentation/screens/single_news_screen.dart';
import 'package:news_app/features/presentation/widgets/custom_animated_list.dart';
import 'package:provider/provider.dart';

class BrakingNewsSection extends StatefulWidget {
  final List<PostModel>? breakingNews;
  const BrakingNewsSection({Key? key, this.breakingNews}) : super(key: key);

  @override
  State<BrakingNewsSection> createState() => _BrakingNewsSectionState();
}

class _BrakingNewsSectionState extends State<BrakingNewsSection> {


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.breakingnews,
                style: GoogleFonts.inter(fontSize: 25),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => MoreNewsOneScreen(
                        post: widget.breakingNews,
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
        SizedBox(
          width: getPhoneWidth(context),
          height: 220,
          child: ListView.builder(
              padding: const EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: widget.breakingNews!.length,
              itemBuilder: (context, index) {
                return CustomAnimatedList(
                  index: index,
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  begin: 0.95,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SingleNewsScreen(postModel: widget.breakingNews![index],)));
                      },
                      child: Container(
                        width: getPhoneWidth(context) - 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken),
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.breakingNews![index].image!)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [


                                Text(
                                  "MMC ${widget.breakingNews![index].continent ?? ""}",
                                  style: GoogleFonts.inter(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.breakingNews![index].subtitle!,maxLines: 3,
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
