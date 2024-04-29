import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/colors_consts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/features/presentation/providers/user_provider.dart';
import 'package:news_app/features/presentation/screens/credentials/login_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDark = false;

  logOut() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.removeUser();
    Navigator.pop(context);
  }

  deleteAccount() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.deleteAccount(context);
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context),
      padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.grey[200]!)),
                child: Icon(
                  Icons.person,
                  color: Colors.grey[200],
                  size: 65,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              userProvider.getUser() == null
                  ? const SizedBox()
                  : Text(
                      userProvider.getUser()!.username!,
                      style: GoogleFonts.poppins(fontSize: 25),
                    ),
              userProvider.getUser() != null
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const LoginScreen()));
                      },
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: blueDefaultColor),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: GoogleFonts.inter(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              userProvider.getUser() == null
                  ? const SizedBox()
                  : Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                  top: BorderSide(color: Colors.grey[300]!),
                                  bottom: BorderSide(color: Colors.grey[300]!),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person_outline_outlined,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Full name",
                                      style:
                                          GoogleFonts.inter(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      userProvider.getUser()!.fullName!,
                                      style: GoogleFonts.inter(
                                          color: Colors.grey[900]),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[300]!),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person_outline_outlined,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Username",
                                      style:
                                          GoogleFonts.inter(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      userProvider.getUser()!.username!,
                                      style: GoogleFonts.inter(
                                          color: Colors.grey[900]),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[300]!),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person_outline_outlined,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Email",
                                      style:
                                          GoogleFonts.inter(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      userProvider.getUser()!.email!,
                                      style: GoogleFonts.inter(
                                          color: Colors.grey[900]),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   _isDark = !_isDark;
                  // });

                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 20),
                          child: SingleChildScrollView(
                            child: Container(
                              width: getPhoneWidth(context),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "Ony light mode is available for this version",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: Colors.blueGrey[800],
                                        fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: getPhoneWidth(context) - 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: blueDefaultColor,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: Text(
                                          // AppLocalizations.of(context)!.select,
                                          "Leave",
                                          style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/dark-theme.svg",
                            width: 22,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppLocalizations.of(context)!.theme,
                            style: GoogleFonts.inter(color: Colors.grey),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _isDark
                                ? AppLocalizations.of(context)!.dark
                                : AppLocalizations.of(context)!.light,
                            style: GoogleFonts.inter(color: Colors.grey[900]),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 50,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: _isDark
                                            ? blueDefaultColor
                                            : Colors.grey)),
                              ),
                              AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  left: _isDark ? 23 : 0,
                                  height: 25,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      width: 22,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: _isDark
                                              ? blueDefaultColor
                                              : Colors.grey),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 20),
                          child: SingleChildScrollView(
                            child: Container(
                              width: getPhoneWidth(context),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "There is only one language for now.",
                                    style: GoogleFonts.poppins(
                                        color: Colors.blueGrey[800],
                                        fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: getPhoneWidth(context) - 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: blueDefaultColor,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: Text(
                                          // AppLocalizations.of(context)!.select,
                                          "Leave",
                                          style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: SvgPicture.asset(
                              "assets/icons/language.svg",
                              width: 18,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Text(
                            AppLocalizations.of(context)!.language,
                            style: GoogleFonts.inter(color: Colors.grey),
                          )
                        ],
                      ),
                      Text(
                        AppLocalizations.of(context)!.languagename,
                        style: GoogleFonts.inter(color: Colors.grey[900]),
                      )
                    ],
                  ),
                ),
              ),
              userProvider.getUser() == null
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 20),
                                child: SingleChildScrollView(
                                  child: Container(
                                    width: getPhoneWidth(context),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Are you sure you want to delete your account",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              color: Colors.blueGrey[800],
                                              fontSize: 21),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width:
                                                    getPhoneWidth(context) / 2 -
                                                        80,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: blueDefaultColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: Center(
                                                  child: Text(
                                                    // AppLocalizations.of(context)!.select,
                                                    "No",
                                                    style: GoogleFonts.inter(
                                                        color: Colors.white,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                deleteAccount();
                                              },
                                              child: Container(
                                                width:
                                                    getPhoneWidth(context) / 2 -
                                                        80,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blueGrey[800],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: Center(
                                                  child: Text(
                                                    // AppLocalizations.of(context)!.select,
                                                    "Yes",
                                                    style: GoogleFonts.inter(
                                                        color: Colors.white,
                                                        fontSize: 17),
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
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(color: Colors.grey[300]!),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Image.asset(
                                    "assets/icons/delete-icon.png",
                                    width: 18,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.deleteaccount,
                                  style: GoogleFonts.inter(color: Colors.red),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
          userProvider.getUser() == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey[100]),
                    child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  100.0), // Adjust the radius as needed
                            ),
                          ),
                        ),
                        onPressed: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, bottom: 25),
                                  child: Container(
                                    height: 70,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Are you sure ?",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.grey[100],
                                              ),
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<OutlinedBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                100.0), // Adjust the radius as needed
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("No")),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.grey[100],
                                              ),
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<OutlinedBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                100.0), // Adjust the radius as needed
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    logOut();
                                                  },
                                                   child: Text(
                                                    "Yes",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.red),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Logout",
                            style: GoogleFonts.poppins(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        )),
                  ),
                ),
        ],
      ),
    );
  }
}
